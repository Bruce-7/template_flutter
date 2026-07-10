part of 'page.dart';

extension ExamplePageFunction on ExamplePage {
  /// 日志管理器使用示例
  void _loggerExample() {
    // 使用全局日志实例
    log.t({'key': 5, 'value': '这是一个 trace 测试日志'});

    log.d('这是一条调试信息');

    log.i('这是一条信息');

    log.w('这是一条警告信息');

    log.e('这是一条错误信息', error: '测试错误');

    log.f('这是一条严重错误信息');
  }
}
