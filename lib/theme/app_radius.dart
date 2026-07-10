import 'dart:ui';

import 'package:flutter/material.dart';

/// 圆角系统定义
///
/// 定义应用中所有圆角值，提供统一的圆角规范

@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  // const xs = 8.0;
  // const sm = 12.0;
  // const md = 16.0;
  // const lg = 24.0;
  // const xl = 28.0;
  // const xxl = 32.0;
  // const xxxl = 48.0;
  // const full = 9999.0;
  /// 基础圆角值
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;
  final double full;

  /// 预定义的圆角
  final BorderRadius radiusXS;
  final BorderRadius radiusSM;
  final BorderRadius radiusMD;
  final BorderRadius radiusLG;
  final BorderRadius radiusXL;
  final BorderRadius radiusXXL;
  final BorderRadius radiusXXXL;
  final BorderRadius radiusFull;

  const AppRadius({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.full,
    required this.radiusXS,
    required this.radiusSM,
    required this.radiusMD,
    required this.radiusLG,
    required this.radiusXL,
    required this.radiusXXL,
    required this.radiusXXXL,
    required this.radiusFull,
  });

  /// 创建基础圆角系统
  factory AppRadius.base() {
    const xs = 8.0;
    const sm = 12.0;
    const md = 16.0;
    const lg = 24.0;
    const xl = 28.0;
    const xxl = 32.0;
    const xxxl = 48.0;
    const full = 9999.0;

    return AppRadius(
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
      xxl: xxl,
      xxxl: xxxl,
      full: full,
      radiusXS: const BorderRadius.all(Radius.circular(xs)),
      radiusSM: const BorderRadius.all(Radius.circular(sm)),
      radiusMD: const BorderRadius.all(Radius.circular(md)),
      radiusLG: const BorderRadius.all(Radius.circular(lg)),
      radiusXL: const BorderRadius.all(Radius.circular(xl)),
      radiusXXL: const BorderRadius.all(Radius.circular(xxl)),
      radiusXXXL: const BorderRadius.all(Radius.circular(xxxl)),
      radiusFull: const BorderRadius.all(Radius.circular(full)),
    );
  }

  /// 创建自定义圆角
  BorderRadius only({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }

  /// 创建圆形圆角
  BorderRadius circular(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  /// 创建垂直圆角
  BorderRadius vertical({
    double top = 0,
    double bottom = 0,
  }) {
    return BorderRadius.vertical(
      top: Radius.circular(top),
      bottom: Radius.circular(bottom),
    );
  }

  /// 创建水平圆角
  BorderRadius horizontal({
    double left = 0,
    double right = 0,
  }) {
    return BorderRadius.horizontal(
      left: Radius.circular(left),
      right: Radius.circular(right),
    );
  }

  /// 复制并修改部分圆角属性
  @override
  AppRadius copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
    double? full,
    BorderRadius? radiusXS,
    BorderRadius? radiusSM,
    BorderRadius? radiusMD,
    BorderRadius? radiusLG,
    BorderRadius? radiusXL,
    BorderRadius? radiusXXL,
    BorderRadius? radiusXXXL,
    BorderRadius? radiusFull,
  }) {
    return AppRadius(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
      full: full ?? this.full,
      radiusXS: radiusXS ?? this.radiusXS,
      radiusSM: radiusSM ?? this.radiusSM,
      radiusMD: radiusMD ?? this.radiusMD,
      radiusLG: radiusLG ?? this.radiusLG,
      radiusXL: radiusXL ?? this.radiusXL,
      radiusXXL: radiusXXL ?? this.radiusXXL,
      radiusXXXL: radiusXXXL ?? this.radiusXXXL,
      radiusFull: radiusFull ?? this.radiusFull,
    );
  }

  /// 在两个圆角之间进行插值
  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) return this;

    return AppRadius(
      xs: lerpDouble(xs, other.xs, t) ?? 0,
      sm: lerpDouble(sm, other.sm, t) ?? 0,
      md: lerpDouble(md, other.md, t) ?? 0,
      lg: lerpDouble(lg, other.lg, t) ?? 0,
      xl: lerpDouble(xl, other.xl, t) ?? 0,
      xxl: lerpDouble(xxl, other.xxl, t) ?? 0,
      xxxl: lerpDouble(xxxl, other.xxxl, t) ?? 0,
      full: lerpDouble(full, other.full, t) ?? 0,
      radiusXS: BorderRadius.lerp(radiusXS, other.radiusXS, t)!,
      radiusSM: BorderRadius.lerp(radiusSM, other.radiusSM, t)!,
      radiusMD: BorderRadius.lerp(radiusMD, other.radiusMD, t)!,
      radiusLG: BorderRadius.lerp(radiusLG, other.radiusLG, t)!,
      radiusXL: BorderRadius.lerp(radiusXL, other.radiusXL, t)!,
      radiusXXL: BorderRadius.lerp(radiusXXL, other.radiusXXL, t)!,
      radiusXXXL: BorderRadius.lerp(radiusXXXL, other.radiusXXXL, t)!,
      radiusFull: BorderRadius.lerp(radiusFull, other.radiusFull, t)!,
    );
  }
}
