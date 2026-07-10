// import 'dart:convert';
// import 'dart:io';
//
// import 'package:crypto/crypto.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_app/managers/logger.dart';
//
// /// 数据库加密工具类
// class EncryptionUtil {
//   EncryptionUtil._();
//
//   static String? _cachedKey;
//
//   /// 获取数据库加密密钥
//   /// 基于设备唯一标识生成，确保每个设备的密钥不同
//   static Future<String> getDatabaseEncryptionKey() async {
//     if (_cachedKey != null) {
//       return _cachedKey!;
//     }
//
//     try {
//       final deviceInfo = DeviceInfoPlugin();
//       String deviceId = '';
//
//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfo.androidInfo;
//         // 使用设备唯一标识
//         deviceId = androidInfo.id;
//       } else if (Platform.isIOS) {
//         final iosInfo = await deviceInfo.iosInfo;
//         // 使用设备唯一标识
//         deviceId = iosInfo.identifierForVendor ?? '';
//       } else if (Platform.isMacOS) {
//         final macInfo = await deviceInfo.macOsInfo;
//         deviceId = macInfo.systemGUID ?? '';
//       } else if (Platform.isWindows) {
//         final windowsInfo = await deviceInfo.windowsInfo;
//         deviceId = windowsInfo.deviceId;
//       } else if (Platform.isLinux) {
//         final linuxInfo = await deviceInfo.linuxInfo;
//         deviceId = linuxInfo.machineId ?? '';
//       }
//
//       if (deviceId.isEmpty) {
//         log.w('无法获取设备唯一标识，使用默认密钥');
//         deviceId = 'default-device-id';
//       }
//
//       // 使用设备ID和应用特定盐值生成加密密钥
//       const appSalt = 'flutter-app-db-encryption-salt-2024';
//       final combinedString = '$deviceId-$appSalt';
//
//       // 使用SHA256生成固定长度的密钥
//       final bytes = utf8.encode(combinedString);
//       final digest = sha256.convert(bytes);
//       _cachedKey = digest.toString();
//
//       log.d('数据库加密密钥已生成');
//       return _cachedKey!;
//     } catch (e) {
//       log.e('生成加密密钥失败: $e');
//       // 降级方案：使用固定密钥
//       _cachedKey = 'fallback-encryption-key-please-change-in-production';
//       return _cachedKey!;
//     }
//   }
//
//   /// 清除缓存的密钥（用于测试或重置）
//   static void clearCachedKey() {
//     _cachedKey = null;
//   }
// }
