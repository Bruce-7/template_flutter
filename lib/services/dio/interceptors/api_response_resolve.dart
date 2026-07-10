import 'package:dio/dio.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/services/models/api_response.dart';

// 自定义解析ApiResponse响应和错误处理拦截器
class ApiResponseResolveInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 自定义ApiResponse解析
    if (response.requestOptions.headers[kAPIResponse] == true && response.data != null) {
      final tempResponse = ApiResponse.fromJson(response.data as Map<String, dynamic>, (_) {});

      if (tempResponse.isSuccess) return handler.next(response);

      throw DioException(
        requestOptions: response.requestOptions,
        error: tempResponse,
        response: response,
        type: DioExceptionType.unknown,
        message: tempResponse.message,
      );
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // log.e('原始错误：$err');

    // 自定义ApiResponse解析
    if (err.requestOptions.headers[kAPIResponse] == true) {
      if (err.error is ApiResponse) {
        handler.next(err);
        return;
      }

      final response = err.response;
      if (response?.data != null && response?.data is Map<String, dynamic>) {
        final tempResponse = ApiResponse.fromJson(response!.data as Map<String, dynamic>, (_) {});

        err = DioException(
          requestOptions: err.requestOptions,
          error: tempResponse,
          response: response,
          type: err.type,
          stackTrace: err.stackTrace,
          message: err.message,
        );
      }
    }

    handler.next(err);
  }
}
