import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/button_widget.dart';
import 'package:food_delivery/components/text_field_widget.dart';
import 'package:food_delivery/screens/delivery_screens/delivery_home_screen.dart';
import 'package:food_delivery/screens/user_screens/home_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class RegisterRoleScreen extends StatefulWidget {
  final String email;
  final String password;

  const RegisterRoleScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  _RegisterRoleScreenState createState() => _RegisterRoleScreenState();
}

class _RegisterRoleScreenState extends State<RegisterRoleScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? profileImage; //changed from URl to file
  String selectedRole = "User";
  bool isLoading = false;

  final UserRepository _userRepository = locator<UserRepository>();

  //Pick and Upload Image**
  Future<void> pickAndUploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  void completeRegistration() async {
    setState(() {
      isLoading = true;
    });
    if (profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a profile picture.")),
      );
      return;
    }
    try {
      await _userRepository.signUpUser(
        widget.email,
        widget.password,
        nameController.text,
        selectedRole,
        phoneController.text,
        profileImage!, // Passing the correct File object
      );

      setState(() {
        isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful!")),
      );

      // Navigate based on role
      if (selectedRole.toLowerCase() == "delivery") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DeliveryHomeScreen()),
        );
      } else if (selectedRole.toLowerCase() == "user") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Signup Failed"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!) // Show picked image
                    : AssetImage("assets/images/logo/logo_icon.png")
                        as ImageProvider,
              ),
              const SizedBox(height: 20),
              // Upload Button
              ElevatedButton(
                onPressed: pickAndUploadImage,
                child: const Text("Upload Profile Picture"),
              ),
              const SizedBox(
                height: 25,
              ),
              //message, app slogan
              Text(
                "your name and choose role!",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              const SizedBox(
                height: 25,
              ),
              //name textfield
              TextFieldWidget(
                controller: nameController,
                labelText: 'Name',
                obscureText: false,
              ),

              const SizedBox(
                height: 10,
              ),
              //phone number textfield
              TextFieldWidget(
                controller: phoneController,
                labelText: 'Phone Number',
                obscureText: false,
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Role",
                    labelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  items: ["User", "Delivery"].map(
                    (role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(
                          role,
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //sign in button
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ButtonWidget(
                      text: "Complete Register",
                      onTap: completeRegistration,
                    ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
