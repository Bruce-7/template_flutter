// 环境枚举
import 'package:flutter/foundation.dart';
import 'package:flutter_app/constants/env.dart';

enum Environment {
  test1,
  test2,
  production,
}

class DioConfig {
  static final DioConfig _instance = DioConfig._internal();

  factory DioConfig() {
    return _instance;
  }

  DioConfig._internal();

  static DioConfig get instance => _instance;

  // 当前环境
  Environment? _environment;

  // 各环境对应的基础URL
  final Map<Environment, String> _hostList = {
    Environment.test1: 'http://127.0.0.1:8000',
    Environment.test2: 'http://192.168.31.65:8000',
    Environment.production: 'https://api.your.com',
  };

  // 获取当前环境的host
  String get host {
    _environment ??= _getEnvironmentFromDefine();
    return _hostList[_environment] ?? '';
  }

  // 切换环境
  void setEnvironment(Environment env) {
    _environment = env;
  }

  // 手动设置自定义host
  void setCustomHost(String url) {
    _environment ??= _getEnvironmentFromDefine();
    _hostList[_environment!] = url;
  }

  // 更新特定环境的host
  void updateHost(Environment env, String url) {
    _hostList[env] = url;
  }

  // 从编译时参数获取环境配置
  Environment _getEnvironmentFromDefine() {
    if (_environment != null) {
      return _environment!;
    }

    switch (Env.envAPI.toLowerCase()) {
      case 'test1':
        return Environment.test1;

      case 'test2':
        return Environment.test2;

      case 'production':
        return Environment.production;

      default:
        // 默认根据调试模式决定
        return kDebugMode ? Environment.test1 : Environment.production;
    }
  }
}
