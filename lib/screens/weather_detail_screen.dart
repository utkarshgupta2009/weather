import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/loaders/skeleton_loading.dart';
import 'package:weather/utils/utility.dart';
import 'package:weather/services/weather_service.dart';

class WeatherDetailScreen extends StatefulWidget {
  final Weather weather;
  const WeatherDetailScreen({super.key, required this.weather});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late Weather weatherDetails; // Stores the weather details to display
  final weatherService = WeatherService(apiKey);
  bool isLoading = false; // Indicates whether the weather data is loading

  @override
  void initState() {
    super.initState();
    weatherDetails =
        widget.weather; // Initialize weather details from the passed data
  }

  // Function to refresh the weather data
  Future<void> refreshWeather() async {
    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });
      final updatedWeather =
          await weatherService.getWeatherDetails(widget.weather.cityName);
      setState(() {
        weatherDetails = updatedWeather; // Update the weather details
        isLoading = false; // Hide loading indicator
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString()); // Print error in debug mode
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff404471),
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(weatherDetails.cityName,
            style: const TextStyle(color: Colors.white)),
        actions: [
          // Refresh button to refresh the weather data
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: refreshWeather,
          ),
        ],
      ),
      body: RefreshIndicator(
        displacement: 0,
        onRefresh: refreshWeather, // Pull-to-refresh functionality
        child: isLoading
            ? buildWeatherUISkeletonLoading() // Show loading skeleton while data is loading
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                    Utility().buildWeatherUI(weatherDetails)
                  ]), // Display weather data
      ),
    );
  }
}
