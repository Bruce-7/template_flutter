import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/db_prefs_extension.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/models/versions_check.dart';
import 'package:flutter_app/providers/package_info_state.dart';
import 'package:flutter_app/services/api/setting/api_versions.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_app/utils/launch_url.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// 更新检查工具类
class UpdateChecker {
  /// 检查更新
  static Future<void> checkUpdate(
    BuildContext context,
    WidgetRef ref, {
    required PackageInfo packageInfo,
    bool showLoading = false,
    bool showNoUpdateToast = false,
    bool isAutoCheck = false,
  }) async {
    if (showLoading) {
      CommonUtil.showLoading(msg: '检查中'.tr());
    }

    final versionCode = int.tryParse(packageInfo.buildNumber) ?? 1;

    AppPlatform platform = AppPlatform.android;
    if (Platform.isIOS || Platform.isMacOS) {
      platform = AppPlatform.ios;
    }

    try {
      final response = await ref.read(
        apiVersionsCheckProvider(
          platform: platform,
          versionCode: versionCode,
          versionName: packageInfo.version,
        ).future,
      );

      if (showLoading) {
        CommonUtil.dismiss();
      }

      if (!response.isSuccess) {
        if (showNoUpdateToast) {
          CommonUtil.showToast(response.message ?? '检查更新失败，请稍后重试'.tr());
        }
        return;
      }

      if (response.data == null || response.data?.latestVersion == null || response.data?.hasUpdate != true || !context.mounted) {
        if (showNoUpdateToast) {
          CommonUtil.showToast('当前已是最新版本'.tr());
        }
        return;
      }

      final latest = response.data!.latestVersion!;
      final isForceUpdate = latest.getForceUpdate(versionCode);

      if (isAutoCheck && !isForceUpdate) {
        final skippedVersion = dbManager.getSkippedVersion();
        if (skippedVersion == latest.versionName) {
          return;
        }
      }

      ActionDialog(
        title: latest.title?.tr() ?? '发现新版本'.tr(),
        contentWidget: Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${'版本'.tr()} ${latest.versionName}(${latest.versionCode})',
                  style: context.textStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                if (latest.description?.isNotEmpty == true)
                  Text(
                    latest.description!.tr(),
                    style: context.textStyle.bodyMedium,
                  ),
                if (latest.releaseNotes?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  Text(
                    latest.releaseNotes!.tr(),
                    style: context.textStyle.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
        ),
        mainButtonText: '立即更新'.tr(),
        subButtonText: isForceUpdate ? null : (isAutoCheck ? '跳过此版本'.tr() : '稍后再说'.tr()),
        isDismissible: !isForceUpdate,
        showCloseButton: !isForceUpdate,
        mainButtonAction: (dialogContext) async {
          Navigator.pop(dialogContext);

          if (isAutoCheck) {
            await dbManager.clearSkippedVersion();
          }

          LaunchUrl.handleLink(
            latest.downloadUrl,
            launchMode: LaunchMode.externalApplication,
            fail: () async {
              CommonUtil.showToast('下载链接无效'.tr());
            },
          );
        },
        subButtonAction: isForceUpdate
            ? null
            : (dialogContext) async {
                Navigator.pop(dialogContext);
                if (isAutoCheck) {
                  await dbManager.setSkippedVersion(latest.versionName);
                }
              },
      ).show(context);
    } catch (err, stack) {
      log.e('检查更新失败: $err', stackTrace: stack);
      if (showLoading) {
        CommonUtil.dismiss();
      }
      if (showNoUpdateToast) {
        CommonUtil.showToast('检查更新失败，请稍后重试'.tr());
      }
    }
  }

  /// 自动检查更新（应用启动时调用）
  static Future<void> autoCheckUpdate(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final packageInfo = await ref.read(packageInfoStateProvider.future);

    if (context.mounted) {
      await checkUpdate(
        context,
        ref,
        packageInfo: packageInfo,
        showLoading: false,
        showNoUpdateToast: false,
        isAutoCheck: true,
      );
    }
  }
}
