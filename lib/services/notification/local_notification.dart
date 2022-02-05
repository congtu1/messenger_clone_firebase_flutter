import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialise() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      print(payload);
    });
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    final notficationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.example.messenger_clone", "firebase_push_notification",
            importance: Importance.max, priority: Priority.high));
    _notificationPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notficationDetail);
  }
}
