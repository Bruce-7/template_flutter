import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  /// 处理邮箱点击
  static Future<void> handleEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);

    try {
      // bool result = await canLaunchUrl(uri);
      // if (result) {
      bool result = await launchUrl(uri);
      // }

      if (!result) {
        await Clipboard.setData(ClipboardData(text: email));
        CommonUtil.showToast('已复制'.tr());
      }
    } catch (e) {
      log.e(e);

      await Clipboard.setData(ClipboardData(text: email));
      CommonUtil.showToast('已复制'.tr());
    }
  }

  /// 处理QQ群点击
  static Future<void> handleQQGroup(String qqGroup) async {
    final uri = Uri.tryParse('mqqapi://card/show_pslcard?src_type=internal&version=1&uin=$qqGroup&card_type=group&source=qrcode');
    bool result = uri != null;

    try {
      if (result) {
        result = await launchUrl(uri);
      }

      if (!result) {
        await Clipboard.setData(ClipboardData(text: qqGroup));
        CommonUtil.showToast('已复制'.tr());
      }
    } catch (e) {
      log.e(e);
      await Clipboard.setData(ClipboardData(text: qqGroup));
      CommonUtil.showToast('已复制'.tr());
    }
  }

  /// 任意链接
  static Future<void> handleLink(
    String link, {
    LaunchMode launchMode = LaunchMode.platformDefault,
    Function()? fail,
  }) async {
    final uri = Uri.tryParse(link);
    if (uri == null) return fail?.call();

    try {
      // bool result = await canLaunchUrl(uri);
      // if (result) {
      bool result = await launchUrl(uri, mode: launchMode);
      // }

      if (!result) {
        fail?.call();
      }
    } catch (e) {
      log.e(e);
      fail?.call();
    }
  }
}
