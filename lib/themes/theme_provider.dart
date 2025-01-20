import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery/themes/dark_mode.dart';
import 'package:food_delivery/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  String _logoPath = "assets/images/logo/Animation_dark - 1737205427052.json";

  // Getter for image path
  String get logoPath => _logoPath;

  ThemeProvider() {
    _loadTheme(); // Load theme preference when the provider is created
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveTheme(themeData == darkMode); // Save theme preference when it changes
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      _logoPath = "assets/images/logo/Animation_light - 1737205427052.json";
    } else {
      themeData = lightMode;
      _logoPath = "assets/images/logo/Animation_dark - 1737205427052.json";
    }
  }

  Future<void> _loadTheme() async {
    SharedPreferences themeSharedPreference =
        await SharedPreferences.getInstance();
    bool isDark = themeSharedPreference.getBool('isDarkMode') ??
        false; // Default to false
    if (isDark) {
      themeData = darkMode;
      _logoPath = "assets/images/logo/Animation_light - 1737205427052.json";
    } else {
      themeData = lightMode;
      _logoPath = "assets/images/logo/Animation_dark - 1737205427052.json";
    }
  }

  Future<void> _saveTheme(bool isDark) async {
    SharedPreferences themeSharedPreference =
        await SharedPreferences.getInstance();
    themeSharedPreference.setBool('isDarkMode', isDark);
  }
}
