import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/utility.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather; // Weather data to display
  const WeatherContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.5, // Set the container height to 50% of device height
      width: deviceWidth * 0.8, // Set the container width to 80% of device width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Rounded corners
        color: const Color(0xff84b9fc), // Background color
        boxShadow: Utility().getBoxShadow(weather.mainInformation), // Dynamic box shadow based on weather
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
        children: [
          Flexible(
            child: Text(
              " ${weather.cityName}, ${weather.countryName}", // Display city and country name
              style: TextStyle(
                fontSize: 27 * (deviceWidth / 375), // Responsive font size
                color: Colors.white, // Text color
              ),
            ),
          ),
          Flexible(
            flex: 4, // Allocate more space for animation
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0), // Bottom padding
              child: Lottie.asset(
                Utility().getWeatherAnimation(weather.mainInformation), // Weather animation
              ),
            ),
          ),
          Flexible(
            child: Text(
              "${weather.temperature.ceil()}°C", // Display temperature
              style: TextStyle(
                fontSize: 30 * (deviceWidth / 375), // Responsive font size
                color: Colors.white, // Text color
              ),
            ),
          ),
          Flexible(
            child: Text(
              weather.mainInformation, // Display main weather information
              style: TextStyle(
                fontSize: 15 * (deviceWidth / 375), // Responsive font size
                color: Colors.white, // Text color
              ),
            ),
          ),
          SizedBox(height: 10), // Space between elements
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
              children: [
                _buildTempInfo("Feels", weather.feelsLike), // Display "Feels like" temperature
                SizedBox(width: 20), // Space between temperature details
                _buildTempInfo("Min", weather.tempMin), // Display minimum temperature
                SizedBox(width: 20), // Space between temperature details
                _buildTempInfo("Max", weather.tempMax), // Display maximum temperature
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build temperature information row
  Widget _buildTempInfo(String label, double temp) {
    return Column(
      children: [
        Text(
          label, // Label for temperature (e.g., "Feels", "Min", "Max")
          style: TextStyle(
            fontSize: 12 * (deviceWidth / 375), // Responsive font size
            color: Colors.white70, // Text color
          ),
        ),
        Text(
          "$temp°C", // Display temperature value
          style: TextStyle(
            fontSize: 14 * (deviceWidth / 375), // Responsive font size
            color: Colors.white, // Text color
          ),
        ),
      ],
    );
  }
}
