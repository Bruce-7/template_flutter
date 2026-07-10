import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/services/dio/dio_cache_manager.dart';
import 'package:flutter_app/services/models/api_response.dart';

// 缓存拦截器
class CacheInterceptor extends Interceptor {
  final DioCacheManager _cacheManager = DioCacheManager();

  // 缓存时间，默认5秒钟
  final Duration maxAge;

  CacheInterceptor({
    this.maxAge = const Duration(seconds: 5),
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 只缓存GET请求
    if (options.method != 'GET') {
      return handler.next(options);
    }

    // 检查缓存
    final String cacheKey = DioCacheManager.generateCacheKey(options);
    final Response? cachedResponse = _cacheManager.getCache(cacheKey, maxAge: maxAge);

    if (cachedResponse != null) {
      log.i('使用缓存: $cacheKey\n'
          '响应状态码: ${cachedResponse.statusCode}'
          '\n响应数据: ${jsonEncode(cachedResponse.data)}');

      // 如果存在缓存，直接返回缓存数据
      return handler.resolve(cachedResponse);
    }

    // 没有缓存或缓存过期，继续请求
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode ?? 0;

    // 只缓存GET请求和成功的响应
    if (response.requestOptions.method == 'GET' && (statusCode >= 200 && statusCode < 300)) {
      if (response.requestOptions.headers[kAPIResponse] == true) {
        final tempResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>, (_) {});

        if (!tempResponse.isSuccess) {
          // 如果是自定义响应，失败不缓存。
          return handler.next(response);
        }
      }

      // 所有成功响应都缓存
      final String cacheKey = DioCacheManager.generateCacheKey(response.requestOptions);
      _cacheManager.setCache(cacheKey, response);
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type != DioExceptionType.cancel) {
      final String cacheKey = DioCacheManager.generateCacheKey(err.requestOptions);
      final Response? cachedResponse = _cacheManager.getCache(cacheKey);

      if (cachedResponse != null) {
        log.i('使用缓存: $cacheKey\n'
            '响应状态码: ${cachedResponse.statusCode}'
            '\n响应数据: ${jsonEncode(cachedResponse.data)}');
        return handler.resolve(cachedResponse);
      }
    }

    return handler.next(err);
  }
}
