import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverPinnedToBoxAdapter extends SingleChildRenderObjectWidget {
  const SliverPinnedToBoxAdapter({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _SliverPinnedToBoxAdapterRender();
}

class _SliverPinnedToBoxAdapterRender extends RenderSliverSingleBoxAdapter {
  // 寻找上一个吸顶的header
  RenderSliver? _prev() {
    if (parent is RenderViewportBase) {
      RenderSliver? current = this;
      while (current != null) {
        current = (parent as RenderViewportBase).childBefore(current);
        if (current is _SliverPinnedToBoxAdapterRender && current.geometry != null) {
          return current;
        }
      }
    }
    return null;
  }

  // 必须重写，否则点击事件失效。
  @override
  double childMainAxisPosition(covariant RenderBox child) => 0.0;

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;

    // 摆放子View，并把constraints传递给子View
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);

    // 获取子View在滑动主轴方向的尺寸
    final double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    final double minExtent = childExtent;
    final double minAllowedExtent = constraints.remainingPaintExtent > minExtent ? minExtent : constraints.remainingPaintExtent;
    final double maxExtent = childExtent;
    final double paintExtent = maxExtent;
    final double clampedPaintExtent = clampDouble(
      paintExtent,
      minAllowedExtent,
      constraints.remainingPaintExtent,
    );
    final double layoutExtent = maxExtent - constraints.scrollOffset;

    geometry = SliverGeometry(
      scrollExtent: maxExtent,
      paintOrigin: min(constraints.overlap, 0.0),
      paintExtent: clampedPaintExtent,
      layoutExtent: clampDouble(layoutExtent, 0.0, clampedPaintExtent),
      maxPaintExtent: maxExtent,
      maxScrollObstructionExtent: minExtent,
      hasVisualOverflow: true,


    );

    // 把上一个吸顶的header上推的关键代码。
    // 当前吸顶的Sliver被覆盖了多少，前一个吸顶的Sliver就上移多少。
    RenderSliver? prev = _prev();
    if (prev != null && constraints.overlap > 0) {
      setChildParentData(
        _prev()!,
        constraints.copyWith(scrollOffset: constraints.overlap),
        _prev()!.geometry!,
      );
    }
  }
}
