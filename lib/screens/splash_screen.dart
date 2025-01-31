import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/repository/auth_gate.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePart = Provider.of<ThemeProvider>(context);
    return AnimatedSplashScreen(
      splash: Center(
        child: LottieBuilder.asset(
          imagePart.logoPath,
          fit: BoxFit.cover,
        ),
      ), // Add your logo path

      backgroundColor: Theme.of(context).colorScheme.surface,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250, // Size of the splash image
      duration: 4000, // Duration in milliseconds
      nextScreen: AuthGate(), // The next screen to navigate
    );
  }
}
