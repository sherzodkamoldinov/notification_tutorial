import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_tutorial/cloud_notification_page.dart';
import 'package:notification_tutorial/local_notification_service.dart';
import 'package:notification_tutorial/ui/router.dart';
import 'package:notification_tutorial/ui/splash_screen/splash_page.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/consts.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("HANDLING A BACKGROUND MESSAGE: ${message.data}");
}

void main() async {
  // CRETE WIDGET TREE
  WidgetsFlutterBinding.ensureInitialized();

  // ANOTHER TREE
  await Firebase.initializeApp();
  
  LocalNotificationService.localNotificationService.init();

  // BACKGROUND NOTFICATION LISTEN
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        
         useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: MyGenerateRouter.generateRoute,
      initialRoute: splashPage,
    );
  }
}