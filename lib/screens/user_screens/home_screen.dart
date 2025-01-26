import 'package:flutter/material.dart';
import 'package:food_delivery/components/current_location_widget.dart';
import 'package:food_delivery/components/description_box.dart';
import 'package:food_delivery/components/drawer_widget.dart';
import 'package:food_delivery/components/food_tile.dart';
import 'package:food_delivery/components/my_sliver_app_bar.dart';
import 'package:food_delivery/components/my_tap_bar.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/user_screens/food_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;
  @override
  void initState() {
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //sort out and return  a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fulMenu) {
    return fulMenu.where((food) => food.category == category).toList();
  }

  //return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fulMenu) {
    return FoodCategory.values.map((category) {
      //get  category menu
      List<Food> categoryMenu = _filterMenuByCategory(category, fulMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          //get individual food
          final food = categoryMenu[index];

          //return food tile menu
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodScreen(food: food),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            title: MyTapBar(
              tapController: _tabController,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                //my current location
                CurrentLocationWidget(),

                //description box
                DescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) => TabBarView(
            controller: _tabController,
            children: getFoodInThisCategory(restaurant.menu),
          ),
        ),
      ),
    );
  }
}
