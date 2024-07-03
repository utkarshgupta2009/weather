import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/utils/constants.dart';

class AdditionalWeatherDetailsContainer extends StatelessWidget {
  final Weather weather; // Weather object containing the additional details

  const AdditionalWeatherDetailsContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.25, // Set container height based on device height
      width: deviceWidth * 0.9, // Set container width based on device width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Rounded corners
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff84b9fc), Color(0xff5a94e6)], // Background gradient colors
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow with slight opacity
            blurRadius: 10,
            offset: const Offset(0, 5), // Position of the shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Space out the children evenly
        children: [
          // Title of the additional details section
          Text(
            "Additional Details",
            style: _textStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10), // Spacing between title and details
          // Display humidity detail
          _buildDetailRow(Icons.water_drop, "Humidity", "${weather.humidity}%"),
          // Display wind speed detail
          _buildDetailRow(Icons.air, "Wind Speed", "${weather.windSpeed} m/s"),
        ],
      ),
    );
  }

  // Helper method to build each detail row
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 24), // Icon representing the detail
        const SizedBox(width: 10), // Space between icon and label
        Expanded(
          child: Text(label, style: _textStyle(fontSize: 18)), // Detail label
        ),
        Text(value, style: _textStyle(fontSize: 18, fontWeight: FontWeight.w600)), // Detail value
      ],
    );
  }

  // Helper method to define text style
  TextStyle _textStyle({double fontSize = 21, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      fontSize: fontSize * (deviceWidth / 375), // Adjust font size based on device width
      color: Colors.white, // White text color
      fontWeight: fontWeight, // Font weight
    );
  }
}
