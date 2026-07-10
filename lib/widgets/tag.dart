import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';

class Tag extends StatefulWidget {
  final Widget textWidget;

  /// 背景颜色
  final Color? backgroundColor;

  /// 自定义图标内容
  final Widget? iconWidget;

  /// 线框粗细
  final double? borderWidth;

  /// 边框颜色
  final Color? borderColor;

  /// 圆角
  final double? borderRadius;

  /// 文字内边距
  final EdgeInsets? padding;

  const Tag({
    super.key,
    required this.textWidget,
    this.iconWidget,
    this.backgroundColor,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  });

  @override
  State<StatefulWidget> createState() {
    return TagState();
  }
}

class TagState extends State<Tag> {
  @override
  void initState() {
    super.initState();
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: widget.backgroundColor, // 背景颜色
      borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : BorderRadius.circular(context.radius.md),
      border: Border.all(
        color: widget.borderColor ?? context.colors.outline, // 边框颜色
        width: widget.borderWidth ?? context.spacing.strokeThin, // 边框宽度
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: _getBoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.iconWidget != null) widget.iconWidget!,
          widget.textWidget,
        ],
      ),
    );
  }
}
