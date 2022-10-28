import "package:flutter/material.dart";
import 'package:notification_tutorial/data/services/api_service/api_client.dart';
import 'package:notification_tutorial/data/services/api_service/api_provider.dart';
import 'package:notification_tutorial/ui/widgets/custom_app_bar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: const CustomAppBar(title: 'Test Page'),
      body: const SizedBox(),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        print("dfghjkl;kjhgfdcxvbhjklkjh");
        await ApiService(apiClient: ApiClient()).postNotification(
            title: 'asdf', desc: 'desc', todoType: '', createdAt: 'createdAt');
      }),
    );
  }
}
