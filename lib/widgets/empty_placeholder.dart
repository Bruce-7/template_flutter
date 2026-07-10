import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmptyPlaceholder extends HookConsumerWidget {
  final String? message;
  final String? buttonTitle;
  final bool showButton;
  final VoidCallback? onButtonClick;

  const EmptyPlaceholder({
    super.key,
    this.message,
    this.buttonTitle,
    this.showButton = false,
    this.onButtonClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                message ?? '~ ${'暂无数据哦'.tr()} ~',
                style: context.textStyle.labelMedium.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ),
            if (showButton)
              FilledButton(
                onPressed: onButtonClick,
                child: Text(
                  buttonTitle ?? '重试'.tr(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
