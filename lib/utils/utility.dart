import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/widgets/additional_weather_details_container.dart';
import 'package:weather/widgets/weather_container.dart';

class Utility {
  getWeatherAnimation(String? mainInformation) {
    if (mainInformation == null) return 'assets/day.json';

    switch (mainInformation.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstrom.json';
      case 'clear':
        return 'assets/day.json';
      case 'snow':
        return 'assests/snow.json';
      default:
        return 'assets/cloud.json';
    }
  }

  List<BoxShadow> getBoxShadow(String mainInformation) {
    switch (mainInformation.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 50,
            spreadRadius: -5,
          ),
        ];

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 50,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ];

      case 'thunderstorm':
        return [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: Colors.indigo.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.yellow.withOpacity(0.2),
            blurRadius: 60,
            spreadRadius: -5,
            offset: const Offset(15, -15),
          ),
        ];

      case 'clear':
        return [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 15,
          ),
          BoxShadow(
            color: Colors.yellow.withOpacity(0.2),
            blurRadius: 60,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ];

      case 'snow':
        return [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 15,
          ),
          BoxShadow(
            color: Colors.lightBlue.withOpacity(0.2),
            blurRadius: 60,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ];

      default:
        return [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ];
    }
  }

  Widget buildWeatherAdvice(Weather weatherDetails) {
    String advice = 'Enjoy your day!';
    IconData iconData = Icons.wb_sunny;
    Color iconColor = Colors.yellow;

    if (weatherDetails.mainInformation.toLowerCase().contains('rain')) {
      advice = 'Don\'t forget your umbrella!';
      iconData = Icons.umbrella;
      iconColor = Colors.lightBlue;
    } else if (weatherDetails.temperature > 30) {
      advice = 'It\'s hot outside. Stay hydrated!';
      iconData = Icons.local_drink;
      iconColor = Colors.orange;
    } else if (weatherDetails.temperature < 10) {
      advice = 'It\'s cold. Dress warmly!';
      iconData = Icons.ac_unit;
      iconColor = Colors.lightBlue;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Advice",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(iconData, color: iconColor, size: 40),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  advice,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWeatherUI(Weather weatherDetails) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40), // Add some space at the top

            WeatherContainer(weather: weatherDetails),
            const SizedBox(height: 20),
            AdditionalWeatherDetailsContainer(weather: weatherDetails),
            const SizedBox(height: 20),
            buildWeatherAdvice(weatherDetails),
          ],
        ),
      ),
    );
  }

  void showErrorSnackbar(String error, String title) {
  Get.snackbar(
    error,
    title,
    snackPosition: SnackPosition.BOTTOM, // Position the snackbar at the bottom
    backgroundColor: const Color(0xff84b9fc), // Background color
    borderRadius: 20, // Rounded corners
    margin: const EdgeInsets.all(16), // Margin around the snackbar
    colorText: Colors.white, // Text color
    icon: const Icon(Icons.error, color: Color(0xffFF8911)), // Icon with color matching the app theme
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
    snackStyle: SnackStyle.FLOATING, // Make the snackbar floating
  );
}
}
