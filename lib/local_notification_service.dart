import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
      LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() {
    // FOR ANDROID
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // FOR IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // SET
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  // FOR ANDROID
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('NOTIFICATION PAYLOAD: $payload');
    }
  }

  // FOR IOS
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    debugPrint('IOS PAYLOAD: $payload');
  }

  // CHANNEL
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel('myChannel', 'Notification Tutorial',
          importance: Importance.max,
          description: 'My Notification description');

  // without firebase
  void showLocalNotification(String data) {
    var id = Random().nextInt(100);
    flutterLocalNotificationsPlugin.show(
      id,
      'Notification title',
      'Notification body',
      NotificationDetails(
        android: AndroidNotificationDetails(
            androidNotificationChannel.id, androidNotificationChannel.name,
            priority: Priority.max,
            icon: 'app_icon', // app icon
            playSound: true,
            showProgress: true,
            largeIcon: const DrawableResourceAndroidBitmap('app_icon')),
      ),
      payload: data,
    );
  }

  // with firebase
  void showLocalNotificationWithRemoteMessage(
    RemoteMessage remoteMessage,
  ) {
    flutterLocalNotificationsPlugin.show(
      10,
      remoteMessage.notification?.title,
      remoteMessage.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          icon: 'app_icon', // app icon
          playSound: true,
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        ),
      ),
      payload: remoteMessage.data.toString(),
    );
  }

  void scheduleNotification({required DateTime dt}) async {
    var id = Random().nextInt(100);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Product qoshildi', // title
      'Product: ', // body
      tz.TZDateTime.from(dt, tz.local), // add time to now
      NotificationDetails(
          android: AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        channelDescription: 'To remind you about upcoming birthdays',
      )),
      payload: 'Notification Data',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showPeriodically() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      5,
      'repeating title',
      'repeating body',
      RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      androidAllowWhileIdle: true,
      payload: "DATA",
    );
  }

  void cancelAllNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
