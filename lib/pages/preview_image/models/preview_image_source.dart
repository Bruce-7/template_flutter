part of '../page.dart';

enum PreviewImageSourceType {
  network,
  memory,
  file,
}

class PreviewImageSource {
  const PreviewImageSource._({
    required this.type,
    this.heroTag,
    this.url,
    this.bytes,
    this.fileData,
  });

  final PreviewImageSourceType type;
  final String? heroTag;
  final String? url;
  final Uint8List? bytes;
  final File? fileData;

  factory PreviewImageSource.network(String url, {String? heroTag}) {
    return PreviewImageSource._(
      type: PreviewImageSourceType.network,
      heroTag: heroTag,
      url: url,
    );
  }

  factory PreviewImageSource.memory(Uint8List bytes, {String? heroTag}) {
    return PreviewImageSource._(
      type: PreviewImageSourceType.memory,
      heroTag: heroTag,
      bytes: bytes,
    );
  }

  factory PreviewImageSource.file(File file, {String? heroTag}) {
    return PreviewImageSource._(
      type: PreviewImageSourceType.file,
      heroTag: heroTag,
      fileData: file,
    );
  }

  T when<T>({
    required T Function(String url) network,
    required T Function(Uint8List bytes) memory,
    required T Function(File file) file,
  }) {
    switch (type) {
      case PreviewImageSourceType.network:
        final value = url;
        if (value == null) {
          throw StateError('网络图片数据缺失'.tr());
        }
        return network(value);

      case PreviewImageSourceType.memory:
        final value = bytes;
        if (value == null) {
          throw StateError('内存图片数据缺失'.tr());
        }
        return memory(value);
        
      case PreviewImageSourceType.file:
        final value = fileData;
        if (value == null) {
          throw StateError('文件图片数据缺失'.tr());
        }
        return file(value);
    }
  }
}
