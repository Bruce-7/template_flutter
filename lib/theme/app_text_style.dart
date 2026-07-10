import 'package:flutter/material.dart';

/// 文字系统定义
///
/// 定义应用中所有文字样式，包含不同级别的标题、正文和标签

@immutable
class AppTextStyle extends ThemeExtension<AppTextStyle> {
  /// 展示文字样式（最大）
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  /// 标题文字样式
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  /// 小标题文字样式
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  /// 正文文字样式
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  /// 标签文字样式
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const AppTextStyle({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// 创建浅色主题文字样式
  factory AppTextStyle.light(Color color) {
    final baseTextStyle = TextStyle(
      color: color,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
    );

    return AppTextStyle(
      displayLarge: baseTextStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: baseTextStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ),
      headlineLarge: baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
      ),
      titleLarge: baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      labelLarge: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: baseTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.27,
      ),
    );
  }

  /// 创建深色主题文字样式
  factory AppTextStyle.dark(Color color) {
    return AppTextStyle.light(color);
  }

  /// 转换为 Flutter 的 TextTheme
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  /// 复制并修改部分文字样式
  @override
  AppTextStyle copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return AppTextStyle(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  /// 在两个文字样式之间进行插值
  @override
  AppTextStyle lerp(ThemeExtension<AppTextStyle>? other, double t) {
    if (other is! AppTextStyle) return this;

    return AppTextStyle(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}
