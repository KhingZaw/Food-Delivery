import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/auth/auth_gate.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: LottieBuilder.asset(
          "assets/images/logo/Animation_light - 1737205427052.json",
          fit: BoxFit.cover,
        ),
      ), // Add your logo path

      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250, // Size of the splash image
      duration: 4000, // Duration in milliseconds
      nextScreen: AuthGate(), // The next screen to navigate
    );
  }
}
