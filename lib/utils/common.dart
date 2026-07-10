import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class CommonUtil {
  /// 生成唯一不重复id
  static String generateUniqueId() {
    return '${const Uuid().v4()}-${DateTime.now().millisecondsSinceEpoch}';
  }

  // 获取根 MediaQueryData，用于获取原始安全区域距离，避免 SafeArea 被移除。
  static MediaQueryData findRootMediaQuery(BuildContext context) {
    BuildContext? root = context;
    MediaQueryData? mediaQuery;

    while (root != null) {
      mediaQuery = MediaQuery.maybeOf(root);
      if (root.widget is WidgetsApp || root.widget is MaterialApp) {
        break;
      }
      root = root.findAncestorStateOfType<NavigatorState>()?.context;
    }

    return mediaQuery ?? MediaQuery.of(context);
  }

  // 获取底部安全区域
  static double bottomViewPadding(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return bottomPadding <= 0 ? 24 : bottomPadding;
  }

  static double topViewPadding(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return topPadding <= 0 ? 24 : topPadding;
  }

  // 常用有键盘、等推起的间距。
  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  // 获取图片持久化目录
  static String getImagesDocuments() {
    return '${dbManager.documentsDir.path}/$kImagesDir/';
  }

  // 保存Uint8List图片到Documents的images目录下持久化
  // 返回文件名称
  static Future<String?> saveImageDataToDocuments(Uint8List data) async {
    try {
      // 确保 images 子目录存在
      final Directory saveDir = Directory(p.join(dbManager.documentsDir.path, kImagesDir));
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      // 生成唯一文件名
      final String fileName = 'img_${CommonUtil.generateUniqueId()}.png';
      final String newPath = p.join(saveDir.path, fileName);

      // 保存文件
      final File savedFile = await File(newPath).writeAsBytes(data);

      // 验证文件是否成功复制
      if (await savedFile.exists()) {
        log.d('图片保存成功: $newPath');

        // 返回文件名称
        return fileName;
      } else {
        log.d('图片保存失败: $newPath');
        return null;
      }
    } catch (e, stackTrace) {
      log.d('保存图片失败: $e\n$stackTrace');
      return null;
    }
  }

  // 保存图片到Documents的images目录下持久化
  // 返回文件名称
  static Future<String?> saveImageToDocuments(XFile pickedFile) async {
    // 空值检查
    if (pickedFile.path.isEmpty) return null;

    try {
      final File tmpFile = File(pickedFile.path);

      // 检查源文件是否存在
      if (!await tmpFile.exists()) {
        log.d('源文件不存在: ${pickedFile.path}');
        return null;
      }

      // 确保 images 子目录存在
      final Directory saveDir = Directory(p.join(dbManager.documentsDir.path, kImagesDir));
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      // 生成唯一文件名
      final String fileName = 'img_${CommonUtil.generateUniqueId()}${p.extension(pickedFile.path)}';
      final String newPath = p.join(saveDir.path, fileName);

      // 复制文件到目标位置
      final File savedFile = await tmpFile.copy(newPath);

      // 验证文件是否成功复制
      if (await savedFile.exists()) {
        log.d('图片保存成功: $newPath');

        // 返回文件名称
        return fileName;
      } else {
        log.d('图片保存失败: $newPath');
        return null;
      }
    } catch (e, stackTrace) {
      log.d('保存图片失败: $e\n$stackTrace');
      return null;
    }
  }

  // 金额显示千位格式化
  static String amountThousandsFormat(double? amount) {
    if (amount == null) return '0';

    final formatter = NumberFormat('#,##0.##', Intl.getCurrentLocale());
    return formatter.format(amount);
  }

  // 数字保留小数位的有效位
  static String effectiveFormat(double? number) {
    if (number == null) return '0';

    final formatter = NumberFormat('#0.##', Intl.getCurrentLocale());
    return formatter.format(number);
  }

  static void showToast(String msg) {
    SmartDialog.showToast(msg);
  }

  static void showLoading({required String msg}) {
    SmartDialog.showLoading(msg: msg);
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }
}
