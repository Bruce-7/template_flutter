part of 'page.dart';

extension PreviewImagePageFunction on PreviewImagePage {
  List<PreviewImageSource> _resolveSources() {
    if (imageSources.isNotEmpty) {
      return List<PreviewImageSource>.unmodifiable(imageSources);
    }

    return const <PreviewImageSource>[];
  }

  GestureConfig _initGestureConfigHandler(ExtendedImageState state) {
    return GestureConfig(
      inPageView: true,
    );
  }
}
