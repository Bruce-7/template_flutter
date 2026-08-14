// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:collection/collection.dart' as _i10;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter_app/pages/example/page.dart' as _i1;
import 'package:flutter_app/pages/image_crop/page.dart' as _i2;
import 'package:flutter_app/pages/main/page.dart' as _i3;
import 'package:flutter_app/pages/match_colors/page.dart' as _i4;
import 'package:flutter_app/pages/not_found/page.dart' as _i5;
import 'package:flutter_app/pages/preview_image/page.dart' as _i6;
import 'package:flutter_app/pages/template/page.dart' as _i7;

/// generated route for
/// [_i1.ExamplePage]
class ExampleRoute extends _i8.PageRouteInfo<void> {
  const ExampleRoute({List<_i8.PageRouteInfo>? children})
    : super(ExampleRoute.name, initialChildren: children);

  static const String name = 'ExampleRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.ExamplePage();
    },
  );
}

/// generated route for
/// [_i2.ImageCropPage]
class ImageCropRoute extends _i8.PageRouteInfo<ImageCropRouteArgs> {
  ImageCropRoute({
    _i9.Key? key,
    required String imagePath,
    _i2.ImageCropPageType type = _i2.ImageCropPageType.square,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         ImageCropRoute.name,
         args: ImageCropRouteArgs(key: key, imagePath: imagePath, type: type),
         initialChildren: children,
       );

  static const String name = 'ImageCropRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageCropRouteArgs>();
      return _i2.ImageCropPage(
        key: args.key,
        imagePath: args.imagePath,
        type: args.type,
      );
    },
  );
}

class ImageCropRouteArgs {
  const ImageCropRouteArgs({
    this.key,
    required this.imagePath,
    this.type = _i2.ImageCropPageType.square,
  });

  final _i9.Key? key;

  final String imagePath;

  final _i2.ImageCropPageType type;

  @override
  String toString() {
    return 'ImageCropRouteArgs{key: $key, imagePath: $imagePath, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ImageCropRouteArgs) return false;
    return key == other.key &&
        imagePath == other.imagePath &&
        type == other.type;
  }

  @override
  int get hashCode => key.hashCode ^ imagePath.hashCode ^ type.hashCode;
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainPage();
    },
  );
}

/// generated route for
/// [_i4.MatchColorsPage]
class MatchColorsRoute extends _i8.PageRouteInfo<void> {
  const MatchColorsRoute({List<_i8.PageRouteInfo>? children})
    : super(MatchColorsRoute.name, initialChildren: children);

  static const String name = 'MatchColorsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.MatchColorsPage();
    },
  );
}

/// generated route for
/// [_i5.NotFoundPage]
class NotFoundRoute extends _i8.PageRouteInfo<void> {
  const NotFoundRoute({List<_i8.PageRouteInfo>? children})
    : super(NotFoundRoute.name, initialChildren: children);

  static const String name = 'NotFoundRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.NotFoundPage();
    },
  );
}

/// generated route for
/// [_i6.PreviewImagePage]
class PreviewImageRoute extends _i8.PageRouteInfo<PreviewImageRouteArgs> {
  PreviewImageRoute({
    _i9.Key? key,
    required List<_i6.PreviewImageSource> imageSources,
    int? initialIndex,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         PreviewImageRoute.name,
         args: PreviewImageRouteArgs(
           key: key,
           imageSources: imageSources,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'PreviewImageRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviewImageRouteArgs>();
      return _i6.PreviewImagePage(
        key: args.key,
        imageSources: args.imageSources,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class PreviewImageRouteArgs {
  const PreviewImageRouteArgs({
    this.key,
    required this.imageSources,
    this.initialIndex,
  });

  final _i9.Key? key;

  final List<_i6.PreviewImageSource> imageSources;

  final int? initialIndex;

  @override
  String toString() {
    return 'PreviewImageRouteArgs{key: $key, imageSources: $imageSources, initialIndex: $initialIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PreviewImageRouteArgs) return false;
    return key == other.key &&
        const _i10.ListEquality<_i6.PreviewImageSource>().equals(
          imageSources,
          other.imageSources,
        ) &&
        initialIndex == other.initialIndex;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i10.ListEquality<_i6.PreviewImageSource>().hash(imageSources) ^
      initialIndex.hashCode;
}

/// generated route for
/// [_i7.TemplatePage]
class TemplateRoute extends _i8.PageRouteInfo<void> {
  const TemplateRoute({List<_i8.PageRouteInfo>? children})
    : super(TemplateRoute.name, initialChildren: children);

  static const String name = 'TemplateRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.TemplatePage();
    },
  );
}
