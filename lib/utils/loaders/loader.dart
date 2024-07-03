import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeatherLoader extends StatefulWidget {
  final double size;
  final Color color;

  const WeatherLoader({
    super.key,
    this.size = 50.0,
    this.color = Colors.yellow,
  });

  @override
  WeatherLoaderState createState() => WeatherLoaderState();
}

class WeatherLoaderState extends State<WeatherLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: Icon(
                Icons.wb_sunny,
                size: widget.size,
                color: widget.color,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text(
          'Getting latest updates',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
