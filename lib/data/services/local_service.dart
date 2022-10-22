import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveService {
  // SINGLETON
  HiveService.init();

  static final HiveService _instance = HiveService.init();

  static HiveService get instance => _instance;

  // CREATE DATABASE
  late Box<Map> databox;

  Future createBox() async {
    try {
      databox = await Hive.openBox('data');
    } catch (error) {
      debugPrint('HIVE ERROR: $error');
    }
  }

  // METHODS OF HIVE

  Future addData(Map data) async {
    try {
      await databox.add(data);
    } catch (error) {
      debugPrint('HIVE ADD ERROR: $error');
    }
  }
}
