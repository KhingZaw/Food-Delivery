import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/user_screens/cart_screen.dart';
import 'package:provider/provider.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  const MySliverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, _) {
      int userCart = restaurant.cart.length;
      return SliverAppBar(
        expandedHeight: 340,
        collapsedHeight: 120,
        floating: false,
        pinned: true,
        actions: [
          // Cart button with badge
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 7),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.blue,
              shape: badges.BadgeShape.circle,
              padding: const EdgeInsets.all(6),
              borderRadius: BorderRadius.circular(8),
            ),
            badgeAnimation: const badges.BadgeAnimation.slide(
              animationDuration: Duration(milliseconds: 200),
            ),
            showBadge: userCart > 0,
            badgeContent: Text(
              '$userCart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
            //card button
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                //go to cart screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Sunset Diner"),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          title: title,
          centerTitle: true,
          background: Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: this.child,
          ),
          titlePadding: EdgeInsets.only(left: 0, right: 0, top: 0),
          expandedTitleScale: 1,
        ),
      );
    });
  }
}
