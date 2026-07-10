import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';

part 'dropdown_panel.dart';

/// 菜单展开方向
enum DropdownPopupDirection {
  /// 向下
  down,

  /// 向上
  up,
}

class DropdownPopup extends StatefulWidget {
  const DropdownPopup({
    super.key,
    required this.nodeWidget,
    required this.child,
    this.direction = DropdownPopupDirection.down,
    this.closeOnClickOverlay = true,
    this.duration = const Duration(milliseconds: 200),
    this.backgroundColor,
    this.barrierBackgroundColor,
    this.nodeBackgroundColor,
    this.childBackgroundColor,
    this.leftOffset,
    this.rightOffset,
    this.topOffset,
    this.bottomOffset,
    this.alignment = Alignment.bottomCenter,
    this.onOpened,
    this.onClose,
    this.isActive = false,
    this.isForbidClick = false,
  });

  final Widget nodeWidget;

  // 自定义内容
  final Widget child;

  final DropdownPopupDirection direction;

  /// 整个遮罩背景色
  final Color? backgroundColor;

  // 节点的展开反方向的背景色（如果有值覆盖backgroundColor）
  final Color? barrierBackgroundColor;

  // 节点的背景色（如果有值覆盖backgroundColor）
  final Color? nodeBackgroundColor;

  // 当前弹出菜单的背景色颜色（如果有值覆盖backgroundColor）
  final Color? childBackgroundColor;

  /// 是否在点击遮罩层后关闭菜单
  final bool? closeOnClickOverlay;

  /// 动画时长
  final Duration? duration;

  // child自定义widget的偏移（默认就按child的宽度）
  final double? leftOffset;
  final double? rightOffset;

  // down生效（默认就按child的宽度）
  final double? topOffset;

  // up生效（默认就按child的宽度）
  final double? bottomOffset;

  // child自定义widget的对齐，目前根据direction来判断。
  // topLeft和bottomLeft都是在左边。
  // topRight和bottomRight都是在右边。
  // center和topCenter、bottomCenter都是在中间。
  final Alignment alignment;

  /// 完成打开的回调
  final VoidCallback? onOpened;

  // 内部关闭回调
  final VoidCallback? onClose;

  // 是否主动弹出
  final bool isActive;

  // 如果禁止点击，点击就不会弹窗，一般和isActive搭配使用。
  final bool isForbidClick;

  @override
  State<DropdownPopup> createState() => DropdownPopupState();
}

class DropdownPopupState extends State<DropdownPopup> {
  /// _overlay1：下拉方向的
  /// _overlay2：menu部分的
  /// _overlay3：下拉反方向的
  /// _overlay3Height：下拉反方向的高度，用于判断auto方向
  /// _initContent：初始内容
  late double _overlay1Top, _overlay1Bottom, _overlay2Top, _overlay2Bottom, _overlay3Top, _overlay3Bottom, _overlay3Height, _initContentTop, _initContentBottom;

  late Future<void> Function() _closeContent;

  Duration get _duration => widget.duration ?? const Duration(milliseconds: 200);

  final GlobalKey globalKey = GlobalKey();

  // 计算位置
  void _calculatePosition() {
    BuildContext? nodeContext = globalKey.currentContext;

    if (nodeContext == null) {
      return;
    }

    var renderBox = nodeContext.findRenderObject() as RenderBox;

    var position = renderBox.localToGlobal(Offset.zero);
    // 避免浮点数出现横线
    position = Offset(position.dx, position.dy.floor().toDouble());
    var size = renderBox.size;
    var screenHeight = MediaQuery.of(nodeContext).size.height;

    if (widget.direction == DropdownPopupDirection.down) {
      _overlay1Top = position.dy + size.height;
      _overlay2Top = position.dy;
      _overlay3Top = 0;

      _overlay1Bottom = 0;
      _overlay2Bottom = screenHeight - position.dy - size.height;
      _overlay3Bottom = screenHeight - position.dy;

      _overlay3Height = position.dy;

      _initContentTop = position.dy + size.height + (widget.topOffset ?? 0);
      _initContentBottom = screenHeight - position.dy - size.height - (widget.topOffset ?? 0);

      _overlay1Top += (widget.topOffset ?? 0);
    } else {
      _overlay1Top = 0;
      _overlay2Top = position.dy;
      _overlay3Top = position.dy + size.height;

      _overlay1Bottom = screenHeight - position.dy;
      _overlay2Bottom = screenHeight - position.dy - size.height;
      _overlay3Bottom = 0;

      _overlay3Height = screenHeight - position.dy - size.height;

      _initContentTop = position.dy - (widget.bottomOffset ?? 0);
      _initContentBottom = screenHeight - position.dy + (widget.bottomOffset ?? 0);

      _overlay1Bottom += (widget.bottomOffset ?? 0);
    }
  }

