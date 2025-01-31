import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/auth/setupLocator.dart';
import 'package:food_delivery/services/auth/user_repository.dart';

class DeliveryInfo extends StatefulWidget {
  final String email;
  const DeliveryInfo({super.key, required this.email});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  final UserRepository _userRepository = locator<UserRepository>();
  Map<String, dynamic>? deliveryUser;
  @override
  void initState() {
    super.initState();
    fetchDeliveryUser();
  }

  Future<void> fetchDeliveryUser() async {
    final user = await _userRepository.getEmail(widget.email);
    setState(() {
      deliveryUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Info"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          // Display Profile Image
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: deliveryUser!["image_url"] != null
                  ? MemoryImage(
                      base64Decode(
                        deliveryUser!["image_url"],
                      ),
                    ) // Decode and show the image
                  : const AssetImage("assets/images/logo/logo_icon.png")
                      as ImageProvider,
            ),
          ),
          const SizedBox(height: 25),
          // Display additional user info
          Text(
            deliveryUser?["name"] ?? "Name not available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            deliveryUser?["email"] ?? "Email not available",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            deliveryUser?["phone_number"] ?? "Phone number not available",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            deliveryUser?["role"] ?? "role not available",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ],
      ),
    );
  }
}
