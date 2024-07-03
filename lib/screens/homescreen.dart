import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/screens/homescreen_controller.dart';
import 'package:weather/screens/weather_detail_screen.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/loaders/loader.dart';
import 'package:weather/utils/loaders/skeleton_loading.dart';
import 'package:weather/utils/utility.dart';
import 'package:weather/widgets/custom_button.dart';
import 'package:weather/widgets/custom_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService weatherService = WeatherService(apiKey);
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Weather? weather;
  List<String> searchHistory = [];
  final getxController = Get.put(HomescreenController());

  @override
  void initState() {
    super.initState();
    fetchWeather(); // Fetch weather data on initialization
    loadSearchHistory(); // Load search history on initialization
  }

  // Fetches weather data and updates the state
  Future<void> fetchWeather() async {
    try {
      setState(() {
        weather = null; // Show loading indicator
      });
      String cityName = await weatherService.getCurrentCity();
      Weather newWeather = await weatherService.getWeatherDetails(cityName);
      setState(() {
        weather = newWeather; // Update with new weather data
      });
    } catch (e) {
      print(e.toString()); // Log error
    }
  }

  // Loads search history from shared preferences
  Future<void> loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  // Saves a search query to shared preferences
  Future<void> saveSearchHistory(String searchQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? [];

    searchHistory.remove(searchQuery); // Remove duplicate
    searchHistory.insert(0, searchQuery); // Add new query at the top

    // Limit history to 10 items
    if (searchHistory.length > 10) {
      searchHistory = searchHistory.sublist(0, 10);
    }

    await prefs.setStringList(
        'searchHistory', searchHistory); // Save updated history
  }

  // Navigates to weather detail screen with search query
  void navigateToWeatherDetail() async {
    if (controller.text.isNotEmpty) {
      _focusNode.unfocus(); // Hide keyboard
      getxController.isSearching.value = true;
      String searchQuery =
          controller.text.trim().toLowerCase().capitalizeFirst!;
      try {
        Weather weatherDetails =
            await weatherService.getWeatherDetails(searchQuery);
        controller.clear(); // Clear search input
        await saveSearchHistory(searchQuery); // Save search query
        getxController.isTyping.value = !getxController.isTyping.value;
        getxController.isSearching.value = !getxController.isSearching.value;

        // Navigate to weather detail screen
        Get.to(
          () => WeatherDetailScreen(weather: weatherDetails),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      } catch (exp) {
        Utility().showErrorSnackbar("Error", "Please enter correct city name");
        getxController.isTyping.value = !getxController.isTyping.value;
        getxController.isSearching.value = !getxController.isSearching.value;
      }
    }
  }

  // Navigates to weather detail screen using saved search
  void navigateToWeatherDetailsUsingSavedSearch(String cityname) async {
    _focusNode.unfocus(); // Hide keyboard
    getxController.isSearching.value = !getxController.isSearching.value;
    Weather weatherDetails = await weatherService.getWeatherDetails(cityname);

    await saveSearchHistory(cityname); // Save search query
    getxController.isTyping.value = !getxController.isTyping.value;
    getxController.isSearching.value = !getxController.isSearching.value;

    // Navigate to weather detail screen
    Get.to(
      () => WeatherDetailScreen(weather: weatherDetails),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff404471),
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus(); // Hide keyboard if tapped outside
          }
        },
        child: RefreshIndicator(
          displacement: 0,
          onRefresh: fetchWeather, // Refresh weather data on pull down
          child: weather == null
              ? buildWeatherUISkeletonLoading() // Show loading skeleton
              : Obx(
                  () => getxController.isSearching.isTrue
                      ? Positioned(
                          bottom: deviceHeight * 0.45,
                          left: deviceWidth * 0.3,
                          child: const WeatherLoader())
                      : ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CustomTextfield(
                                          controller: controller,
                                          focusNode: _focusNode)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomButton(
                                        onPressed: navigateToWeatherDetail),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() => getxController.isTyping.value
                                ? SizedBox(
                                    height: searchHistory.isNotEmpty ? 200 : 0,
                                    child: ListView.builder(
                                      itemCount: searchHistory.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            searchHistory[index],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          onTap: () {
                                            navigateToWeatherDetailsUsingSavedSearch(
                                                searchHistory[index]);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                  )),
                            GestureDetector(
                                onTap: () {
                                  if (getxController.isTyping.isTrue) {
                                    getxController.isTyping.value =
                                        !getxController.isTyping.value;

                                    _focusNode.unfocus(); // Hide keyboard
                                  }
                                },
                                child: Utility().buildWeatherUI(weather!)),
                          ],
                        ),
                ),
        ),
      ),
    );
  }
}
