part of 'dropdown_popup.dart';

typedef FutureParamCallback = void Function(Future<void> Function());

// 处理动画
class _DropdownPanel extends StatefulWidget {
  const _DropdownPanel({
    required this.initContentTop,
    required this.initContentBottom,
    required this.reverseHeight,
    required this.duration,
    required this.direction,
    required this.closeCallback,
    required this.onOpened,
    required this.child,
    this.alignment = Alignment.bottomCenter,
    this.leftOffset,
    this.rightOffset,
  });

  final double initContentTop;
  final double initContentBottom;
  final double reverseHeight;
  final Duration duration;
  final DropdownPopupDirection direction;
  final FutureParamCallback closeCallback;
  final VoidCallback onOpened;
  final Widget child;

  // child自定义widget的对齐
  final Alignment alignment;

  // child自定义widget的偏移（默认就按child的宽度）
  final double? leftOffset;
  final double? rightOffset;

  @override
  _DropdownPanelState createState() => _DropdownPanelState();
}

class _DropdownPanelState extends State<_DropdownPanel> with SingleTickerProviderStateMixin {
  double? contentTop, contentBottom, contentLeft, contentRight;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    widget.closeCallback(close);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _getAnimation(),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(), // 禁用滚动
        child: Align(
          alignment: widget.alignment,
          child: Material(
            color: context.colors.transparent,
            child: Builder(
              builder: (BuildContext context) {
                _open(context);

                return widget.child;
              },
            ),
          ),
        ),
      ),
    );
  }

  void _open(BuildContext itemContext) {
    if (contentBottom != null || contentTop != null) {
      return;
    }

    // 在当前帧渲染完成后再执行这个回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final screenWidth = MediaQuery.of(context).size.width;
      var renderBox = itemContext.findRenderObject() as RenderBox;
      var size = renderBox.size;
      final position = renderBox.localToGlobal(Offset.zero);

      if (widget.direction == DropdownPopupDirection.down) {
        contentBottom = widget.initContentBottom - size.height;
      } else {
        contentTop = widget.initContentTop - size.height;
      }

      if (widget.leftOffset == null) {
        contentLeft = position.dx;
      } else {
        contentLeft = widget.leftOffset;
      }

      if (widget.rightOffset == null) {
        contentRight = screenWidth - position.dx - size.width;
      } else {
        contentRight = widget.rightOffset;
      }

      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward().whenCompleteOrCancel(() {
            widget.onOpened();
          });
        }
      });
    });
  }

  Animation<RelativeRect> _getAnimation() {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        contentLeft ?? 0,
        (contentTop ?? widget.initContentTop),
        contentRight ?? 0,
        (contentBottom ?? widget.initContentBottom),
      ),
      end: RelativeRect.fromLTRB(
        contentLeft ?? 0,
        (contentTop ?? widget.initContentTop),
        contentRight ?? 0,
        (contentBottom ?? widget.initContentBottom),
      ),
    ).animate(_controller);
  }

  Future<void> close() {
    return _controller.reverse();
  }
}
