import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notification_tutorial/data/services/api_service/api_client.dart';
import 'package:notification_tutorial/utils/consts.dart';

class ApiService {
  ApiService({required this.apiClient});

  ApiClient apiClient;

  Future<bool> postNotification({
    required String title,
    required String desc,
    required String todoType,
    required String createdAt,
  }) async {
    try {
      Response response = await apiClient.dio.post(
        "${apiClient.dio.options.baseUrl}$endPointUrl",
        data: {
          "to": "/topics/todos",
          "notification": {"title": "TODO", "body": "New TODO"},
          "data": {
            "title": title,
            "desc": desc,
            "todo_type": todoType,
            "created_at": createdAt,
            "route": "/main_page"
          }
        },
      );

      if (response.data['message_id'] != null) {
        debugPrint('RESPONSE DATA: ${response.data}');
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
