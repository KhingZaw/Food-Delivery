import 'package:flutter/material.dart';
import 'package:food_delivery/services/auth/setupLocator.dart';
import 'package:food_delivery/services/auth/user_repository.dart';

class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  final UserRepository _userRepository = locator<UserRepository>();
  void logOut() async {
    await _userRepository.singOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Delivery"),
        centerTitle: true,
        leading: IconButton(onPressed: logOut, icon: Icon(Icons.logout)),
      ),
    );
  }
}
