import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/sliver_pinned_to_box_adapter.dart';

// 不支持自动适配剩余空间的吸顶列表组件
class GroupedListView extends CustomScrollView {
  /// 数据源组的数量
  final int groupCount;

  /// 数据源每一组的item的数量
  final int Function(int groupIndex) itemCount;

  final Widget Function(int index)? groupHeaderBuilder;

  final Widget Function(int groupIndex, int index)? itemBuilder;

  final Widget Function(int groupIndex, int index)? itemSeparatorBuilder;

  /// 是否隐藏最后一个分离器回调（默认隐藏最后一个[itemSeparatorBuilder]回调）。
  final bool hiddenLastSeparator;

  /// 是否header吸顶（默认吸顶）
  final bool pinned;

  /// Creates a [GroupedListView]
  const GroupedListView({
    super.key,
    required this.groupCount,
    required this.itemCount,
    this.groupHeaderBuilder,
    this.itemBuilder,
    this.itemSeparatorBuilder,
    this.hiddenLastSeparator = true,
    this.pinned = true,
  });

  @override
  List<Widget> buildSlivers(BuildContext context) {
    return _handleWidget();
  }

  List<Widget> _handleWidget() {
    List<Widget> slivers = [];
    for (int i = 0; i < groupCount; i++) {
      if (groupHeaderBuilder != null) {
        if (pinned) {
          // 吸顶且推走上一个吸顶的header
          slivers.add(
            SliverPinnedToBoxAdapter(
              child: RepaintBoundary(
                // 优化绘制性能的特殊 widget
                child: _buildGroupHeader(i),
              ),
            ),
          );
        } else {
          slivers.add(
            SliverToBoxAdapter(
              child: RepaintBoundary(
                // 优化绘制性能的特殊 widget
                child: _buildGroupHeader(i),
              ),
            ),
          );
        }
      }

      // 自动适配剩余空间
      // slivers.add(
      //   SliverFillRemaining(
      //     hasScrollBody: true,
      //     child: _buildItemAndSeparator(i, 0),
      //   ),
      // );

      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: itemCount(i),
            (context, index) {
              return RepaintBoundary(
                // 优化绘制性能的特殊 widget
                child: _buildItemAndSeparator(i, index),
              );
            },
          ),
        ),
      );
    }

    return slivers;
  }

  Widget _buildGroupHeader(int index) {
    if (groupHeaderBuilder != null) {
      return groupHeaderBuilder!(index);
    }
    return const SizedBox();
  }

  Widget _buildItemAndSeparator(int groupIndex, int index) {
    List<Widget> children = [];

    if (itemBuilder != null) {
      children.add(itemBuilder!(groupIndex, index));
    }

    if (itemSeparatorBuilder != null && (index != itemCount(groupIndex) - 1 || !hiddenLastSeparator)) {
      children.add(itemSeparatorBuilder!(groupIndex, index));
    }

    return Column(
      children: children,
    );
  }
}
