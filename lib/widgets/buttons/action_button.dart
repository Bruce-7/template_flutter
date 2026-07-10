import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActionButton extends HookConsumerWidget {
  final IconData icon;
  final String label;
  final Color buttonColor;
  final VoidCallback? onTap;
  final HitTestBehavior? behavior;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.buttonColor,
    this.onTap,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      behavior: behavior,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: buttonColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(context.radius.md),
            ),
            child: Icon(
              icon,
              size: 28,
              color: buttonColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: context.textStyle.bodyMedium.copyWith(
              color: buttonColor,
            ),
          ),
        ],
      ),
    );
  }
}
