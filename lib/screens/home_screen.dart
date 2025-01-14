import 'package:flutter/material.dart';
import 'package:food_delivery/components/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
    );
  }
}