  OverlayEntry? overlayEntry;

  void showPopup() {
    _calculatePosition();

    showGeneralDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: context.colors.transparent,
      transitionDuration: _duration,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return _body();
      },
    ).then((value) {
      // 弹窗关闭后执行收尾工作
      widget.onClose?.call();
      _closeContent.call();
    });
  }

  Widget _barrierWidget(Widget barrier, Color? color) {
    return AnimatedContainer(
      color: color,
      duration: _duration,
      child: barrier,
    );
  }

  Widget _getOverlay1(Widget barrier) {
    return Positioned(
      top: _overlay1Top,
      bottom: _overlay1Bottom,
      left: 0,
      right: 0,
      child: _barrierWidget(barrier, widget.childBackgroundColor ?? widget.backgroundColor),
    );
  }

  Widget _getOverlay2(Widget barrier) {
    return Positioned(
      top: _overlay2Top,
      bottom: _overlay2Bottom,
      left: 0,
      right: 0,
      child: _barrierWidget(barrier, widget.nodeBackgroundColor ?? widget.backgroundColor),
    );

    // return Positioned(
    //   top: _overlay2Top,
    //   bottom: _overlay2Bottom,
    //   left: 0,
    //   right: 0,
    //   child: GestureDetector(
    //     onVerticalDragUpdate: (details) {},
    //     onHorizontalDragUpdate: (details) {},
    //     behavior: HitTestBehavior.translucent,
    //   ),
    // );
  }

  Widget _getOverlay3(Widget barrier) {
    // 顶部透明遮罩是否支持穿透。
    // return Positioned(
    //   top: _overlay3Top,
    //   bottom: _overlay3Bottom,
    //   left: 0,
    //   right: 0,
    //   child: GestureDetector(
    //     onVerticalDragUpdate: (details) {},
    //     onHorizontalDragUpdate: (details) {},
    //     behavior: HitTestBehavior.translucent,
    //   ),
    // );

    return Positioned(
      top: _overlay3Top,
      bottom: _overlay3Bottom,
      left: 0,
      right: 0,
      child: _barrierWidget(barrier, widget.barrierBackgroundColor ?? widget.backgroundColor),
    );
  }

  void _overlayClick(BuildContext context) {
    if (!(widget.closeOnClickOverlay ?? true)) {
      return;
    }

    Navigator.of(context).pop();
  }

  void _closeCallback(Future<void> Function() fn) {
    _closeContent = fn;
  }

  Widget _body() {
    final barrier = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _overlayClick(context);
      },
    );

    return Stack(
      children: [
        _getOverlay1(barrier),
        _getOverlay2(barrier),
        _getOverlay3(barrier),
        _DropdownPanel(
          duration: _duration,
          direction: widget.direction,
          initContentTop: _initContentTop,
          initContentBottom: _initContentBottom,
          reverseHeight: _overlay3Height,
          leftOffset: widget.leftOffset,
          rightOffset: widget.rightOffset,
          alignment: widget.alignment,
          closeCallback: _closeCallback,
          onOpened: () {
            widget.onOpened?.call();
          },
          child: widget.child,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isActive) {
        showPopup();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: globalKey,
      onTap: () {
        if (widget.isForbidClick == false) {
          showPopup();
        }
      },
      child: widget.nodeWidget,
    );
  }
}
