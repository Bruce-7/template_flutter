import 'dart:io';

import 'package:flutter_app/managers/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbManager {
  // 单例模式
  static final DbManager _instance = DbManager._internal();

  factory DbManager() => _instance;

  late SharedPreferences _prefs;

  // late AppDatabase _database;
  late Directory _documentsDir;

  DbManager._internal() {
    // _database = AppDatabase.connect();
  }

  // AppDatabase get database => _database;

  SharedPreferences get prefs => _prefs;

  Directory get documentsDir => _documentsDir;

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _documentsDir = await getApplicationDocumentsDirectory();

      log.d('$this 初始化成功');
    } catch (error) {
      log.e('$this 初始化失败: $error');
    }
  }
}

/// 全局db实例，方便直接调用
final dbManager = DbManager();
