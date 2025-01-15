import 'package:flutter/material.dart';
import 'package:food_delivery/models/food.dart';

class MyTapBar extends StatelessWidget {
  final TabController tapController;
  const MyTapBar({super.key, required this.tapController});

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split(".").last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: _buildCategoryTabs(),
        controller: tapController,
      ),
    );
  }
}
