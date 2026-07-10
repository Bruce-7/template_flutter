import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ActionDialogStyle { dialog, sheet }

class ActionDialog extends HookConsumerWidget {
  // 标题
  final String? title;

  // title 有值有效。显示右上角关闭按钮（默认false）
  final bool showCloseButton;

  // 副标题
  final String? subTitle;

  // 内容
  final String? content;

  // 内容Widget，如果自定义。
  final Widget? contentWidget;

  // 主按钮文本（设置才会显示按钮）
  final String? mainButtonText;

  // 次按钮文本（设置才会显示按钮）
  final String? subButtonText;

  // 主按钮点击（传入则内部不主动触发关闭）
  final Function(BuildContext context)? mainButtonAction;

  // 次按钮点击（传入则内部不主动触发关闭）
  final Function(BuildContext context)? subButtonAction;

  // 仅针对水平两个按钮显示时生效
  final int subButtonFlex;
  final int mainButtonFlex;

  // 关闭按钮点击（传入则内部不主动触发关闭）
  final Function(BuildContext context)? closeButtonAction;

  // 点击蒙层能否关闭、物理键返回（默认false）
  final bool isDismissible;

  // 如果显示两个按钮，选项是否是垂直排布，默认是左右排布（默认false）。
  final bool vertical;

  // 弹窗样式
  final ActionDialogStyle style;

  // 内边距
  final EdgeInsetsGeometry padding;

  // 内容对齐方式
  final TextAlign contentAlign;

  // 如果自定义按钮区域，则内部按钮不创建。
  final Widget? buttonGroupWidget;

  // 最底显示系统键盘等组件导致的内边距
  final bool showViewInsetsBottom;

  // 是否现在底部安全区域
  final bool showViewPaddingBottom;

  const ActionDialog({
    super.key,
    this.title,
    this.subTitle,
    this.content,
    this.contentWidget,
    this.mainButtonText,
    this.subButtonText,
    this.mainButtonAction,
    this.subButtonAction,
    this.subButtonFlex = 1,
    this.mainButtonFlex = 1,
    this.showCloseButton = false,
    this.closeButtonAction,
    this.isDismissible = false,
    this.vertical = false,
    this.style = ActionDialogStyle.dialog,
    this.padding = const EdgeInsets.all(12.0),
    this.contentAlign = TextAlign.center,
    this.buttonGroupWidget,
    this.showViewInsetsBottom = false,
    this.showViewPaddingBottom = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 此方法仅用于直接使用 ActionDialog 作为 Widget 的场景
    // 通过 Future<T?> show<T>(BuildContext context) 方法弹出时，会使用 extension 中的 _buildWithContext
    return _buildWithContext(context, ref);
  }
}

extension ActionDialogFunction on ActionDialog {
  Future<T?> show<T>(BuildContext context) async {
    if (style == ActionDialogStyle.dialog) {
      return showDialog<T>(
        context: context,
        useSafeArea: false,
        barrierDismissible: isDismissible,
        builder: (dialogContext) => Dialog(
          child: Consumer(
            // 添加 Consumer 是为了解决，在系统层面修改Dark、Light，弹窗内部自定义的Widget没有变化。
            builder: (consumerContext, ref, child) => _buildWithContext(consumerContext, ref),
          ),
        ),
      );
    } else {
      return showModalBottomSheet<T>(
        context: context,
        useSafeArea: false,
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: isDismissible,
        builder: (sheetContext) {
          return Consumer(
            // 添加 Consumer 是为了解决，在系统层面修改Dark、Light，弹窗内部自定义的Widget没有变化。
            builder: (consumerContext, ref, child) => _buildWithContext(consumerContext, ref),
          );
        },
      );
    }
  }

  // 弹窗最大高度
  double _getMaxHeight(BuildContext context) {
    // 获取屏幕高度
    double height = MediaQuery.of(context).size.height;
    // 最高80%
    return (height * 0.8).floor() + 0.0;
  }

  // 弹窗最大宽度度
  double _getMaxWidth(BuildContext context) {
    if (style == ActionDialogStyle.sheet) {
      return double.infinity;
    }

    // 获取屏幕宽度
    double width = MediaQuery.of(context).size.width;

    // 计算屏幕宽度的80%（向下取整）
    return (width * 0.9).floor() + 0.0;
  }

  void _dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildWithContext(BuildContext context, WidgetRef ref) {
    final tempMaxMinWidth = _getMaxWidth(context);
    final tempMaxHeight = _getMaxHeight(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: tempMaxHeight,
        minWidth: tempMaxMinWidth,
        maxWidth: tempMaxMinWidth,
      ),
      child: _buildBody(context, ref),
    );
  }
}

extension ActionDialogWidget on ActionDialog {
  // 获取主按钮
  Widget _mainButton(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (mainButtonAction != null) {
          mainButtonAction!(context);
          return;
        }

        _dismiss(context);
      },
      child: Text(mainButtonText ?? '确定'.tr()),
    );
  }

  // 获取次按钮
  Widget _subButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (subButtonAction != null) {
          subButtonAction!(context);
          return;
        }

        _dismiss(context);
      },
      child: Text(subButtonText ?? '取消'.tr()),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    // 自定义按钮区域
    if (buttonGroupWidget != null) {
      return buttonGroupWidget!;
    }

    bool isAll = mainButtonText?.isNotEmpty == true && subButtonText?.isNotEmpty == true;

    if (vertical && isAll) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _mainButton(context),
            const SizedBox(height: 6),
            _subButton(context),
          ],
        ),
      );
    }

    if (isAll) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Expanded(
              flex: subButtonFlex,
              child: _subButton(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: mainButtonFlex,
              child: _mainButton(context),
            ),
          ],
        ),
      );
    }

    if (mainButtonText?.isNotEmpty == true) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Expanded(child: _mainButton(context)),
          ],
        ),
      );
    }

    if (subButtonText?.isNotEmpty == true) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Expanded(child: _subButton(context)),
          ],
        ),
      );
    }

    return const SizedBox();
  }

  Widget _contentWidget(BuildContext context) {
    if (content?.isNotEmpty == true) {
      return Flexible(
        child: SingleChildScrollView(
          child: Text(
            content ?? '',
            textAlign: contentAlign,
            style: context.textStyle.bodyMedium,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    const titlePadding = 4.0;

    return Container(
      width: double.infinity,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: titlePadding, horizontal: 36),
                  child: Center(
                    child: Text(
                      title ?? '',
                      style: context.textStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Visibility(
                  visible: showCloseButton,
                  child: Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        if (closeButtonAction != null) {
                          closeButtonAction!(context);
                          return;
                        }
                        _dismiss(context);
                      },
                      iconSize: 16,
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close),
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          context.colors.surfaceContainer,
                        ),
                        shape: WidgetStateProperty.all(const CircleBorder()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (subTitle != null)
            Padding(
              padding: EdgeInsets.only(top: title != null ? 4.0 : 0),
              child: Text(
                subTitle ?? '',
                style: context.textStyle.labelLarge,
              ),
            ),
          if (title?.isNotEmpty == true || subTitle?.isNotEmpty == true) const SizedBox(height: 8.0),
          if (contentWidget != null) contentWidget! else _contentWidget(context),
          _bottomButtons(context),
          if (showViewInsetsBottom == true)
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
            )
          else if (showViewPaddingBottom)
            SizedBox(
              height: CommonUtil.bottomViewPadding(context),
            ),
        ],
      ),
    );
  }
}
