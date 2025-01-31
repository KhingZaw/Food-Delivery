import 'package:flutter/material.dart';
import 'package:food_delivery/components/drawer_tile_widget.dart';
import 'package:food_delivery/screens/user_screens/profile_screen.dart';
import 'package:food_delivery/screens/user_screens/settings_screen.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/services/repository/user_repository.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final UserRepository _userRepository = locator<UserRepository>();

  void logOut() async {
    await _userRepository.singOutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //app Logo
          Padding(
            padding: EdgeInsets.only(top: 50, left: 50),
            child: SizedBox(
              height: 150,
              width: 200,
              child: Image.asset(
                "assets/images/logo/logo_icon.png",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          //profile screen
          DrawerTileWidget(
            text: "P R O F I L E",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: Icons.person,
          ),
          //home list title
          DrawerTileWidget(
            text: "H O M E",
            onTap: () => Navigator.pop(context),
            icon: Icons.home,
          ),
          DrawerTileWidget(
            text: "S E T T I N G S",
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: Icons.settings,
          ),
          const Spacer(),
          DrawerTileWidget(
            text: "L O G O U T",
            onTap: logOut,
            icon: Icons.logout,
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
