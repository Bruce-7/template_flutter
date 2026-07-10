import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KeywordInputBar extends HookConsumerWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const KeywordInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoTextField.borderless(
      controller: controller,
      focusNode: focusNode,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      suffix: Padding(
        padding: EdgeInsets.only(right: 6.0),
        child: Icon(
          Icons.search,
          size: context.spacing.iconSizeMD,
        ),
      ),
      suffixMode: OverlayVisibilityMode.notEditing,
      placeholder: '搜索'.tr(),
      placeholderStyle: context.textStyle.bodyMedium.copyWith(color: context.colors.onSurfaceVariant),
      style: context.textStyle.bodyMedium,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: context.radius.radiusMD,
      ),
      clearButtonMode: OverlayVisibilityMode.editing,
      onTapOutside: (_) => focusNode.unfocus(),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
    );
  }
}
