import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notification_tutorial/data/models/cached_todo_model.dart';
import 'package:notification_tutorial/data/models/notification_model.dart';

class HiveService {
  // SINGLETON
  HiveService.init();

  static final HiveService _instance = HiveService.init();

  static HiveService get instance => _instance;

  // CREATE DATABASE
  late Box databox;

  Future createBox() async {
    try {
      databox = await Hive.openBox('todo');
    } catch (error) {
      debugPrint('HIVE ERROR: $error');
    }
  }

  // METHODS OF HIVE
  List<CachedTodoModel> getCachedTodos() {
    return databox.values.toList().cast<CachedTodoModel>();
  }

  Future addData(
    CachedTodoModel todoModel,
  ) async {
    try {
      await databox.add(todoModel);
      print("SUCCESS SAVED : ${todoModel.title}");
    } catch (error) {
      debugPrint('HIVE ADD ERROR: $error');
    }
  }

  Future<void> deleteAllCachedTodos() async {
    await databox.clear();
  }
}
