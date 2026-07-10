import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  /// 选择图片（相机或相册）
  /// 返回：选择的图片文件或null（用户取消）
  /// 抛出异常：权限拒绝或选择失败
  /// 返回的XFile文件保存在临时目录，需要持久化则根据需求保存时控制。
  static Future<XFile?> pickImage(BuildContext context, {int imageQuality = 100}) async {
    try {
      final source = await _showImageSourceDialog(context);
      if (source == null || !context.mounted) return null;

      // 检查权限
      final isGranted = await _checkPermission(source, context);
      if (!isGranted) return null;

      // 选择图片
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: imageQuality,
      );

      return pickedFile;
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e);
      }
      return null;
    }
  }

  /// 选择多张图片（相机或相册）
  /// 相机模式：单张拍摄
  /// 相册模式：支持多选
  /// maxCount: 最大可选数量（仅对相册有效）
  static Future<List<XFile>?> pickMultipleImages(
    BuildContext context, {
    int imageQuality = 100,
    int? maxCount,
  }) async {
    try {
      final source = await _showImageSourceDialog(context);
      if (source == null || !context.mounted) return null;

      // 检查权限
      final isGranted = await _checkPermission(source, context);
      if (!isGranted) return null;

      if (source == ImageSource.camera) {
        // 相机模式：单张拍摄
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: imageQuality,
        );
        return pickedFile != null ? [pickedFile] : null;
      } else {
        // 相册模式：根据 maxCount 决定单选还是多选
        // pickMultiImage 的 limit 参数要求至少为 2，所以 maxCount 为 1 时使用单选
        if (maxCount == 1) {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            imageQuality: imageQuality,
          );
          return pickedFile != null ? [pickedFile] : null;
        } else {
          // maxCount 为 null 或 >= 2 时使用多选
          final List<XFile> pickedFiles = await _picker.pickMultiImage(
            imageQuality: imageQuality,
            limit: maxCount,
          );
          return pickedFiles.isNotEmpty ? pickedFiles : null;
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e);
      }

      log.e('pickMultipleImages：${e.toString()}');
      return null;
    }
  }

  /// 显示选择来源对话框
  static Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return await ActionDialog(
      title: '请选择图片来源'.tr(),
      style: ActionDialogStyle.sheet,
      isDismissible: true,
      showViewPaddingBottom: true,
      buttonGroupWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('相机'.tr()),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('相册'.tr()),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'.tr()),
          ),
        ],
      ),
    ).show(context);
  }

  /// 检查权限
  static Future<bool> _checkPermission(
    ImageSource source,
    BuildContext context,
  ) async {
    if (source == ImageSource.gallery) {
      // 使用的是系统相册无需权限。
      return true;
    }

    final status = await Permission.camera.request();
    if (status.isGranted) return true;
    if (!context.mounted) return false;

    // 权限被拒绝，需要引导用户去设置
    final shouldOpen = await ActionDialog(
      title: '相机权限被拒绝'.tr(),
      content: '请在系统设置中允许权限'.tr(),
      subButtonText: '取消'.tr(),
      mainButtonText: '去设置'.tr(),
      mainButtonAction: (context) {
        Navigator.pop(context, true);
      },
    ).show<bool>(context);

    if (shouldOpen == true) {
      await openAppSettings();
    }

    return false;
  }

  /// 显示错误对话框
  static void _showErrorDialog(BuildContext context, dynamic error) {
    ActionDialog(
      title: '选择图片失败'.tr(),
      content: error.toString(),
      mainButtonText: '确定'.tr(),
    ).show(context);
  }
}
