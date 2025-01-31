import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/screens/delivery_screens/delivery_home_screen.dart';
import 'package:food_delivery/screens/user_screens/home_screen.dart';
import 'package:food_delivery/screens/auth_screens/login_or_register.dart';
import 'package:food_delivery/services/auth/setupLocator.dart';
import 'package:food_delivery/services/auth/user_repository.dart';

class AuthGate extends StatelessWidget {
  final UserRepository _userRepository = locator<UserRepository>();
  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return FutureBuilder<String?>(
              future: _userRepository.getUserAndRole(user.uid),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final role = roleSnapshot.data?.toLowerCase();

                if (role == 'delivery') {
                  return const DeliveryHomeScreen();
                } else if (role == 'user') {
                  return const HomeScreen();
                }

                return const LoginOrRegister();
              },
            );
          }

          // User is not logged in
          return const LoginOrRegister();
        },
      ),
    );
  }
}
