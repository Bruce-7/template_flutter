import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/services/dio/dio_config.dart';
import 'package:flutter_app/services/dio/interceptors/api_response_resolve.dart';
import 'package:flutter_app/services/dio/interceptors/cache.dart';
import 'package:flutter_app/services/dio/interceptors/logging.dart';
import 'package:flutter_app/services/dio/interceptors/request.dart';
import 'package:flutter_app/services/models/api_response.dart';
import 'package:flutter_app/utils/common.dart';

enum DioClientMethod {
  get,
  post,
  put,
  delete,
}

class DioClient {
  static final DioClient _instance = DioClient._internal();

  // 根据host缓存dio
  final Map<String, Dio> _dioCache = {};

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _getDio();
  }

  Dio _getDio({String? host}) {
    String finalHost = host ?? DioConfig.instance.host;
    assert(finalHost.isNotEmpty, '需要设置host');

    Dio? dio = _dioCache[finalHost];

    if (dio == null) {
      Map<String, dynamic> headers = {};
      if (finalHost == DioConfig.instance.host) {
        headers[kAPIResponse] = true;
      }

      // 默认等超时都是15秒
      final BaseOptions options = BaseOptions(
        baseUrl: finalHost,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: headers,
        contentType: 'application/json; charset=utf-8',
        responseType: ResponseType.json,
      );

      dio = Dio(options);

      // 添加缓存拦截器（防止2秒短时间内重复请求，目前只有GET请求做了缓存）
      dio.interceptors.add(CacheInterceptor(
        maxAge: const Duration(seconds: 2),
      ));

      // 添加请求/响应拦截器
      dio.interceptors.add(RequestInterceptor());

      // 添加自定义解析ApiResponse响应和错误处理拦截器
      dio.interceptors.add(ApiResponseResolveInterceptor());

      // 添加日志拦截器（放在最后，收集最全信息，以上拦截器需要继续调用handler往后专递）
      dio.interceptors.add(LoggingInterceptor());

      _dioCache[finalHost] = dio;
    }

    return dio;
  }

  // 网络请求
  Future<T> request<T>(
    String path,
    DioClientMethod method, {
    String? host,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isUnify = false, // 是否统一错误处理
    T Function(Map<String, dynamic> json)? fromJson, // 用于处理ApiResponse自定义解析。
  }) async {
    try {
      Dio dio = _getDio(host: host);

      final Response response;

      switch (method) {
        case DioClientMethod.get:
          response = await dio.get(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case DioClientMethod.post:
          response = await dio.post(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case DioClientMethod.put:
          response = await dio.put(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case DioClientMethod.delete:
          response = await dio.delete(
            path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
          );
          break;
      }

      if (fromJson != null && response.data != null && response.data is Map<String, dynamic>) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      return response.data as T;
    } catch (e) {
      log.e('$this：$e');

      if (fromJson != null) {
        ApiResponse response = _handleError(e, isUnify);
        return fromJson(response.toJson((data) => data.toJson()));
      }

      rethrow;
    }
  }

  // 文件下载
  Future<T> download<T>(
    String urlPath,
    String savePath, {
    String? host,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool isUnify = true, // 是否统一错误处理
    T Function(Map<String, dynamic> json)? fromJson, // 用于处理ApiResponse自定义解析。
  }) async {
    try {
      Dio dio = _getDio(host: host);

      final Response response = await dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (fromJson != null && response.data is Map<String, dynamic>) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      return response.data as T;
    } catch (e) {
      if (fromJson != null) {
        ApiResponse response = _handleError(e, isUnify);
        return fromJson(response.toJson((data) => data.toJson()));
      }

      rethrow;
    }
  }

  // 文件上传
  Future<T> uploadFile<T>(
    String path,
    File file, {
    String? host,
    String? fileName,
    String? fileField = 'file',
    Map<String, dynamic>? formData,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    bool isUnify = true, // 是否统一错误处理
    T Function(Map<String, dynamic> json)? fromJson, // 用于处理ApiResponse自定义解析。
  }) async {
    try {
      final String name = fileName ?? file.path.split('/').last;

      final FormData form = FormData.fromMap({
        fileField!: await MultipartFile.fromFile(
          file.path,
          filename: name,
        ),
        if (formData != null) ...formData,
      });

      Dio dio = _getDio(host: host);

      final Response response = await dio.post(
        path,
        data: form,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );

      if (fromJson != null && response.data is Map<String, dynamic>) {
        return fromJson(response.data as Map<String, dynamic>);
      }

      return response.data as T;
    } catch (e) {
      if (fromJson != null) {
        ApiResponse response = _handleError(e, isUnify);
        return fromJson(response.toJson((data) => data.toJson()));
      }

      rethrow;
    }
  }

  // 返回true阻断抛错。
  ApiResponse _handleError(Object err, bool isUnify) {
    ApiResponse? response;

    if (err is DioException) {
      if (err.error is ApiResponse) {
        response = err.error as ApiResponse;
        if (isUnify) {
          switch (response.code) {
            // case ApiResponseCode.http404NotFound:
            //   // 指定错误可以指定某个弹窗提示示例。
            //   break;
            default:
              if (response.message?.isNotEmpty == true) {
                CommonUtil.showToast(response.message!.tr());
              }
              break;
          }
        }

        return response;
      }

      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          response = ApiResponse(code: ApiResponseCode.http408RequestTimeout, message: '网络连接超时，请检查您的网络连接'.tr());
          break;

        case DioExceptionType.badCertificate:
          response = ApiResponse(code: ApiResponseCode.badCertificate, message: '证书验证失败'.tr());
          break;

        case DioExceptionType.badResponse:
          response = ApiResponse(code: ApiResponseCode.http400BadRequest, message: '错误的请求'.tr());
          break;

        case DioExceptionType.cancel:
          response = ApiResponse(code: ApiResponseCode.cancel, message: '请求已取消'.tr());
          break;

        case DioExceptionType.connectionError:
          response = ApiResponse(code: ApiResponseCode.connectionError, message: '网络连接错误，请检查您的网络连接'.tr());
          break;

        case DioExceptionType.unknown:
          var tempMessage = '未知错误'.tr();
          if (err.message?.isNotEmpty == true) {
            tempMessage = err.message!;
          }

          response = ApiResponse(code: ApiResponseCode.unknown, message: tempMessage);
          break;
      }
    }

    response ??= ApiResponse(code: ApiResponseCode.unknown, message: '未知错误'.tr());

    if (isUnify) {
      if (response.message?.isNotEmpty == true) {
        CommonUtil.showToast(response.message!.tr());
      }
    }

    return response;
  }
}

/// 全局dioClient实例，方便直接调用
final apiClient = DioClient();
