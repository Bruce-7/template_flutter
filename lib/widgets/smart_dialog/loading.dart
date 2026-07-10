import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading extends HookConsumerWidget {
  final String msg;

  const Loading({super.key, required this.msg});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center, // toast默认居中
      child: Container(
        padding: msg.isNotEmpty ? EdgeInsets.symmetric(horizontal: context.spacing.lg, vertical: context.spacing.md) : context.spacing.paddingMD,
        margin: context.spacing.marginXXL,
        decoration: BoxDecoration(
          color: context.colors.scrim,
          borderRadius: context.radius.radiusMD,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (msg.isNotEmpty) const SizedBox(height: 10),
            if (msg.isNotEmpty)
              Text(
                msg,
                style: context.textStyle.bodyMedium.copyWith(
                  color: context.colors.onScrim,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
