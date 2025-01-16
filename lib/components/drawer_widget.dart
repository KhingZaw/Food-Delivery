import 'package:flutter/material.dart';
import 'package:food_delivery/components/drawer_tile_widget.dart';
import 'package:food_delivery/screens/settings_screen.dart';
import 'package:food_delivery/services/auth/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  void logOut() async {
    final _authService = AuthService();

    await _authService.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //app Logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
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
