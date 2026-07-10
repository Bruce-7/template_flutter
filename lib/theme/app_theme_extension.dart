import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_colors.dart';
import 'package:flutter_app/theme/app_radius.dart';
import 'package:flutter_app/theme/app_spacing.dart';
import 'package:flutter_app/theme/app_text_style.dart';
import 'package:flutter_app/theme/app_theme.dart';

/// BuildContext 主题扩展
///
/// 提供便捷的主题访问方法，简化在组件中使用主题
extension AppThemeExtension on BuildContext {
  /// 获取主题对象
  AppTheme get appTheme {
    final theme = Theme.of(this).extension<AppTheme>();
    if (theme == null) {
      throw Exception('AppTheme is not available. Make sure to register AppTheme in your ThemeData extensions.');
    }
    return theme;
  }

  /// 获取颜色系统
  AppColors get colors => appTheme.colors;

  /// 获取文字系统
  AppTextStyle get textStyle => appTheme.textStyle;

  /// 获取间距系统
  AppSpacing get spacing => appTheme.spacing;

  /// 获取圆角系统
  AppRadius get radius => appTheme.radius;

  /// 判断是否为深色模式
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// 判断是否为浅色模式
  bool get isLight => Theme.of(this).brightness == Brightness.light;
}
