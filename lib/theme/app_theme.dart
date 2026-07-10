import 'package:flutter/material.dart';
import 'package:flutter_app/extension/db_prefs_extension.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/theme/app_colors.dart';
import 'package:flutter_app/theme/app_radius.dart';
import 'package:flutter_app/theme/app_spacing.dart';
import 'package:flutter_app/theme/app_text_style.dart';
import 'package:flutter_app/theme/custom_theme_colors.dart';
import 'package:flutter_app/widgets/buttons/app_bar_back_button.dart';

/// 主题系统定义
///
/// 统一管理所有设计，包含颜色、文字、间距、圆角和阴影
@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final AppColors colors;
  final AppTextStyle textStyle;
  final AppSpacing spacing;
  final AppRadius radius;

  const AppTheme({
    required this.colors,
    required this.textStyle,
    required this.spacing,
    required this.radius,
  });

  /// 创建浅色主题
  factory AppTheme.light({CustomThemeColors? customColors}) {
    final baseColors = AppColors.light();
    final colors = _applyCustomColors(baseColors, customColors);

    return AppTheme(
      colors: colors,
      textStyle: AppTextStyle.light(colors.onBackground),
      spacing: AppSpacing.base(),
      radius: AppRadius.base(),
    );
  }

  /// 创建深色主题
  factory AppTheme.dark({CustomThemeColors? customColors}) {
    final baseColors = AppColors.dark();
    final colors = _applyCustomColors(baseColors, customColors);

    return AppTheme(
      colors: colors,
      textStyle: AppTextStyle.dark(colors.onBackground),
      spacing: AppSpacing.base(),
      radius: AppRadius.base(),
    );
  }

  /// 复制并修改部分主题属性
  @override
  AppTheme copyWith({
    AppColors? colors,
    AppTextStyle? textStyle,
    AppSpacing? spacing,
    AppRadius? radius,
  }) {
    return AppTheme(
      colors: colors ?? this.colors,
      textStyle: textStyle ?? this.textStyle,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
    );
  }

  /// 在两个主题之间进行插值
  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    return AppTheme(
      colors: colors.lerp(other.colors, t),
      textStyle: textStyle.lerp(other.textStyle, t),
      spacing: spacing.lerp(other.spacing, t),
      radius: radius.lerp(other.radius, t),
    );
  }

  // ------- 以下是静态属性和方法
  static ThemeData? _lightThemeData;
  static ThemeData? _darkThemeData;

  /// 清除主题缓存(用于自定义主题更新时)
  static void clearThemeCache() {
    _lightThemeData = null;
    _darkThemeData = null;
  }

  /// 应用自定义颜色到基础主题
  static AppColors _applyCustomColors(AppColors baseColors, CustomThemeColors? customColors) {
    if (customColors == null) return baseColors;

    return baseColors.copyWith(
      primary: customColors.primary != null ? Color(customColors.primary!) : null,
      onPrimary: customColors.onPrimary != null ? Color(customColors.onPrimary!) : null,
      primaryContainer: customColors.primaryContainer != null ? Color(customColors.primaryContainer!) : null,
      onPrimaryContainer: customColors.onPrimaryContainer != null ? Color(customColors.onPrimaryContainer!) : null,
      secondary: customColors.secondary != null ? Color(customColors.secondary!) : null,
      onSecondary: customColors.onSecondary != null ? Color(customColors.onSecondary!) : null,
      secondaryContainer: customColors.secondaryContainer != null ? Color(customColors.secondaryContainer!) : null,
      onSecondaryContainer: customColors.onSecondaryContainer != null ? Color(customColors.onSecondaryContainer!) : null,
      tertiary: customColors.tertiary != null ? Color(customColors.tertiary!) : null,
      onTertiary: customColors.onTertiary != null ? Color(customColors.onTertiary!) : null,
      tertiaryContainer: customColors.tertiaryContainer != null ? Color(customColors.tertiaryContainer!) : null,
      onTertiaryContainer: customColors.onTertiaryContainer != null ? Color(customColors.onTertiaryContainer!) : null,
      error: customColors.error != null ? Color(customColors.error!) : null,
      onError: customColors.onError != null ? Color(customColors.onError!) : null,
      errorContainer: customColors.errorContainer != null ? Color(customColors.errorContainer!) : null,
      onErrorContainer: customColors.onErrorContainer != null ? Color(customColors.onErrorContainer!) : null,
      background: customColors.background != null ? Color(customColors.background!) : null,
      onBackground: customColors.onBackground != null ? Color(customColors.onBackground!) : null,
      surface: customColors.surface != null ? Color(customColors.surface!) : null,
      onSurface: customColors.onSurface != null ? Color(customColors.onSurface!) : null,
      surfaceVariant: customColors.surfaceVariant != null ? Color(customColors.surfaceVariant!) : null,
      onSurfaceVariant: customColors.onSurfaceVariant != null ? Color(customColors.onSurfaceVariant!) : null,
      surfaceContainer: customColors.surfaceContainer != null ? Color(customColors.surfaceContainer!) : null,
      surfaceContainerLow: customColors.surfaceContainerLow != null ? Color(customColors.surfaceContainerLow!) : null,
      surfaceContainerHigh: customColors.surfaceContainerHigh != null ? Color(customColors.surfaceContainerHigh!) : null,
      surfaceContainerHighest: customColors.surfaceContainerHighest != null ? Color(customColors.surfaceContainerHighest!) : null,
      outline: customColors.outline != null ? Color(customColors.outline!) : null,
      outlineVariant: customColors.outlineVariant != null ? Color(customColors.outlineVariant!) : null,
      success: customColors.success != null ? Color(customColors.success!) : null,
      onSuccess: customColors.onSuccess != null ? Color(customColors.onSuccess!) : null,
      warning: customColors.warning != null ? Color(customColors.warning!) : null,
      onWarning: customColors.onWarning != null ? Color(customColors.onWarning!) : null,
      seed: customColors.seed != null ? Color(customColors.seed!) : null,
      shadow: customColors.shadow != null ? Color(customColors.shadow!) : null,
      scrim: customColors.scrim != null ? Color(customColors.scrim!) : null,
      onScrim: customColors.onScrim != null ? Color(customColors.onScrim!) : null,
      inverseSurface: customColors.inverseSurface != null ? Color(customColors.inverseSurface!) : null,
      onInverseSurface: customColors.onInverseSurface != null ? Color(customColors.onInverseSurface!) : null,
      inversePrimary: customColors.inversePrimary != null ? Color(customColors.inversePrimary!) : null,
      surfaceTint: customColors.surfaceTint != null ? Color(customColors.surfaceTint!) : null,
      disabled: customColors.disabled != null ? Color(customColors.disabled!) : null,
      onDisabled: customColors.onDisabled != null ? Color(customColors.onDisabled!) : null,
      link: customColors.link != null ? Color(customColors.link!) : null,
      onLink: customColors.onLink != null ? Color(customColors.onLink!) : null,
    );
  }

  /// 获取完整的主题数据
  static ThemeData getTheme(BuildContext context, bool isDark) {
    final enableCustomTheme = dbManager.getEnableCustomTheme();
    final customColors = isDark ? dbManager.getCustomThemeColorsDark() : dbManager.getCustomThemeColorsLight();

    if (!enableCustomTheme || customColors == null) {
      if (isDark) {
        if (_darkThemeData != null) {
          return _darkThemeData!;
        }
      } else {
        if (_lightThemeData != null) {
          return _lightThemeData!;
        }
      }
    }

    final originalTheme = Theme.of(context);
    final appTheme = isDark ? AppTheme.dark(customColors: enableCustomTheme ? customColors : null) : AppTheme.light(customColors: enableCustomTheme ? customColors : null);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: appTheme.colors.seed,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    final themeData = originalTheme.copyWith(
      brightness: isDark ? Brightness.dark : Brightness.light,
      extensions: [appTheme],
      materialTapTargetSize: MaterialTapTargetSize.padded,
      scaffoldBackgroundColor: appTheme.colors.background,
      // 定义组件被按下时的高亮颜色
      highlightColor: appTheme.colors.primary.withValues(alpha: 0.2),
      // 定义点击时的水波纹效果颜色
      splashColor: appTheme.colors.primary.withValues(alpha: 0.1),
      dividerColor: appTheme.colors.outlineVariant,
      dividerTheme: DividerThemeData(
        color: appTheme.colors.outlineVariant,
        space: 0,
        thickness: appTheme.spacing.strokeThin,
      ),
      disabledColor: appTheme.colors.disabled.withValues(alpha: 0.35),
      shadowColor: appTheme.colors.shadow,
      cardColor: appTheme.colors.surfaceContainer,
      primaryColor: appTheme.colors.primary,
      textTheme: appTheme.textStyle.toTextTheme().apply(
            bodyColor: appTheme.colors.onSurface,
            displayColor: appTheme.colors.onSurface,
          ),

      // useMaterial3: true：可以解决文本选择、全选光标颜色问题。
      colorScheme: colorScheme.copyWith(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: appTheme.colors.primary,
        onPrimary: appTheme.colors.onPrimary,
        secondary: appTheme.colors.secondary,
        onSecondary: appTheme.colors.onSecondary,
        surface: appTheme.colors.surface,
        onSurface: appTheme.colors.onSurface,
        error: appTheme.colors.error,
        onError: appTheme.colors.onError,
      ),

      datePickerTheme: originalTheme.datePickerTheme.copyWith(
        backgroundColor: appTheme.colors.surface,
        headerBackgroundColor: appTheme.colors.primary,
        headerForegroundColor: appTheme.colors.onPrimary,
        dayStyle: appTheme.textStyle.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusLG,
        ),
      ),

      appBarTheme: originalTheme.appBarTheme.copyWith(
        backgroundColor: appTheme.colors.background,
        surfaceTintColor: appTheme.colors.onBackground,
        shadowColor: appTheme.colors.shadow,
        scrolledUnderElevation: 0 /*滚动时的阴影*/,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: appTheme.textStyle.titleLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => const AppBarBackButton(),
      ),

      bottomNavigationBarTheme: originalTheme.bottomNavigationBarTheme.copyWith(
        backgroundColor: appTheme.colors.background,
        elevation: 8,
        selectedItemColor: appTheme.colors.primary,
        unselectedItemColor: appTheme.colors.onBackground,
      ),

      floatingActionButtonTheme: originalTheme.floatingActionButtonTheme.copyWith(
        backgroundColor: appTheme.colors.primary,
        foregroundColor: appTheme.colors.onPrimary,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusFull,
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: appTheme.colors.transparent,
          foregroundColor: appTheme.colors.onBackground,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: appTheme.radius.radiusMD,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: appTheme.colors.primary,
          disabledForegroundColor: appTheme.colors.disabled.withValues(alpha: 0.35),
          disabledBackgroundColor: appTheme.colors.transparent,
          backgroundColor: appTheme.colors.transparent,
          overlayColor: appTheme.colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: appTheme.radius.radiusMD,
          ),
          textStyle: appTheme.textStyle.labelLarge,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: appTheme.colors.primary,
          foregroundColor: appTheme.colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: appTheme.radius.radiusFull,
          ),
          textStyle: appTheme.textStyle.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: appTheme.colors.outline, width: appTheme.spacing.strokeThin),
          foregroundColor: appTheme.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: appTheme.radius.radiusFull,
          ),
          textStyle: appTheme.textStyle.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.colors.primary,
          foregroundColor: appTheme.colors.onPrimary,
          shadowColor: appTheme.colors.shadow,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: appTheme.radius.radiusFull,
          ),
          textStyle: appTheme.textStyle.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),

      segmentedButtonTheme: originalTheme.segmentedButtonTheme.copyWith(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: appTheme.radius.radiusMD,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return appTheme.colors.primary;
            }

            if (states.contains(WidgetState.disabled)) {
              return appTheme.colors.disabled;
            }
            return appTheme.colors.secondary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return appTheme.colors.onPrimary;
            }

            if (states.contains(WidgetState.disabled)) {
              return appTheme.colors.onDisabled;
            }
            return appTheme.colors.onSecondary;
          }),
        ),
      ),

      progressIndicatorTheme: originalTheme.progressIndicatorTheme.copyWith(
        color: appTheme.colors.primary,
        linearTrackColor: appTheme.colors.primaryContainer,
        circularTrackColor: appTheme.colors.primaryContainer,
      ),

      // 输入框主题色
      inputDecorationTheme: originalTheme.inputDecorationTheme.copyWith(
        filled: true,
        isDense: true,
        fillColor: appTheme.colors.transparent,
        suffixIconColor: appTheme.colors.onSurface,
        contentPadding: appTheme.spacing.paddingMD,
        constraints: const BoxConstraints(),
        border: OutlineInputBorder(
          borderRadius: appTheme.radius.radiusFull,
          borderSide: BorderSide(color: appTheme.colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: appTheme.radius.radiusFull,
          borderSide: BorderSide(color: appTheme.colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: appTheme.radius.radiusFull,
          borderSide: BorderSide(color: appTheme.colors.primary, width: appTheme.spacing.strokeMedium),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: appTheme.radius.radiusFull,
          borderSide: BorderSide(color: appTheme.colors.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: appTheme.radius.radiusFull,
          borderSide: BorderSide(color: appTheme.colors.disabled),
        ),
        hintStyle: appTheme.textStyle.bodyMedium.copyWith(
          color: appTheme.colors.onSurfaceVariant,
        ),
        helperStyle: appTheme.textStyle.bodySmall.copyWith(
          color: appTheme.colors.onSurfaceVariant,
        ),
        labelStyle: appTheme.textStyle.bodyMedium,
        errorStyle: appTheme.textStyle.bodySmall.copyWith(
          color: appTheme.colors.error,
        ),
        floatingLabelStyle: appTheme.textStyle.bodyMedium,
      ),

      // 文本被选中时的颜色、光标颜色。
      textSelectionTheme: originalTheme.textSelectionTheme.copyWith(
        cursorColor: appTheme.colors.primary,
        selectionColor: appTheme.colors.primary.withValues(alpha: 0.35),
        selectionHandleColor: appTheme.colors.primary,
      ),

      dropdownMenuTheme: originalTheme.dropdownMenuTheme.copyWith(
        textStyle: appTheme.textStyle.bodyMedium,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          isDense: true,
          fillColor: appTheme.colors.transparent,
          contentPadding: appTheme.spacing.paddingMD,
          constraints: const BoxConstraints(),
          border: OutlineInputBorder(
            borderRadius: appTheme.radius.radiusMD,
            borderSide: BorderSide(color: appTheme.colors.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: appTheme.radius.radiusMD,
            borderSide: BorderSide(color: appTheme.colors.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: appTheme.radius.radiusMD,
            borderSide: BorderSide(color: appTheme.colors.primary, width: appTheme.spacing.strokeMedium),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(appTheme.colors.surface),
          surfaceTintColor: WidgetStateProperty.all(appTheme.colors.transparent),
          shadowColor: WidgetStateProperty.all(appTheme.colors.shadow),
          elevation: WidgetStateProperty.all(3),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: appTheme.radius.radiusMD,
            ),
          ),
        ),
      ),

      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(appTheme.colors.surface),
          surfaceTintColor: WidgetStateProperty.all(appTheme.colors.transparent),
          shadowColor: WidgetStateProperty.all(appTheme.colors.shadow),
          elevation: WidgetStateProperty.all(3),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: appTheme.radius.radiusMD,
            ),
          ),
          padding: WidgetStateProperty.all(appTheme.spacing.paddingMD),
        ),
      ),

      popupMenuTheme: originalTheme.popupMenuTheme.copyWith(
        color: appTheme.colors.surface,
        surfaceTintColor: appTheme.colors.surface,
        shadowColor: appTheme.colors.shadow,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusMD,
        ),
        textStyle: appTheme.textStyle.bodyMedium,
        labelTextStyle: WidgetStateProperty.all(appTheme.textStyle.bodyMedium),
      ),

      listTileTheme: originalTheme.listTileTheme.copyWith(
        tileColor: appTheme.colors.transparent,
        selectedTileColor: appTheme.colors.primaryContainer,
        textColor: appTheme.colors.onSurface,
        selectedColor: appTheme.colors.onPrimaryContainer,
        iconColor: appTheme.colors.onSurfaceVariant,
        contentPadding: appTheme.spacing.paddingMD,
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusMD,
        ),
      ),

      iconTheme: originalTheme.iconTheme.copyWith(
        size: 24,
        color: appTheme.colors.onBackground,
      ),

      checkboxTheme: originalTheme.checkboxTheme.copyWith(
        fillColor: WidgetStateProperty.all(appTheme.colors.primary),
        checkColor: WidgetStateProperty.all(appTheme.colors.onPrimary),
        shape: const CircleBorder(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        side: BorderSide(
          color: appTheme.colors.outline,
          width: appTheme.spacing.strokeMedium,
        ),
      ),

      radioTheme: originalTheme.radioTheme.copyWith(
        fillColor: WidgetStateProperty.all(appTheme.colors.primary),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),

      switchTheme: originalTheme.switchTheme.copyWith(
        thumbColor: WidgetStateProperty.all(appTheme.colors.onPrimary) /*圆圈颜色*/,
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appTheme.colors.primary;
          }

          if (states.contains(WidgetState.disabled)) {
            return appTheme.colors.disabled;
          }

          return appTheme.colors.surfaceContainerHighest;
        }) /*轨道颜色*/,
        trackOutlineColor: WidgetStateProperty.all(appTheme.colors.transparent),
        trackOutlineWidth: WidgetStateProperty.all(null),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: WidgetStateProperty.all(appTheme.colors.transparent) /*长按圆圈涂起的颜色*/,
        splashRadius: 0,
        thumbIcon: WidgetStateProperty.resolveWith(
          (states) {
            return Icon(
              states.contains(WidgetState.selected) ? Icons.check : Icons.close,
              color: appTheme.colors.primary,
              size: 14,
            );
          },
        ) /*圆圈上的icon*/,
      ),

      cardTheme: CardThemeData(
        color: appTheme.colors.surfaceContainer,
        elevation: 0,
        shadowColor: appTheme.colors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusLG,
        ),
        margin: EdgeInsets.zero,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: appTheme.colors.surfaceContainerLow,
        brightness: isDark ? Brightness.dark : Brightness.light,
        labelStyle: appTheme.textStyle.labelMedium,
        padding: appTheme.spacing.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusFull,
        ),
        secondaryLabelStyle: appTheme.textStyle.labelMedium.copyWith(
          color: appTheme.colors.onSecondaryContainer,
        ),
        selectedColor: appTheme.colors.primaryContainer,
        checkmarkColor: appTheme.colors.onPrimaryContainer,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: appTheme.colors.inverseSurface,
        contentTextStyle: appTheme.textStyle.bodyMedium.copyWith(
          color: appTheme.colors.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusMD,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 6,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appTheme.colors.surface,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(appTheme.radius.lg),
          ),
        ),
        modalBackgroundColor: appTheme.colors.surface,
        modalBarrierColor: appTheme.colors.scrim,
        shadowColor: appTheme.colors.shadow,
        modalElevation: 6,
      ),

      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusMD,
        ),
        backgroundColor: appTheme.colors.surface,
        barrierColor: appTheme.colors.scrim,
        shadowColor: appTheme.colors.shadow,
        elevation: 6,
      ),

      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: appTheme.colors.transparent,
        collapsedBackgroundColor: appTheme.colors.transparent,
        shape: const Border(),
        collapsedShape: const Border(),
        textColor: appTheme.colors.onSurface,
        collapsedTextColor: appTheme.colors.onSurface,
        iconColor: appTheme.colors.onSurfaceVariant,
        collapsedIconColor: appTheme.colors.onSurfaceVariant,
      ),

      badgeTheme: BadgeThemeData(
        backgroundColor: appTheme.colors.error,
        textColor: appTheme.colors.onError,
        smallSize: 8,
        largeSize: 16,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        alignment: AlignmentDirectional.topEnd,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: appTheme.colors.inverseSurface,
          borderRadius: appTheme.radius.radiusSM,
        ),
        textStyle: appTheme.textStyle.bodySmall.copyWith(
          color: appTheme.colors.onInverseSurface,
        ),
        padding: appTheme.spacing.symmetric(horizontal: 16, vertical: 8),
        margin: appTheme.spacing.marginXS,
      ),

      bottomAppBarTheme: BottomAppBarThemeData(
        color: appTheme.colors.surface,
        elevation: 3,
        shadowColor: appTheme.colors.shadow,
        surfaceTintColor: appTheme.colors.surfaceTint,
        height: 80,
        padding: appTheme.spacing.paddingMD,
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: appTheme.colors.surface,
        elevation: 3,
        shadowColor: appTheme.colors.shadow,
        surfaceTintColor: appTheme.colors.surfaceTint,
        indicatorColor: appTheme.colors.secondaryContainer,
        labelTextStyle: WidgetStateProperty.all(appTheme.textStyle.labelSmall),
        iconTheme: WidgetStateProperty.all(
          IconThemeData(
            color: appTheme.colors.onSurface,
            size: 24,
          ),
        ),
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: appTheme.colors.surface,
        elevation: 3,
        indicatorColor: appTheme.colors.secondaryContainer,
        selectedLabelTextStyle: appTheme.textStyle.labelSmall,
        unselectedLabelTextStyle: appTheme.textStyle.labelSmall,
        selectedIconTheme: IconThemeData(
          color: appTheme.colors.onSurface,
          size: 24,
        ),
        unselectedIconTheme: IconThemeData(
          color: appTheme.colors.onSurfaceVariant,
          size: 24,
        ),
        minWidth: 80,
        useIndicator: true,
        labelType: NavigationRailLabelType.all,
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: appTheme.colors.surface,
        elevation: 16,
        shadowColor: appTheme.colors.shadow,
        surfaceTintColor: appTheme.colors.surfaceTint,
        shape: const RoundedRectangleBorder(),
        width: 304,
      ),

      sliderTheme: SliderThemeData(
        activeTrackColor: appTheme.colors.primary,
        inactiveTrackColor: appTheme.colors.primary.withValues(alpha: 0.24),
        thumbColor: appTheme.colors.primary,
        overlayColor: appTheme.colors.primary.withValues(alpha: 0.12),
        valueIndicatorColor: appTheme.colors.primary,
        valueIndicatorTextStyle: appTheme.textStyle.labelMedium.copyWith(
          color: appTheme.colors.onPrimary,
        ),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        rangeTickMarkShape: const RoundRangeSliderTickMarkShape(),
        tickMarkShape: const RoundSliderTickMarkShape(),
      ),

      timePickerTheme: TimePickerThemeData(
        backgroundColor: appTheme.colors.surface,
        hourMinuteColor: appTheme.colors.onSurface,
        hourMinuteTextColor: appTheme.colors.primary,
        dialHandColor: appTheme.colors.primary,
        dialTextColor: appTheme.colors.onSurface,
        entryModeIconColor: appTheme.colors.primary,
        cancelButtonStyle: TextButton.styleFrom(
          foregroundColor: appTheme.colors.onSurface,
        ),
        confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: appTheme.colors.primary,
        ),
        dayPeriodBorderSide: BorderSide(
          color: appTheme.colors.outline,
        ),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: appTheme.radius.radiusSM,
        ),
        dayPeriodTextStyle: appTheme.textStyle.labelLarge,
        dialTextStyle: appTheme.textStyle.displayMedium,
        helpTextStyle: appTheme.textStyle.labelLarge,
        hourMinuteTextStyle: appTheme.textStyle.displayMedium,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: appTheme.radius.radiusSM,
            borderSide: BorderSide(color: appTheme.colors.outline),
          ),
          contentPadding: appTheme.spacing.paddingMD,
        ),
        padding: appTheme.spacing.paddingXL,
      ),
    );

    if (isDark) {
      _darkThemeData = themeData;
    } else {
      _lightThemeData = themeData;
    }

    return themeData;
  }
}
