import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializePlugin() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    _localPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      print(payload);
    });
  }

  static void foregroundMessage(RemoteMessage message) async{
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.example.push_notis',
        'push_notis',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _localPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }
}
