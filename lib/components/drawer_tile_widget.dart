import 'package:flutter/material.dart';

class DrawerTileWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function()? onTap;
  const DrawerTileWidget(
      {super.key, required this.text, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        onTap: onTap,
      ),
    );
  }
}
