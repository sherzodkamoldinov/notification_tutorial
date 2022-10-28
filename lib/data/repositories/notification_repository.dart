import 'package:notification_tutorial/data/models/cached_todo_model.dart';
import 'package:notification_tutorial/data/models/notification_model.dart';
import 'package:notification_tutorial/data/services/api_service/api_provider.dart';
import 'package:notification_tutorial/data/services/local_service/local_service.dart';

class NotificationRepository {
  NotificationRepository({required ApiService apiService})
      : _apiService = apiService;
  final ApiService _apiService;


  Future<bool> postNotification(
          {required NotificationModel notificationModel}) =>
      _apiService.postNotification(
        title: notificationModel.title,
        desc: notificationModel.desc,
        createdAt: notificationModel.createdAt,
        todoType: notificationModel.todoType,
      );
}
