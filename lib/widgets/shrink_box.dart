import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/theme_mode_state.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/widgets/focus_detector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShrinkBox extends HookConsumerWidget {
  final Widget child;

  // 内容超出的限制最大高度才会显示（展开）
  final double limitMaxHeight;

  // 内容最小高度
  final double limitMinHeight;

  final List<Color> lightLinearGradient;
  final List<Color> darkLinearGradient;

  const ShrinkBox({
    super.key,
    required this.limitMaxHeight,
    required this.lightLinearGradient,
    required this.darkLinearGradient,
    required this.child,
    this.limitMinHeight = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpandedState = useState(false);
    final isShowExpandState = useState(false);
    final initialHeightState = useState(20.0); // 默认20的高度，然后再根据内容自动变成最后的高。
    final contentKey = useMemoized(() => GlobalKey<FormState>());
    final isDark = ref.read(themeModeStateProvider.notifier).isDark(context);

    useEffect(() {
      // 获得渲染后准确的高度
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshHeight(contentKey, isExpandedState, isShowExpandState, initialHeightState);
      });
      return;
    }, []);

    return FocusDetector(
      onFocusGained: () {
        _refreshHeight(contentKey, isExpandedState, isShowExpandState, initialHeightState);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: ClipRect(
                  child: ConstrainedBox(
                    constraints: isExpandedState.value ? BoxConstraints(minHeight: limitMinHeight) : BoxConstraints(maxHeight: limitMaxHeight + 1, minHeight: limitMinHeight), // +1是为了防止显示 【展示、收起】按钮
                    child: Container(
                      key: contentKey,
                      child: child,
                    ),
                  ),
                ),
              ),
              if (isExpandedState.value == false && isShowExpandState.value == true)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 43,
                    width: double.infinity,
                    // 渐变效果
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: isDark ? darkLinearGradient : lightLinearGradient,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (isShowExpandState.value == true)
            GestureDetector(
              onTap: () {
                isExpandedState.value = !isExpandedState.value;
                _refreshHeight(contentKey, isExpandedState, isShowExpandState, initialHeightState);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  isExpandedState.value ? '收起'.tr() : '展开'.tr(),
                  style: context.textStyle.bodyMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

extension ShrinkBoxFunction on ShrinkBox {
  double _getEditorHeight(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      return renderBox.size.height;
    } else {
      return 0;
    }
  }

  double _refreshHeight(GlobalKey key, ValueNotifier<bool> isExpandedState, ValueNotifier<bool> isShowExpandState, ValueNotifier<double> initialHeightState) {
    final height = _getEditorHeight(key);

    if (height <= 0) {
      isShowExpandState.value = false;
      return limitMaxHeight;
    }

    if (height <= limitMaxHeight) {
      isShowExpandState.value = false;
      initialHeightState.value = height;
      return height;
    } else {
      isShowExpandState.value = true;

      if (isExpandedState.value == false) {
        initialHeightState.value = limitMaxHeight;
        return limitMaxHeight;
      } else {
        initialHeightState.value = height;
        return height;
      }
    }
  }
}
