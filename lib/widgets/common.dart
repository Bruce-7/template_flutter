import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';

/// field文本框自定义计数器显示
Widget fieldCustomCounterSuffix(TextEditingController controller, int maxLength, {TextStyle? style}) {
  return ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, value, child) {
      return Text(
        '${controller.text.length}/$maxLength',
        style: style,
      );
    },
  );
}

/// 显示公共的日期选择
Future<DateTime?> showCommonDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  return await showDatePicker(
    context: context,
    barrierColor: context.colors.scrim,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime.now(),
    // errorInvalidText: '超出范围'.tr(),
    // errorFormatText: '格式无效'.tr(),
    // cancelText: '取消'.tr(),
    // confirmText: '确定'.tr(),
    // helpText: '选择日期'.tr(),
    // 设置locale自动根据系统组件适配国际化。
    locale: context.locale,
    builder: (BuildContext context, Widget? child) {
      final theme = Theme.of(context);
      // 替换flutter系统组件为自定义主题
      return Theme(
        data: theme.copyWith(
          textButtonTheme: TextButtonThemeData(
            style: theme.textButtonTheme.style?.copyWith(
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ),
        child: child ?? const SizedBox(),
      );
    },
  );
}

// /// 显示会员订阅引导弹窗
// void showPremiumActiveDialog(
//   BuildContext context, {
//   required String content,
// }) {
//   ActionDialog(
//     title: '温馨提示'.tr(),
//     content: content,
//     mainButtonText: '前往'.tr(),
//     mainButtonAction: (_) {
//       Navigator.pop(context);
//       RoutesNavigator.push(SubscriptionRoute());
//     },
//     subButtonText: '取消'.tr(),
//   ).show(context);
// }

/// widget转图片二进制数据
Future<Uint8List> widgetToUint8List(Widget widget) async {
  final repaintBoundary = RenderRepaintBoundary();
  final renderView = RenderView(
    view: ui.PlatformDispatcher.instance.views.first,
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
    configuration: ViewConfiguration.fromView(ui.PlatformDispatcher.instance.views.first),
  );

  final pipelineOwner = PipelineOwner();
  final buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: Directionality(
      textDirection: ui.TextDirection.ltr,
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: widget,
        ),
      ),
    ),
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final ui.Image image = await repaintBoundary.toImage(pixelRatio: 3.0);
  final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  if (byteData == null) {
    return Uint8List(0);
  }

  return byteData.buffer.asUint8List();
}

Widget? extendedImageLoadStateChanged({
  required BuildContext context,
  required ExtendedImageState state,
}) {
  switch (state.extendedImageLoadState) {
    // 加载中状态
    case LoadState.loading:
      final progress = state.loadingProgress;
      double? value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
      }

      return Center(
        child: CircularProgressIndicator(
          color: context.colors.primary,
          value: value,
        ),
      );

    // 加载失败
    case LoadState.failed:
      return Center(
        child: Icon(
          size: 40,
          Icons.broken_image_outlined,
          color: context.colors.onSurface,
        ),
      );

    case LoadState.completed:
      return state.completedWidget;
  }
}

/// Emoji图标组件
/// 用于统一显示emoji，解决安卓平台显示偏移和大小问题
Widget buildEmojiIcon(
  BuildContext context, {
  required String emoji,
  required double size,
  double? fontSize,
}) {
  return SizedBox(
    width: size,
    height: size,
    child: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Center(
        child: Text(
          emoji,
          style: context.textStyle.labelSmall.copyWith(
            fontSize: fontSize ?? size * 0.8,
            height: 1.0,
          ),
        ),
      ),
    ),
  );
}

/// 构建Row项
Widget buildRowItem(
  BuildContext context, {
  required String title,
  EdgeInsetsGeometry? padding,
  Widget? trailing,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: context.spacing.md, vertical: context.spacing.sm),
      decoration: ShapeDecoration(
        color: context.colors.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: context.radius.radiusFull),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.textStyle.bodyMedium,
            ),
          ),
          ?trailing,
        ],
      ),
    ),
  );
}
