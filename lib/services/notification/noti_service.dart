import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  static final NotiService _instance = NotiService._internal();

  factory NotiService() => _instance;

  NotiService._internal();

  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initNotifications() async {
    if (_isInitialized) return; // Prevent re-initialization

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    final DarwinInitializationSettings initSettingsIOS =
        DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    bool? initialized = await notificationPlugin.initialize(initSettings);
    _isInitialized = initialized ?? false;

    print("Notification Plugin Initialized: $_isInitialized");
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    if (!_isInitialized) {
      print("Error: Notification plugin not initialized!");
      return;
    }

    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'chat_channel',
        'Chat Notifications',
        channelDescription: 'Notifications for chat messages',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await notificationPlugin.show(id, title, body, details);
  }
}
