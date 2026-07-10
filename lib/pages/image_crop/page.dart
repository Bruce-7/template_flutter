import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/pages/image_crop/widgets/circle_editor_crop_layer_painter.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_app/widgets/common.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_editor/image_editor.dart';

part 'function.dart';

part 'widget.dart';

enum ImageCropPageType {
  circle,
  square,
}

// 图片裁剪页面固定Dark模式
@RoutePage()
class ImageCropPage extends HookConsumerWidget {
  final String imagePath;
  final ImageCropPageType type;

  const ImageCropPage({
    super.key,
    required this.imagePath,
    this.type = ImageCropPageType.square,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () {
        log.d('$this dispose');
      };
    }, []);

    final editorKey = useMemoized(() => GlobalKey<ExtendedImageEditorState>());
    final imageEditorController = useMemoized(() => ImageEditorController());
    final darkThemeData = AppTheme.getTheme(context, true);

    return Theme(
      data: darkThemeData,
      child: Builder(builder: (context) {
        final primaryColor = context.colors.primary;
        final maskColor = context.colors.scrim;
        final maskDownColor = context.colors.transparent;

        return PopScope(
          canPop: false,
          child: Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: Stack(
                children: [
                  ExtendedImage.file(
                    File(imagePath),
                    cacheRawData: true,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.editor,
                    extendedImageEditorKey: editorKey,
                    loadStateChanged: (state) {
                      return extendedImageLoadStateChanged(context: context, state: state);
                    },
                    initEditorConfigHandler: (state) {
                      return EditorConfig(
                        controller: imageEditorController,
                        initialCropAspectRatio: CropAspectRatios.ratio1_1,
                        cropAspectRatio: CropAspectRatios.ratio1_1,
                        initCropRectType: InitCropRectType.layoutRect,
                        cornerColor: primaryColor,
                        lineColor: primaryColor,
                        cropLayerPainter: type == ImageCropPageType.square
                            ? const EditorCropLayerPainter()
                            : CircleEditorCropLayerPainter(
                                borderColor: primaryColor,
                                maskColor: maskColor,
                                maskDownColor: maskDownColor,
                              ),
                        editorMaskColorHandler: (BuildContext context, bool pointerDown) {
                          if (pointerDown) {
                            return maskDownColor;
                          }
                          return maskColor;
                        },
                      );
                    },
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: _buildBottomButtons(
                      context,
                      ref,
                      primaryColor,
                      imageEditorController,
                      editorKey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
