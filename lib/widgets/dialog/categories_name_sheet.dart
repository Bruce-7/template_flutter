import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/db_prefs_extension.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:flutter_app/widgets/dialog/text_field_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoriesNameSheet extends HookConsumerWidget {
  // 选择的分类名称
  final String selectedCategoryName;
  final int maxLength;

  const CategoriesNameSheet({
    super.key,
    required this.selectedCategoryName,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesName = dbManager.categoriesName();
    final selectedCategoryNameState = useState(selectedCategoryName);

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = categoriesName[index];
                final isSelected = selectedCategoryNameState.value == category;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (isSelected) {
                      // 再次点击已选择的分类，取消选择
                      selectedCategoryNameState.value = '';
                    } else {
                      selectedCategoryNameState.value = category;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: context.spacing.md),
                    decoration: ShapeDecoration(
                      color: context.colors.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: context.radius.radiusFull,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            category,
                            style: context.textStyle.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: context.colors.primary,
                            size: 20,
                          )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: categoriesName.length,
            ),
          ),
          // 底部按钮区域
          Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _createNewCategory(context, categoriesName);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: context.spacing.md),
                  decoration: ShapeDecoration(
                    color: context.colors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: context.radius.radiusFull,
                      side: BorderSide(
                        width: context.spacing.strokeThin,
                        color: context.colors.outline,
                      ),
                    ),
                  ),
                  child: Text(
                    '+ ${'新建分类'.tr()}',
                    style: context.textStyle.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    // 返回选中的分类，空字符串表示取消选择
                    Navigator.pop(context, selectedCategoryNameState.value);
                  },
                  child: Text('确定'.tr()),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

extension CategoriesNameSheetFunction on CategoriesNameSheet {
  Future<String?> show(BuildContext context) async {
    return await ActionDialog(
      isDismissible: true,
      showCloseButton: true,
      style: ActionDialogStyle.sheet,
      showViewPaddingBottom: true,
      title: '选择分类'.tr(),
      contentWidget: this,
    ).show(context);
  }

  Future<void> _createNewCategory(BuildContext context, List<String> categoriesName) async {
    final result = await TextFieldDialog(
      title: '新建分类'.tr(),
      hintText: '分类名称'.tr(),
      maxLength: maxLength,
    ).show(context);

    if (context.mounted && result?.isNotEmpty == true) {
      if (categoriesName.contains(result)) {
        CommonUtil.showToast('分类已存在'.tr());
        return;
      }

      categoriesName.add(result!);
      dbManager.setCategoriesName(categoriesName);
      Navigator.pop(context, result);
    }
  }
}
