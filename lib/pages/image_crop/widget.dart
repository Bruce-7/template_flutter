part of 'page.dart';

extension ImageCropPageWidget on ImageCropPage {
  Widget _buildBottomButtons(
    BuildContext context,
    WidgetRef ref,
    Color primaryColor,
    ImageEditorController imageEditorController,
    GlobalKey<ExtendedImageEditorState> editorKey,
  ) {
    final foregroundColor = context.colors.onSurface;
    final disabledColor = foregroundColor.withValues(alpha:0.1);

    final textStyle = context.textStyle.bodyMedium.copyWith(
      color: foregroundColor,
    );

    final textButtonStyle = ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledColor;
        }

        return foregroundColor;
      }),
      overlayColor: WidgetStateProperty.all(disabledColor),
      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
      textStyle: WidgetStateProperty.all(textStyle),
    );

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.all((textStyle.fontSize ?? 1.0) * 1.70),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                foregroundColor: WidgetStateProperty.resolveWith(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return disabledColor;
                    }

                    if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
                      return primaryColor;
                    }

                    return foregroundColor;
                  },
                ),
              ),
              onPressed: () {
                // 逆时针旋转90度（向左旋转）
                imageEditorController.rotate(degree: -90);
              },
              icon: const Icon(
                Icons.rotate_left,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                imageEditorController.reset();
              },
              style: textButtonStyle,
              child: Text(
                '还原'.tr(),
              ),
            ),
          ],
        ),
        Container(
          color: foregroundColor.withValues(alpha:0.3),
          height: 0.5,
          margin: const EdgeInsets.symmetric(vertical: 20),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: textButtonStyle,
              child: Text(
                '取消'.tr(),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                _onCompleteClick(context, ref, editorKey, imageEditorController);
              },
              style: textButtonStyle,
              child: Text(
                '完成'.tr(),
              ),
            ),
          ],
        ),
        SizedBox(height: CommonUtil.bottomViewPadding(context)),
      ],
    );
  }
}
