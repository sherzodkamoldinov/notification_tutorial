import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notification_tutorial/cubit/cubit/notification_cubit.dart';
import 'package:notification_tutorial/data/models/cached_todo_model.dart';
import 'package:notification_tutorial/data/models/notification_model.dart';
import 'package:notification_tutorial/data/repositories/notification_repository.dart';
import 'package:notification_tutorial/data/services/api_service/api_client.dart';
import 'package:notification_tutorial/data/services/api_service/api_provider.dart';
import 'package:notification_tutorial/data/services/local_service/local_service.dart';
import 'package:notification_tutorial/local_notification_service.dart';
import 'package:notification_tutorial/ui/router.dart';
import 'package:notification_tutorial/utils/consts.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("HANDLING A BACKGROUND MESSAGE: ${message.data}");
}

void main() async {
  // CRETE WIDGET TREE
  WidgetsFlutterBinding.ensureInitialized();

  // INITIALIZE HIVE
  await Hive.initFlutter();
  Hive.registerAdapter(CachedTodoModelAdapter());

  // CREATE DATABASE
  await HiveService.instance.createBox();

  // ANOTHER TREE
  await Firebase.initializeApp();

  LocalNotificationService.localNotificationService.init();

  // BACKGROUND NOTFICATION LISTEN
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // SUBSCRIBE TO TOPIC
  await FirebaseMessaging.instance.subscribeToTopic("todos");

  runApp(
    RepositoryProvider(
      create: (context) => NotificationRepository(
        apiService: ApiService(
          apiClient: ApiClient(),
        ),
      ),
      child: BlocProvider(
        create: (context) => NotificationCubit(
          notificationRepository: context.read<NotificationRepository>(),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // background
    FirebaseMessaging.onMessageOpenedApp.listen(backgroundHandleMessage);
    // terminated
    onTerminated();
    // foreground
    onForeground();
    super.initState();
  }

  Future<void> onForeground() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint("Foreground: ${message.notification!.title}");
        LocalNotificationService.localNotificationService
            .showLocalNotification(message);
        saveNotification(message);
        // Navigator.pushNamed(context, message.data['route']);
      },
    );
  }

  Future<void> onTerminated() async {
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((remoteMessage) async {
      if (remoteMessage != null) {
        debugPrint("O TERMINATED: ${remoteMessage.notification!.title}");
        LocalNotificationService.localNotificationService
            .showLocalNotification(remoteMessage);
        saveNotification(remoteMessage);
        // Navigator.pushNamed(context, remoteMessage.data["route"]);
      }
    });
  }

  Future<void> backgroundHandleMessage(RemoteMessage message) async {
    debugPrint("ON MESSAGE OPENED APP: ${message.notification!.title}");
    saveNotification(message);
    // Navigator.pushNamed(context, message.data["route"]);
  }

  void saveNotification(RemoteMessage message) async {
    var todo = message.data;
    await BlocProvider.of<NotificationCubit>(context).addTodo(todo);
  }

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
