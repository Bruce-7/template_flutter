import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';

class AppCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double iconSize;
  final EdgeInsets padding;
  final WidgetStateProperty<OutlinedBorder?>? shape;

  const AppCloseButton({
    super.key,
    this.onPressed,
    this.iconSize = 12,
    this.padding = const EdgeInsets.all(6),
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Padding(
        padding: padding,
        child: const Icon(Icons.close),
      ),
      iconSize: iconSize,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(context.colors.scrim),
        foregroundColor: WidgetStateProperty.all(context.colors.onScrim),
        shape: shape ??
            WidgetStateProperty.all<OutlinedBorder>(
              const CircleBorder(), // 圆形
            ),
      ),
      onPressed: onPressed,
    );
  }
}
