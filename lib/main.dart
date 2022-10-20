import 'package:flutter/material.dart';
import 'package:notification_tutorial/home_page.dart';
import 'package:notification_tutorial/local_notification_service.dart';

void main() {
  // CRETE WIDGET TREE
  WidgetsFlutterBinding.ensureInitialized();
  // ANOTHER TREE
  LocalNotificationService.localNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
