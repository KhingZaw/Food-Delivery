import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/components/button_widget.dart';
import 'package:food_delivery/components/text_field_widget.dart';
import 'package:food_delivery/screens/auth_screens/register_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  //declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final UserRepository _userRepository = locator<UserRepository>();
  void _submit() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      final success =
          await _userRepository.resetPassword(email: emailController.text);
      setState(() {
        isLoading = false;
      });
      if (success) {
        Fluttertoast.showToast(
            msg:
                "We have sent you an email to recover password, please check email");
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } else {
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

                Text(
                  "Forget Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                TextFieldWidget(
                  controller: emailController,
                  labelText: 'Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ButtonWidget(
                        text: "Send Rest Password",
                        onTap: _submit,
                      ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => RegisterScreen(forgetPassword: true),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
