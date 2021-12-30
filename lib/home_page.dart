import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notis/services/local_notis.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationMsg = 'Waiting for notifications';

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initializePlugin();

    //terminated state
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg =
              '${event.notification!.title} ${event.notification!.body} I\'m coming from terminated state';
        });
      }
    });

    //foreground state
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.foregroundMessage(event);
      setState(() {
        notificationMsg =
            '${event.notification!.title} ${event.notification!.body} I\'m coming from foreground';
      });
    });

    //background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            '${event.notification!.title} ${event.notification!.body} I\'m coming from background';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
      ),
      body: Center(
        child: Text(
          notificationMsg,
        ),
      ),
    );
  }
}
