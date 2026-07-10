import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// 日志管理类
///
/// 封装了对logger库的使用，提供了不同级别的日志记录方法
/// 可以根据环境自动调整日志输出级别
class LogManager {
  // 单例模式
  static final LogManager _instance = LogManager._internal();

  factory LogManager() => _instance;

  // /// 获取默认日志记录器
  // Logger get logger => _logger;

  // 默认日志记录器
  late Logger _logger;

  LogManager._internal() {
    _initLogger();
  }

  /// 初始化日志记录器
  void _initLogger() {
    // 创建默认日志记录器
    _logger = Logger(
      level: kDebugMode ? Level.all : Level.info,
      filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
      printer: PrefixPrinter(
        PrettyPrinter(
          colors: false,
          methodCount: kDebugMode ? 2 : 6,
          // printEmojis: false,
          stackTraceBeginIndex: 1,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      ),
      output: MyConsoleOutput(),
    );
  }

  /// 记录跟踪信息（通常用于记录对象）
  void t(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  /// 记录调试信息
  void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// info以下方法会在release环境记录日志
  /// ----------------------------------------------------------
  /// 记录信息
  void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// 记录警告
  void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 记录错误
  void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 记录致命错误
  void f(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

class MyConsoleOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    if (kDebugMode) {
      for (var str in event.lines) {
        developer.log(str); // 这种方式，如果控制台有系统报错内容会阻塞日志输出。
      }

      // event.lines.forEach(debugPrint); // 打印不全
      // event.lines.forEach(print); // 打印不全
    }

    // 以后需要日志信息可以这里收集。
  }
}

/// 全局日志实例，方便直接调用
final log = LogManager();
