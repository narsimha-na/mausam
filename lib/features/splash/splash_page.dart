import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mosam/core/constants/assets_constants.dart';
import 'package:mosam/core/constants/color_constants.dart';
import 'package:mosam/core/constants/font_constants.dart';
import 'package:mosam/core/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the rotation animation indefinitely

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            const Interval(0.5, 1.0, curve: Curves.easeOut), // Zoom out effect
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _controller.stop();
      context.goNamed(RouterConstants.homePage); // Navigate to HomePage
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _rotationAnimation,
                child: Image.asset(
                  ImageConstants.appIcon,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mosam',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: FontConstants.snigletRegular,
                  fontSize: 32,
                  color: ColorConstants.secondaryColor,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
