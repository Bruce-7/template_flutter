import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

// 请求拦截器 - 用于添加统一的请求头、认证信息等
class RequestInterceptor extends Interceptor {
  final PackageInfo? packageInfo;

  RequestInterceptor({this.packageInfo});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 统一添加请求头
    options.headers['Accept'] = 'application/json';

    // 添加应用信息到请求头
    if (packageInfo != null) {
      options.headers['X-App-Name'] = Uri.encodeFull(packageInfo!.appName);
      options.headers['X-Package-Name'] = packageInfo!.packageName;
      options.headers['X-Version-Name'] = packageInfo!.version;
      options.headers['X-Version-Code'] = packageInfo!.buildNumber;

      // 添加平台信息
      if (Platform.isAndroid) {
        options.headers['X-Platform'] = 'android';
      } else if (Platform.isIOS) {
        options.headers['X-Platform'] = 'ios';
      } else if (Platform.isMacOS) {
        options.headers['X-Platform'] = 'macos';
      } else if (Platform.isWindows) {
        options.headers['X-Platform'] = 'windows';
      } else if (Platform.isLinux) {
        options.headers['X-Platform'] = 'linux';
      } else {
        options.headers['X-Platform'] = 'other';
      }
    }

    // 如果有认证令牌,添加到请求头
    final String? token = _getAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  // 获取认证令牌的方法,实际项目中可能从本地存储获取
  String? _getAuthToken() {
    // TODO: Hse7enD - 实现从共享首选项或安全存储中获取令牌
    return ''; // 临时返回空
  }
}
