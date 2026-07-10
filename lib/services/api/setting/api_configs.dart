import 'package:flutter_app/models/configs.dart';
import 'package:flutter_app/services/dio/dio_client.dart';
import 'package:flutter_app/services/models/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_configs.g.dart';

/// 根据类型获取配置项
@riverpod
Future<ApiResponse<List<Config>>> apiGetConfigsByType(
  Ref ref, {
  required ConfigType type,
}) async {
  final response = await apiClient.request<ApiResponse<List<Config>>>(
    '/setting/configs/get_by_type/',
    DioClientMethod.get,
    queryParameters: {'type': type.toJson()},
    fromJson: (json) => ApiResponse<List<Config>>.fromJson(
      json,
      (data) => (data as List).map((item) => Config.fromJson(item as Map<String, dynamic>)).toList(),
    ),
  );

  return response;
}
