import 'package:flutter/material.dart';
import 'package:weather/utils/constants.dart';

Widget buildWeatherUISkeletonLoading() {
  return  SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          
          // Skeleton for WeatherContainer
          SkeletonContainer(height: deviceHeight*0.5, width: deviceWidth*0.8),
          
          SizedBox(height: 20),
          
          // Skeleton for AdditionalWeatherDetailsContainer
          SkeletonContainer(height: deviceHeight * 0.25, width: deviceWidth*0.9),
          
          SizedBox(height: 20),
          
          // Skeleton for buildWeatherAdvice
          SkeletonContainer(height: 100, width: double.infinity),
        ],
      ),
    ),
  );
}

class SkeletonContainer extends StatelessWidget {
  final double height;
  final double width;

  const SkeletonContainer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const SkeletonAnimation(),
    );
  }
}

class SkeletonAnimation extends StatefulWidget {
  const SkeletonAnimation({Key? key}) : super(key: key);

  @override
  _SkeletonAnimationState createState() => _SkeletonAnimationState();
}

class _SkeletonAnimationState extends State<SkeletonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
              stops: [
                0.0,
                _animation.value,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}