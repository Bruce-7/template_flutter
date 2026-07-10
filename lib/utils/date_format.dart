import 'package:easy_localization/easy_localization.dart';

class DateFormatUtil {
  // 按本地时区格式化日期，只显示年月日国际化语言。
  static String yMdLocalizedDate(DateTime date) {
    return DateFormat.yMd().format(date.toLocal());
  }

  // 按本地时区格式化日期，只显示月日国际化语言。
  static String mdLocalizedDate(DateTime date) {
    return DateFormat.Md().format(date.toLocal());
  }

  // 距离当前时间是多少天
  static int daysFromNow(DateTime date) {
    return DateTime.now().difference(date.toLocal()).inDays;
  }

  // 当前时间到秒紧凑版
  static String yyyyMMddHHmmss() {
    return DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  }

  // yyyy-MM-dd HH:mm:ss
  static String yMDHMS(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date.toLocal());
  }
}
