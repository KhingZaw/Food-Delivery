import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget(
      {super.key, required this.controller, required this.labelText});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
  final TextEditingController controller;
  final String labelText;
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPasswordHidden = !isPasswordHidden;
              });
            },
            icon: Icon(
                isPasswordHidden ? Icons.visibility_off : Icons.visibility),
          ),
        ),
        obscureText: isPasswordHidden,
      ),
    );
  }
}
