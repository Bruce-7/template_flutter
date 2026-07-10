// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_app/constants/keys.dart';
// import 'package:flutter_app/managers/db.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/utils/common.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationManager {
//   static final NotificationManager _instance = NotificationManager._internal();
//
//   factory NotificationManager() => _instance;
//
//   NotificationManager._internal();
//
//   final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
//   bool _initialized = false;
//   AndroidFlutterLocalNotificationsPlugin? _androidPlugin;
//   IOSFlutterLocalNotificationsPlugin? _iosPlugin;
//
//   Future<void> initialize() async {
//     if (_initialized) return;
//
//     try {
//       _initialized = true;
//       tz.initializeTimeZones();
//
//       if (Platform.isAndroid) {
//         const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//         const initSettings = InitializationSettings(
//           android: androidSettings,
//         );
//
//         await _notifications.initialize(
//           settings: initSettings,
//           onDidReceiveNotificationResponse: _onNotificationTapped,
//         );
//
//         _androidPlugin = _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//       } else if (Platform.isIOS || Platform.isMacOS) {
//         const iosSettings = DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//         );
//
//         const initSettings = InitializationSettings(
//           iOS: iosSettings,
//           macOS: iosSettings,
//         );
//
//         await _notifications.initialize(
//           settings: initSettings,
//           onDidReceiveNotificationResponse: _onNotificationTapped,
//         );
//
//         _iosPlugin = _notifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
//       }
//
//       log.d('NotificationService 初始化完成');
//     } catch (error) {
//       log.e('NotificationService 初始化失败: $error');
//       _initialized = false;
//     } finally {
//       _initialized = true;
//     }
//   }
//
//   void _onNotificationTapped(NotificationResponse response) {
//     log.d('通知被点击: ${response.payload}');
//   }
//
//   /// 检查通知权限状态
//   Future<bool> checkPermissionStatus() async {
//     if (!_initialized) {
//       await initialize();
//     }
//
//     if (Platform.isAndroid) {
//       // Android 检查权限
//       if (_androidPlugin != null) {
//         final granted = await _androidPlugin!.areNotificationsEnabled();
//         return granted ?? false;
//       }
//     } else if (Platform.isIOS || Platform.isMacOS) {
//       // iOS 检查权限
//       if (_iosPlugin != null) {
//         final granted = await _iosPlugin!.checkPermissions();
//         return granted?.isEnabled ?? false;
//       }
//     }
//
//     return false;
//   }
//
//   /// 请求通知权限
//   Future<bool> requestPermissions() async {
//     if (!_initialized) {
//       await initialize();
//     }
//
//     if (Platform.isAndroid) {
//       bool? androidGranted = await _androidPlugin?.requestNotificationsPermission();
//
//       final granted = (androidGranted ?? true);
//       log.d('通知权限请求结果: $granted');
//       return granted;
//     } else if (Platform.isIOS || Platform.isMacOS) {
//       bool? iosGranted = await _iosPlugin?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//
//       final granted = (iosGranted ?? true);
//       log.d('通知权限请求结果: $granted');
//       return granted;
//     }
//
//     return false;
//   }
//
//   /// 检查精确闹钟权限 (Android 12+)
//   Future<bool> canScheduleExactAlarms() async {
//     if (!Platform.isAndroid) return true;
//
//     try {
//       final canSchedule = await _androidPlugin?.canScheduleExactNotifications();
//       return canSchedule ?? false;
//     } catch (e) {
//       log.e('检查精确闹钟权限失败: $e');
//       return false;
//     }
//   }
//
//   /// 请求精确闹钟权限 (Android 12+)
//   Future<bool> requestExactAlarmPermission() async {
//     if (!Platform.isAndroid) return true;
//
//     try {
//       final granted = await _androidPlugin?.requestExactAlarmsPermission();
//       log.d('精确闹钟权限请求结果: $granted');
//       return granted ?? false;
//     } catch (e) {
//       log.e('请求精确闹钟权限失败: $e');
//       return false;
//     }
//   }
//
//   Future<void> scheduleWarrantyExpiryNotification({
//     required String assetId,
//     required String assetName,
//     required DateTime warrantyExpiryDate,
//     required int daysBeforeExpiry,
//     String? customMessage,
//   }) async {
//     if (!_initialized) {
//       await initialize();
//     }
//
//     // 先检查通知权限状态
//     final hasPermission = await notificationManager.checkPermissionStatus();
//
//     if (!hasPermission) {
//       CommonUtil.showToast('未开启通知权限,「{}」到期通知设置无效'.tr(args: [assetName]));
//       return;
//     }
//
//     // Android 12+ 检查精确闹钟权限
//     if (Platform.isAndroid) {
//       final canScheduleExact = await canScheduleExactAlarms();
//       if (!canScheduleExact) {
//         final granted = await requestExactAlarmPermission();
//         if (!granted) {
//           CommonUtil.showToast('未授予精确闹钟权限,「{}」到期通知设置无效'.tr(args: [assetName]));
//           return;
//         }
//       }
//     }
//
//     // 有权限，直接设置通知
//     final notificationDate = warrantyExpiryDate.subtract(Duration(days: daysBeforeExpiry));
//
//     // // Hse7enD 测试使用，方便及时收到通知。
//     // final testTime = DateTime.now();
//     // final notificationDate = DateTime(testTime.year, testTime.month, testTime.day, 14, 06, 00);
//
//     if (notificationDate.isBefore(DateTime.now())) {
//       log.d('通知时间已到期，跳过设置: $assetName');
//       return;
//     }
//
//     final notificationId = _generateNotificationId(assetId);
//
//     final message = customMessage?.isNotEmpty == true ? customMessage! : '还剩{}天即将到期'.tr(args: ['$daysBeforeExpiry']);
//
//     NotificationDetails notificationDetails = NotificationDetails();
//
//     if (Platform.isAndroid) {
//       notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           'warranty_expiry_channel',
//           '到期通知'.tr(),
//           channelDescription: '到期通知'.tr(),
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       );
//     } else if (Platform.isIOS || Platform.isMacOS) {
//       notificationDetails = NotificationDetails(
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       );
//     }
//
//     try {
//       await _notifications.zonedSchedule(
//         id: notificationId,
//         title: '到期通知'.tr(),
//         body: '$assetName: $message',
//         scheduledDate: tz.TZDateTime.from(notificationDate, tz.local),
//         notificationDetails: notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         payload: assetId,
//       );
//
//       int expiryAlertMaxCount = dbManager.prefs.getInt(kOrdinaryExpiryAlertMaxCount) ?? 0;
//       dbManager.prefs.setInt(kOrdinaryExpiryAlertMaxCount, expiryAlertMaxCount + 1);
//       log.d('已设置通知: $assetName, 时间: $notificationDate');
//     } catch (e) {
//       log.e('设置通知失败: $e');
//       CommonUtil.showToast('设置通知失败，请检查权限设置'.tr());
//     }
//   }
//
//   Future<void> cancelNotification(String assetId) async {
//     final notificationId = _generateNotificationId(assetId);
//     await _notifications.cancel(id: notificationId);
//     log.d('已取消通知: $assetId');
//   }
//
//   Future<void> cancelAllNotifications() async {
//     await _notifications.cancelAll();
//     log.d('已取消所有通知');
//   }
//
//   /// 打开系统设置中的应用通知页面
//   Future<bool> openNotificationSettings() async {
//     try {
//       // 使用 permission_handler 打开系统设置
//       final opened = await openAppSettings();
//       log.d('打开应用设置: $opened');
//       return opened;
//     } catch (e) {
//       log.e('打开应用设置失败: $e');
//       return false;
//     }
//   }
//
//   // 简单实现字符串转int得到一个唯一值
//   int _generateNotificationId(String assetId) {
//     return assetId.hashCode.abs() % 2147483647;
//   }
// }
//
// /// 全局通知实例，方便直接调用
// final notificationManager = NotificationManager();
