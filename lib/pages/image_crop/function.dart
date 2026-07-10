part of 'page.dart';

extension ImageCropPageFunction on ImageCropPage {
  // 点击完成，处理裁剪图片逻辑。
  Future<void> _onCompleteClick(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<ExtendedImageEditorState> editorKey,
    ImageEditorController imageEditorController,
  ) async {
    final state = editorKey.currentState;

    CommonUtil.showLoading(msg: '处理中'.tr());
    final cropImageData = await _cropImageData(state, imageEditorController);
    CommonUtil.dismiss();

    if (context.mounted) {
      // 返回裁剪生成图片数据
      Navigator.pop(context, cropImageData);
    }
  }

  Future<Uint8List?> _cropImageData(
    ExtendedImageEditorState? state,
    ImageEditorController imageEditorController,
  ) async {
    if (state == null) return null;

    final EditActionDetails? action = state.editAction;

    final ImageEditorOption option = ImageEditorOption();

    if (action?.hasRotateDegrees == true) {
      final int rotateDegrees = action!.rotateDegrees.toInt();
      option.addOption(RotateOption(rotateDegrees));
    }

    if (action?.flipY == true) {
      option.addOption(const FlipOption(horizontal: true, vertical: false));
    }

    if (action?.needCrop == true) {
      Rect cropRect = imageEditorController.getCropRect()!;
      option.addOption(ClipOption.fromRect(cropRect));
    }

    // 输出图片质量
    option.outputFormat = const OutputFormat.png();

    return ImageEditor.editImage(image: state.rawImageData, imageEditorOption: option);
  }
}
