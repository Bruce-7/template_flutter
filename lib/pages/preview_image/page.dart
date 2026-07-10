import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_app/widgets/common.dart';
import 'package:flutter_app/widgets/empty_placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'models/preview_image_source.dart';

part 'widget.dart';

@RoutePage()
class PreviewImagePage extends HookConsumerWidget {
  final List<PreviewImageSource> imageSources;
  final int? initialIndex;

  const PreviewImagePage({super.key, required this.imageSources, this.initialIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () {
        log.d('$this dispose');
      };
    }, []);

    final currentIndexState = useState(initialIndex ?? 0);
    final controller = useMemoized(() => ExtendedPageController(initialPage: currentIndexState.value));
    final darkThemeData = AppTheme.getTheme(context, true);

    return Theme(
      data: darkThemeData,
      child: Builder(
        builder: (context) {
          final sources = _resolveSources();

          if (sources.isEmpty) {
            return const EmptyPlaceholder();
          }

          return Scaffold(
            backgroundColor: context.colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                ExtendedImageSlidePage(
                  child: ExtendedImageGesturePageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sources.length,
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) {
                      currentIndexState.value = index;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final item = sources[index];
                      final heroTag = item.heroTag ?? '${item.type.name}_$index';

                      final image = item.when(
                        network: (url) => ExtendedImage.network(
                          url,
                          cache: true /*是否使用缓存*/,
                          fit: BoxFit.contain,
                          enableSlideOutPage: true,
                          mode: ExtendedImageMode.gesture,
                          initGestureConfigHandler: _initGestureConfigHandler,
                          loadStateChanged: (state) {
                            return extendedImageLoadStateChanged(context: context, state: state);
                          },
                        ),
                        memory: (bytes) => ExtendedImage.memory(
                          bytes,
                          fit: BoxFit.contain,
                          enableSlideOutPage: true,
                          mode: ExtendedImageMode.gesture,
                          initGestureConfigHandler: _initGestureConfigHandler,
                          loadStateChanged: (state) {
                            return extendedImageLoadStateChanged(context: context, state: state);
                          },
                        ),
                        file: (file) => ExtendedImage.file(
                          file,
                          fit: BoxFit.contain,
                          enableSlideOutPage: true,
                          mode: ExtendedImageMode.gesture,
                          initGestureConfigHandler: _initGestureConfigHandler,
                          loadStateChanged: (state) {
                            return extendedImageLoadStateChanged(context: context, state: state);
                          },
                        ),
                      );

                      if (index == currentIndexState.value) {
                        return Hero(
                          tag: heroTag,
                          child: image,
                        );
                      }

                      return image;
                    },
                  ),
                ),

                // 关闭按钮
                Positioned(
                  top: CommonUtil.topViewPadding(context),
                  right: 12,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          // 索引指示器
                          if (sources.length > 1)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${currentIndexState.value + 1}/${sources.length}',
                                style: context.textStyle.titleMedium,
                              ),
                            ),
                          const Icon(Icons.close),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
