import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Toast extends HookConsumerWidget {
  final String msg;

  const Toast({super.key, required this.msg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center, // toast默认居中
      child: Container(
        padding: context.spacing.paddingMD,
        margin: context.spacing.marginXXL,
        decoration: BoxDecoration(
          color: context.colors.scrim,
          borderRadius: context.radius.radiusMD,
        ),
        child: Text(
          msg,
          style: context.textStyle.bodyMedium.copyWith(
            color: context.colors.onScrim,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
