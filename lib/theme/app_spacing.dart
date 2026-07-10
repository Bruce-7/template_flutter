import 'dart:ui';

import 'package:flutter/material.dart';

/// 间距系统定义
///
/// 定义应用中所有间距值，提供统一的间距规范

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  // const xs = 4.0;
  // const sm = 8.0;
  // const md = 12.0;
  // const lg = 24.0;
  // const xl = 32.0;
  // const xxl = 48.0;
  // const xxxl = 64.0;
  // const xxxxl = 128.0;
  /// 基础间距值
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double xxxxl;

  /// 预定义的内边距
  final EdgeInsets paddingXS;
  final EdgeInsets paddingSM;
  final EdgeInsets paddingMD;
  final EdgeInsets paddingLG;
  final EdgeInsets paddingXL;
  final EdgeInsets paddingXXL;
  final EdgeInsets paddingXXXL;
  final EdgeInsets paddingXXXXL;

  /// 预定义的外边距
  final EdgeInsets marginXS;
  final EdgeInsets marginSM;
  final EdgeInsets marginMD;
  final EdgeInsets marginLG;
  final EdgeInsets marginXL;
  final EdgeInsets marginXXL;
  final EdgeInsets marginXXXL;
  final EdgeInsets marginXXXXL;

  /// 线条宽度
  final double strokeThin; // 1 - 细线
  final double strokeMedium; // 2.0 - 标准线
  final double strokeThick; // 4.0 - 粗线

  /// 图标尺寸
  final double iconSizeXS; // 10
  final double iconSizeSM; // 14
  final double iconSizeMD; // 18
  final double iconSizeLG; // 24

  /// 加载指示器尺寸
  final double loaderSM; // 16
  final double loaderMD; // 24
  final double loaderLG; // 32

  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.xxxxl,
    required this.paddingXS,
    required this.paddingSM,
    required this.paddingMD,
    required this.paddingLG,
    required this.paddingXL,
    required this.paddingXXL,
    required this.paddingXXXL,
    required this.paddingXXXXL,
    required this.marginXS,
    required this.marginSM,
    required this.marginMD,
    required this.marginLG,
    required this.marginXL,
    required this.marginXXL,
    required this.marginXXXL,
    required this.marginXXXXL,
    required this.strokeThin,
    required this.strokeMedium,
    required this.strokeThick,
    required this.iconSizeSM,
    required this.iconSizeMD,
    required this.iconSizeLG,
    required this.iconSizeXS,
    required this.loaderSM,
    required this.loaderMD,
    required this.loaderLG,
  });

  /// 创建基础间距系统
  factory AppSpacing.base() {
    const xs = 4.0;
    const sm = 8.0;
    const md = 12.0;
    const lg = 20.0;
    const xl = 32.0;
    const xxl = 48.0;
    const xxxl = 64.0;
    const xxxxl = 128.0;

    return AppSpacing(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      xxxl: xxxl,
      xxxxl: xxxxl,
      paddingXS: const EdgeInsets.all(xs),
      paddingSM: const EdgeInsets.all(sm),
      paddingMD: const EdgeInsets.all(md),
      paddingLG: const EdgeInsets.all(lg),
      paddingXL: const EdgeInsets.all(xl),
      paddingXXL: const EdgeInsets.all(xxl),
      paddingXXXL: const EdgeInsets.all(xxxl),
      paddingXXXXL: const EdgeInsets.all(xxxxl),
      marginXS: const EdgeInsets.all(xs),
      marginSM: const EdgeInsets.all(sm),
      marginMD: const EdgeInsets.all(md),
      marginLG: const EdgeInsets.all(lg),
      marginXL: const EdgeInsets.all(xl),
      marginXXL: const EdgeInsets.all(xxl),
      marginXXXL: const EdgeInsets.all(xxxl),
      marginXXXXL: const EdgeInsets.all(xxxxl),
      strokeThin: 1,
      strokeMedium: 2.0,
      strokeThick: 4.0,
      iconSizeXS: 10.0,
      iconSizeSM: 14.0,
      iconSizeMD: 18.0,
      iconSizeLG: 24.0,
      loaderSM: 16.0,
      loaderMD: 24.0,
      loaderLG: 32.0,
    );
  }

  /// 创建对称间距
  EdgeInsets symmetric({double? horizontal, double? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? md,
      vertical: vertical ?? md,
    );
  }

  /// 创建自定义间距
  EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  /// 复制并修改部分间距属性
  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? xxxxl,
    EdgeInsets? paddingXS,
    EdgeInsets? paddingSM,
    EdgeInsets? paddingMD,
    EdgeInsets? paddingLG,
    EdgeInsets? paddingXL,
    EdgeInsets? paddingXXL,
    EdgeInsets? paddingXXXL,
    EdgeInsets? paddingXXXXL,
    EdgeInsets? marginXS,
    EdgeInsets? marginSM,
    EdgeInsets? marginMD,
    EdgeInsets? marginLG,
    EdgeInsets? marginXL,
    EdgeInsets? marginXXL,
    EdgeInsets? marginXXXL,
    EdgeInsets? marginXXXXL,
    double? strokeThin,
    double? strokeMedium,
    double? strokeThick,
    double? iconSizeXS,
    double? iconSizeSM,
    double? iconSizeMD,
    double? iconSizeLG,
    double? loaderSM,
    double? loaderMD,
    double? loaderLG,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      xxxxl: xxxxl ?? this.xxxxl,
      paddingXS: paddingXS ?? this.paddingXS,
      paddingSM: paddingSM ?? this.paddingSM,
      paddingMD: paddingMD ?? this.paddingMD,
      paddingLG: paddingLG ?? this.paddingLG,
      paddingXL: paddingXL ?? this.paddingXL,
      paddingXXL: paddingXXL ?? this.paddingXXL,
      paddingXXXL: paddingXXXL ?? this.paddingXXXL,
      paddingXXXXL: paddingXXXXL ?? this.paddingXXXXL,
      marginXS: marginXS ?? this.marginXS,
      marginSM: marginSM ?? this.marginSM,
      marginMD: marginMD ?? this.marginMD,
      marginLG: marginLG ?? this.marginLG,
      marginXL: marginXL ?? this.marginXL,
      marginXXL: marginXXL ?? this.marginXXL,
      marginXXXL: marginXXXL ?? this.marginXXXL,
      marginXXXXL: marginXXXXL ?? this.marginXXXXL,
      strokeThin: strokeThin ?? this.strokeThin,
      strokeMedium: strokeMedium ?? this.strokeMedium,
      strokeThick: strokeThick ?? this.strokeThick,
      iconSizeXS: iconSizeXS ?? this.iconSizeXS,
      iconSizeSM: iconSizeSM ?? this.iconSizeSM,
      iconSizeMD: iconSizeMD ?? this.iconSizeMD,
      iconSizeLG: iconSizeLG ?? this.iconSizeLG,
      loaderSM: loaderSM ?? this.loaderSM,
      loaderMD: loaderMD ?? this.loaderMD,
      loaderLG: loaderLG ?? this.loaderLG,
    );
  }

  /// 在两个间距之间进行插值
  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;

    return AppSpacing(
      xs: lerpDouble(xs, other.xs, t) ?? 0,
      sm: lerpDouble(sm, other.sm, t) ?? 0,
      md: lerpDouble(md, other.md, t) ?? 0,
      lg: lerpDouble(lg, other.lg, t) ?? 0,
      xl: lerpDouble(xl, other.xl, t) ?? 0,
      xxl: lerpDouble(xxl, other.xxl, t) ?? 0,
      xxxl: lerpDouble(xxxl, other.xxxl, t) ?? 0,
      xxxxl: lerpDouble(xxxxl, other.xxxxl, t) ?? 0,
      paddingXS: EdgeInsets.lerp(paddingXS, other.paddingXS, t)!,
      paddingSM: EdgeInsets.lerp(paddingSM, other.paddingSM, t)!,
      paddingMD: EdgeInsets.lerp(paddingMD, other.paddingMD, t)!,
      paddingLG: EdgeInsets.lerp(paddingLG, other.paddingLG, t)!,
      paddingXL: EdgeInsets.lerp(paddingXL, other.paddingXL, t)!,
      paddingXXL: EdgeInsets.lerp(paddingXXL, other.paddingXXL, t)!,
      paddingXXXL: EdgeInsets.lerp(paddingXXXL, other.paddingXXXL, t)!,
      paddingXXXXL: EdgeInsets.lerp(paddingXXXXL, other.paddingXXXXL, t)!,
      marginXS: EdgeInsets.lerp(marginXS, other.marginXS, t)!,
      marginSM: EdgeInsets.lerp(marginSM, other.marginSM, t)!,
      marginMD: EdgeInsets.lerp(marginMD, other.marginMD, t)!,
      marginLG: EdgeInsets.lerp(marginLG, other.marginLG, t)!,
      marginXL: EdgeInsets.lerp(marginXL, other.marginXL, t)!,
      marginXXL: EdgeInsets.lerp(marginXXL, other.marginXXL, t)!,
      marginXXXL: EdgeInsets.lerp(marginXXXL, other.marginXXXL, t)!,
      marginXXXXL: EdgeInsets.lerp(marginXXXXL, other.marginXXXXL, t)!,
      strokeThin: lerpDouble(strokeThin, other.strokeThin, t) ?? 0,
      strokeMedium: lerpDouble(strokeMedium, other.strokeMedium, t) ?? 0,
      strokeThick: lerpDouble(strokeThick, other.strokeThick, t) ?? 0,
      iconSizeXS: lerpDouble(iconSizeXS, other.iconSizeXS, t) ?? 0,
      iconSizeSM: lerpDouble(iconSizeSM, other.iconSizeSM, t) ?? 0,
      iconSizeMD: lerpDouble(iconSizeMD, other.iconSizeMD, t) ?? 0,
      iconSizeLG: lerpDouble(iconSizeLG, other.iconSizeLG, t) ?? 0,
      loaderSM: lerpDouble(loaderSM, other.loaderSM, t) ?? 0,
      loaderMD: lerpDouble(loaderMD, other.loaderMD, t) ?? 0,
      loaderLG: lerpDouble(loaderLG, other.loaderLG, t) ?? 0,
    );
  }
}
