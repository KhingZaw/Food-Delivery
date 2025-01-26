import 'package:flutter/material.dart';
import 'package:food_delivery/components/button_widget.dart';
import 'package:food_delivery/components/password_field_widget.dart';
import 'package:food_delivery/components/text_field_widget.dart';
import 'package:food_delivery/screens/auth_screens/register_role_screen.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  //login method
  void login() async {
    setState(() {
      isLoading = true;
    });
    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords don't match!")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterRoleScreen(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePart = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              LottieBuilder.asset(imagePart.logoPath, height: 200, width: 200),

              //message, app slogan
              Text(
                "Let's create an account for you",
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

              const SizedBox(
                height: 10,
              ),
              //password textfield
              PasswordFieldWidget(
                  controller: passwordController, labelText: "Password"),

              const SizedBox(
                height: 10,
              ),
              // confirm password textfield
              PasswordFieldWidget(
                  controller: confirmPasswordController,
                  labelText: "Confirm Password"),

              const SizedBox(
                height: 25,
              ),
              //sign up button
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
              //already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login here",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
