import 'package:flutter/material.dart';
import 'package:notification_tutorial/local_notification_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // NOTIFICATION ID 1
          ElevatedButton(
            onPressed: () {
              LocalNotificationService.localNotificationService
                  .showLocalNotification('DATA 1', 1);
            },
            child: const Text('Get Notification ID 1'),
          ),

          // NOTIFICATION ID 2
          ElevatedButton(
            onPressed: () {
              LocalNotificationService.localNotificationService
                  .showLocalNotification('DATA 2', 2);
            },
            child: const Text('Get Notification ID 2'),
          ),

          // NOTIFICATION ID 3
          ElevatedButton(
            onPressed: () {
              LocalNotificationService.localNotificationService
                  .showLocalNotification('DATA 3', 3);
            },
            child: const Text('Get Notification ID 3'),
          ),

          // SCHEDULE NOTIFICATION
          ElevatedButton(
            onPressed: () {
              LocalNotificationService.localNotificationService
                  .scheduleNotification(5);
            },
            child: const Text('SCHEDULE Notification ID 4'),
          ),

          // PERIODICALLY NOTIFICATION
          ElevatedButton(
            onPressed: () {
              LocalNotificationService.localNotificationService
                  .showPeriodically();
            },
            child: const Text('Periodically Notification ID 5'),
          ),

          // CANCEL ALL NOTIFICATION AND BY ID
          Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: const Text('Cancel All Notification'),
                    onPressed: () {
                      LocalNotificationService.localNotificationService
                          .cancelAllNotification();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Cancel by ID'),
                    onPressed: () {
                      LocalNotificationService.localNotificationService
                          .cancelNotificationById(1);
                    },
                  ),
                ]),
          ),

          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
