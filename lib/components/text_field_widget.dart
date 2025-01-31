import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          hintText: "",
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
