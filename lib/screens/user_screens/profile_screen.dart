import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRepository _userRepository = locator<UserRepository>();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final data = await _userRepository.getCurrentUserData();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: userData!["image_url"] != null
                          ? MemoryImage(
                              base64Decode(
                                userData!["image_url"],
                              ),
                            )
                          : const AssetImage("assets/images/default_user.png")
                              as ImageProvider,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Name: ${userData!['name']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Email: ${userData!['email']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Phone: ${userData!['phone_number']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Role: ${userData!['role']}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                )
              : const Center(child: Text("No user data found")),
    );
  }
}
