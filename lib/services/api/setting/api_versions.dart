import 'package:flutter_app/models/versions_check.dart';
import 'package:flutter_app/services/dio/dio_client.dart';
import 'package:flutter_app/services/models/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_versions.g.dart';

/// 检查版本更新
@riverpod
Future<ApiResponse<VersionsCheck>> apiVersionsCheck(
  Ref ref, {
  required AppPlatform platform,
  required int versionCode,
  required String versionName,
}) async {
  final data = {
    'platform': platform.toJson(),
    'version_code': versionCode,
    'version_name': versionName,
  };

  final response = await apiClient.request<ApiResponse<VersionsCheck>>(
    '/setting/versions/check/',
    DioClientMethod.post,
    data: data,
    fromJson: (json) => ApiResponse<VersionsCheck>.fromJson(
      json,
      (data) => VersionsCheck.fromJson(data as Map<String, dynamic>),
    ),
  );

  return response;
}
