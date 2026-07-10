// import 'package:flutter_app/models/user.dart';
// import 'package:flutter_app/services/dio/dio_client.dart';
// import 'package:flutter_app/services/models/api_response.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'api_test.g.dart';
//
// @riverpod
// Future<Map<String, dynamic>> apiServiceTest(Ref ref) async {
//   // 支持普通数据示例
//   final response = await apiClient.request<Map<String, dynamic>>(
//     '/posts/3',
//     DioClientMethod.get,
//     host: "https://jsonplaceholder.typicode.com",
//     isUnify: true,
//   );
//
//   return response;
// }
//
// @riverpod
// Future<ApiResponse<User?>> apiServiceTest1(Ref ref) async {
//   // 返回指定模型示例
//   final response = await apiClient.request<ApiResponse<User?>>(
//     '/m1/7070100-6790473-default/user',
//     DioClientMethod.get,
//     isUnify: true,
//     fromJson: (json) => ApiResponse<User?>.fromJson(
//       json,
//       (data) => User.fromJson(data as Map<String, dynamic>),
//     ),
//   );
//
//   return response;
// }
