import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CardContainer extends HookConsumerWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final Widget? child;
  final double? width;
  final double? height;

  const CardContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 不使用Card，方便可控boxShadow。
    return Container(
      margin: margin,
      padding: padding ?? context.spacing.paddingMD,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: context.radius.radiusMD,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 4.0, // 模糊程度
            spreadRadius: 0.0, // 不扩展阴影
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: child,
    );
  }
}
