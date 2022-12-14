import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_tutorial/local_notification_service.dart';


class FirebasePushNotificationPage extends StatefulWidget {
  const FirebasePushNotificationPage({super.key});

  @override
  State<FirebasePushNotificationPage> createState() =>
      _FirebasePushNotificationState();
}

class _FirebasePushNotificationState extends State<FirebasePushNotificationPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    String? FCMToken = await FirebaseMessaging.instance.getToken();
    debugPrint("FCMToken $FCMToken");

    // FOREGROUND NOTFICATION LISTEN
    FirebaseMessaging.onMessage.listen(
      LocalNotificationService().showLocalNotification,
    );

    // ON MESSAGE OPENED APP NOTFICATION LISTEN
    FirebaseMessaging.onMessageOpenedApp.listen(
      LocalNotificationService().showLocalNotification,
    );

    // WHEN APP TERMINATED NOTFICATION LISTEN
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('TERMINATED: ${message?.notification?.title}');
      if (message != null) {
        // do something
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              child: Text('get TOKEN'),
              onPressed: () async {
                final fcmToken = await FirebaseMessaging.instance.getToken();
                debugPrint(fcmToken);
              })
        ],
      ),
    );
  }
}
