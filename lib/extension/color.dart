import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// 将颜色转换为十六进制字符串
  String colorToHexString({bool leadingHashSign = true}) {
    int to255(double v) => (v * 255).round().clamp(0, 255);

    final a = to255(this.a).toRadixString(16).padLeft(2, '0');
    final r = to255(this.r).toRadixString(16).padLeft(2, '0');
    final g = to255(this.g).toRadixString(16).padLeft(2, '0');
    final b = to255(this.b).toRadixString(16).padLeft(2, '0');

    return '${leadingHashSign ? '#' : ''}$a$r$g$b'.toUpperCase();
  }

  int colorToInt() {
    final a = (this.a * 255).toInt();
    final r = (this.r * 255).toInt();
    final g = (this.g * 255).toInt();
    final b = (this.b * 255).toInt();
    return (a << 24) | (r << 16) | (g << 8) | b;
  }
}
