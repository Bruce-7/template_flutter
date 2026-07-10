import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  /// 获取本地化日期（含时间、含星期）
  /// 示例：2025年6月23日  星期一  17:48:26
  String formatDateWeekdayHmsLocalized() {
    return '${formatDateLocalized()}  ${formatWeekdayLocalized()}  ${formatHmsLocalized()}';
  }

  /// 获取本地化日期（不含时间、不含星期）
  String formatDateLocalized() {
    final locale = PlatformDispatcher.instance.locale.toLanguageTag();
    return DateFormat.yMMMMd(locale).format(this); // 例如：2025年6月23日
  }

  /// 获取本地化星期几
  String formatWeekdayLocalized() {
    final locale = PlatformDispatcher.instance.locale.toLanguageTag();
    return DateFormat.EEEE(locale).format(this); // 例如：星期一 / Monday
  }

  /// 获取本地化时间（精确到秒）
  String formatHmsLocalized() {
    final locale = PlatformDispatcher.instance.locale.toLanguageTag();
    return DateFormat.Hms(locale).format(this); // 例如：17:59:29
  }
}
