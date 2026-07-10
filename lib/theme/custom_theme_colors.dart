import 'package:flutter_app/extension/color.dart';
import 'package:flutter_app/theme/app_colors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_theme_colors.g.dart';

@JsonSerializable()
class CustomThemeColors {
  final int? primary;
  final int? onPrimary;
  final int? primaryContainer;
  final int? onPrimaryContainer;
  final int? secondary;
  final int? onSecondary;
  final int? secondaryContainer;
  final int? onSecondaryContainer;
  final int? tertiary;
  final int? onTertiary;
  final int? tertiaryContainer;
  final int? onTertiaryContainer;
  final int? error;
  final int? onError;
  final int? errorContainer;
  final int? onErrorContainer;
  final int? background;
  final int? onBackground;
  final int? surface;
  final int? onSurface;
  final int? surfaceVariant;
  final int? onSurfaceVariant;
  final int? surfaceContainer;
  final int? surfaceContainerLow;
  final int? surfaceContainerHigh;
  final int? surfaceContainerHighest;
  final int? outline;
  final int? outlineVariant;
  final int? success;
  final int? onSuccess;
  final int? warning;
  final int? onWarning;
  final int? seed;
  final int? shadow;
  final int? scrim;
  final int? onScrim;
  final int? inverseSurface;
  final int? onInverseSurface;
  final int? inversePrimary;
  final int? surfaceTint;
  final int? disabled;
  final int? onDisabled;
  final int? link;
  final int? onLink;

  const CustomThemeColors({
    this.primary,
    this.onPrimary,
    this.primaryContainer,
    this.onPrimaryContainer,
    this.secondary,
    this.onSecondary,
    this.secondaryContainer,
    this.onSecondaryContainer,
    this.tertiary,
    this.onTertiary,
    this.tertiaryContainer,
    this.onTertiaryContainer,
    this.error,
    this.onError,
    this.errorContainer,
    this.onErrorContainer,
    this.background,
    this.onBackground,
    this.surface,
    this.onSurface,
    this.surfaceVariant,
    this.onSurfaceVariant,
    this.surfaceContainer,
    this.surfaceContainerLow,
    this.surfaceContainerHigh,
    this.surfaceContainerHighest,
    this.outline,
    this.outlineVariant,
    this.success,
    this.onSuccess,
    this.warning,
    this.onWarning,
    this.seed,
    this.shadow,
    this.scrim,
    this.onScrim,
    this.inverseSurface,
    this.onInverseSurface,
    this.inversePrimary,
    this.surfaceTint,
    this.disabled,
    this.onDisabled,
    this.link,
    this.onLink,
  });

  factory CustomThemeColors.fromJson(Map<String, dynamic> json) => _$CustomThemeColorsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomThemeColorsToJson(this);

  CustomThemeColors copyWith({
    int? primary,
    int? onPrimary,
    int? primaryContainer,
    int? onPrimaryContainer,
    int? secondary,
    int? onSecondary,
    int? secondaryContainer,
    int? onSecondaryContainer,
    int? tertiary,
    int? onTertiary,
    int? tertiaryContainer,
    int? onTertiaryContainer,
    int? error,
    int? onError,
    int? errorContainer,
    int? onErrorContainer,
    int? background,
    int? onBackground,
    int? surface,
    int? onSurface,
    int? surfaceVariant,
    int? onSurfaceVariant,
    int? surfaceContainer,
    int? surfaceContainerLow,
    int? surfaceContainerHigh,
    int? surfaceContainerHighest,
    int? outline,
    int? outlineVariant,
    int? success,
    int? onSuccess,
    int? warning,
    int? onWarning,
    int? seed,
    int? shadow,
    int? scrim,
    int? onScrim,
    int? inverseSurface,
    int? onInverseSurface,
    int? inversePrimary,
    int? surfaceTint,
    int? disabled,
    int? onDisabled,
    int? link,
    int? onLink,
  }) {
    return CustomThemeColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest ?? this.surfaceContainerHighest,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      seed: seed ?? this.seed,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      onScrim: onScrim ?? this.onScrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      link: link ?? this.link,
      onLink: onLink ?? this.onLink,
    );
  }

  /// 将 AppColors 转换为 CustomThemeColors
  factory CustomThemeColors.convertToCustomThemeColors(AppColors appColors) {
    return CustomThemeColors(
      seed: appColors.seed.colorToInt(),
      primary: appColors.primary.colorToInt(),
      onPrimary: appColors.onPrimary.colorToInt(),
      primaryContainer: appColors.primaryContainer.colorToInt(),
      onPrimaryContainer: appColors.onPrimaryContainer.colorToInt(),
      secondary: appColors.secondary.colorToInt(),
      onSecondary: appColors.onSecondary.colorToInt(),
      secondaryContainer: appColors.secondaryContainer.colorToInt(),
      onSecondaryContainer: appColors.onSecondaryContainer.colorToInt(),
      tertiary: appColors.tertiary.colorToInt(),
      onTertiary: appColors.onTertiary.colorToInt(),
      tertiaryContainer: appColors.tertiaryContainer.colorToInt(),
      onTertiaryContainer: appColors.onTertiaryContainer.colorToInt(),
      error: appColors.error.colorToInt(),
      onError: appColors.onError.colorToInt(),
      errorContainer: appColors.errorContainer.colorToInt(),
      onErrorContainer: appColors.onErrorContainer.colorToInt(),
      background: appColors.background.colorToInt(),
      onBackground: appColors.onBackground.colorToInt(),
      surface: appColors.surface.colorToInt(),
      onSurface: appColors.onSurface.colorToInt(),
      surfaceVariant: appColors.surfaceVariant.colorToInt(),
      onSurfaceVariant: appColors.onSurfaceVariant.colorToInt(),
      surfaceContainer: appColors.surfaceContainer.colorToInt(),
      surfaceContainerLow: appColors.surfaceContainerLow.colorToInt(),
      surfaceContainerHigh: appColors.surfaceContainerHigh.colorToInt(),
      surfaceContainerHighest: appColors.surfaceContainerHighest.colorToInt(),
      outline: appColors.outline.colorToInt(),
      outlineVariant: appColors.outlineVariant.colorToInt(),
      success: appColors.success.colorToInt(),
      onSuccess: appColors.onSuccess.colorToInt(),
      warning: appColors.warning.colorToInt(),
      onWarning: appColors.onWarning.colorToInt(),
      shadow: appColors.shadow.colorToInt(),
      scrim: appColors.scrim.colorToInt(),
      onScrim: appColors.onScrim.colorToInt(),
      inverseSurface: appColors.inverseSurface.colorToInt(),
      onInverseSurface: appColors.onInverseSurface.colorToInt(),
      inversePrimary: appColors.inversePrimary.colorToInt(),
      surfaceTint: appColors.surfaceTint.colorToInt(),
      disabled: appColors.disabled.colorToInt(),
      onDisabled: appColors.onDisabled.colorToInt(),
      link: appColors.link.colorToInt(),
      onLink: appColors.onLink.colorToInt(),
    );
  }
}
