import 'dart:ui' as ui show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 点击空白处收起键盘的组件（包含状态栏区域）
class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 收起键盘（包括状态栏区域点击）
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (PointerDownEvent event) {
        final focus = FocusManager.instance.primaryFocus;

        if (focus != null) {
          // 判断点击位置对应的 RenderObject
          final result = HitTestResult();
          WidgetsBinding.instance.hitTestInView(result, event.position, ui.PlatformDispatcher.instance.implicitView!.viewId);

          // 如果点击的不是 EditableText（TextField 内部实现），才收起键盘
          final isTextField = result.path.any(
            (e) => e.target is RenderEditable,
          );

          if (!isTextField) {
            focus.unfocus();
          }
        }
      },
      child: child,
    );
  }
}
