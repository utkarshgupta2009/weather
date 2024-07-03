import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/screens/homescreen.dart';

class WeatherSplashScreen extends StatefulWidget {
  const WeatherSplashScreen({Key? key}) : super(key: key);

  @override
  _WeatherSplashScreenState createState() => _WeatherSplashScreenState();
}

class _WeatherSplashScreenState extends State<WeatherSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    // Listen for animation completion to navigate to home screen
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => const HomeScreen()); // Navigate to home screen
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff404471), Colors.blue.shade600],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Load and play Lottie animation
              Lottie.asset(
                'assets/weather_animation.json',
                controller: _controller,
                height: 200,
                animate: true,
                onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward(); // Start the animation
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
