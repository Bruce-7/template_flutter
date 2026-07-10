import 'package:flutter/material.dart';

extension StringExtension on String {
  String safeLimit(int limit) {
    // 防止emoji被分割
    final chars = characters;
    return chars.length <= limit ? this : chars.take(limit).toString();
  }

  // 将十六进制字符串转换为颜色
  Color toColor() {
    String str = replaceAll('#', '');
    if (str.length == 6) {
      str = 'FF$str'; // 默认不透明
    }
    return Color(int.parse(str, radix: 16));
  }
}
