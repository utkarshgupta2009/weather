import 'dart:convert';
import 'package:weather/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/utils/utility.dart';

class WeatherService {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  // Fetches weather details for a given city name
  Future<Weather> getWeatherDetails(String cityname) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityname&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body)); // Parse JSON response
    } else {
      
      throw Exception("Error while loading data");
      // Handle error response
    }
  }

  // Fetches the current city based on the device's GPS location
  Future<String> getCurrentCity() async {
    try {
      // Check and request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Get the current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get the placemarks (including city name) for the coordinates
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract and return the city name
      String? city = placemark[0].locality;
      return city ?? "";
    } catch (exp) {
      Utility().showErrorSnackbar("Error", "Cannot get current city");
      return "";
    }
  }
}
