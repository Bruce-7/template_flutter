// import 'package:flutter_app/database/database.dart';
// import 'package:flutter_app/services/dio/dio_client.dart';
// import 'package:flutter_app/services/models/api_response.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'api_user.g.dart';
//
// /// 用户登录
// @riverpod
// Future<ApiResponse<UserTableData>> apiUserLogin(Ref ref, {required String username, required String password}) async {
//   final data = {
//     'username': username,
//     'password': password,
//   };
//
//   final response = await apiClient.post<ApiResponse<UserTableData>>(
//     '/api/auth/login',
//     data: data,
//     fromJson: (json) => ApiResponse<UserTableData>.fromJson(
//       json,
//       (data) => UserTableData.fromJson(data as Map<String, dynamic>),
//     ),
//   );
//
//   return response;
// }
//
// /// 用户退出
// @riverpod
// Future<ApiResponse> apiUserLogout(Ref ref, {required String userID}) async {
//   final data = {
//     'user_id': userID,
//   };
//
//   final response = await apiClient.post<ApiResponse>(
//     '/api/auth/logout',
//     data: data,
//     fromJson: (json) => ApiResponse.fromJson(json, (data) => data),
//   );
//
//   return response;
// }
