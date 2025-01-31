import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:food_delivery/screens/splash_screen.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/services/notification/noti_service.dart';
import 'package:food_delivery/services/repository/setupLocator.dart';
import 'package:food_delivery/themes/theme_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Handle Firebase initialization error
    print('Firebase initialization failed: $e');
  }

  // Initialize dependencies
  setupLocator();

  // Request Notification Permission (after Firebase initializes)
  await requestNotificationPermission();

  // Initialize notifications
  await NotiService().initNotifications();

  FlutterNativeSplash.remove();
  runApp(MultiProvider(
    providers: [
      // theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      // restaurant provider
      ChangeNotifierProvider(create: (context) => Restaurant()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

// Function to request notification permission
Future<void> requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    print("✅ Notification permission granted");
  } else if (status.isDenied) {
    print("⚠️ Notification permission denied");
  } else if (status.isPermanentlyDenied) {
    print(
        "🚫 Notification permission permanently denied. Open settings to enable it.");
    openAppSettings();
  }
}
