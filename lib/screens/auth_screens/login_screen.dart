import 'package:flutter/material.dart';
import 'package:food_delivery/components/button_widget.dart';
import 'package:food_delivery/components/password_field_widget.dart';
import 'package:food_delivery/components/text_field_widget.dart';
import 'package:food_delivery/screens/auth_screens/forget_password.dart';
import 'package:food_delivery/screens/delivery_screens/delivery_home_screen.dart';
import 'package:food_delivery/screens/user_screens/home_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isLoading = false;

  final UserRepository _userRepository = locator<UserRepository>();

  //login method
  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Attempt to log in and fetch the user's role
      final String? role = await _userRepository.signInAndFetchRole(
        emailController.text,
        passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (role == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Failed: Role not found!")),
        );
        return;
      }

      // Navigate based on role
      if (role.toLowerCase() == "delivery") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => DeliveryHomeScreen()),
        );
      } else if (role.toLowerCase() == "user") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Failed: Invalid role!")),
        );
      }
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: Text(e.toString()),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePart = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                LottieBuilder.asset(imagePart.logoPath,
                    height: 200, width: 200),
                const SizedBox(
                  height: 25,
                ),
                //message, app slogan
                Text(
                  "Food Delivery App",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  height: 25,
                ),
                //email textfield
                TextFieldWidget(
                  controller: emailController,
                  labelText: 'Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                //password textfield
                PasswordFieldWidget(
                  controller: passwordController,
                  labelText: "Password",
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => ForgetPassword(),
                        ),
                      ),
                      child: Text("forgot password ?"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                //sign in button
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ButtonWidget(
                        text: "Sign Up",
                        onTap: login,
                      ),

                const SizedBox(
                  height: 25,
                ),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
