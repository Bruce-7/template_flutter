import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/managers/logger.dart';

// 日志拦截器
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var data = options.data;
    if (data is Map) {
      data = jsonEncode(data);
    }

    log.i('请求: ${options.method} ${options.uri}'
        '\n请求头: ${jsonEncode(options.headers)}'
        '\n请求数据: $data');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('响应请求: ${response.requestOptions.method} ${response.requestOptions.uri}'
        '\n响应状态码: ${response.statusCode}'
        '\n响应信息: ${response.toString()}');

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var message = '';

    if (err.error != null) {
      message += err.error.toString();
    }

    if (err.message?.isNotEmpty == true) {
      message += err.message!;
    }

    log.e('响应请求: ${err.requestOptions.method} ${err.requestOptions.uri}'
        '\n响应信息: ${err.response?.toString()}'
        '\n错误类型: ${err.type}'
        '\n错误信息: $message');

    return handler.next(err);
  }
}
