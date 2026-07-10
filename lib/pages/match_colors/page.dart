import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/extension/color.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/providers/custom_theme_state.dart';
import 'package:flutter_app/providers/theme_mode_state.dart';
import 'package:flutter_app/theme/app_colors.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/theme/custom_theme_colors.dart';
import 'package:flutter_app/widgets/card_container.dart';
import 'package:flutter_app/widgets/dialog/color_picker_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'widget.dart';

@RoutePage()
class MatchColorsPage extends HookConsumerWidget {
  const MatchColorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () {
        log.d('$this dispose');
      };
    }, []);

    final customThemeState = ref.watch(customThemeStateProvider);
    final customThemeNotifier = ref.watch(customThemeStateProvider.notifier);
    final themeModeNotifier = ref.watch(themeModeStateProvider.notifier);
    final isDark = themeModeNotifier.isDark(context);

    final currentColorsRef = useRef(isDark ? customThemeState.darkColors : customThemeState.lightColors);
    final defaultColorsRef = useRef(isDark ? AppColors.dark() : AppColors.light());

    final colorSchemeRef = useRef([
      AppColors.tech(),
      AppColors.terminal(),
      AppColors.cartoon(),
      AppColors.sakura(),
      AppColors.ocean(),
      AppColors.springBreeze(),
    ]);

    useEffect(() {
      currentColorsRef.value = isDark ? customThemeState.darkColors : customThemeState.lightColors;

      return null;
    }, [customThemeState]);

    return Scaffold(
      appBar: AppBar(
        title: Text('主题配色'.tr()),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            _buildHeader(
              context,
              ref,
              isDark: isDark,
              customThemeState: customThemeState,
              customThemeNotifier: customThemeNotifier,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardContainer(
                      child: Column(
                        children: [
                          // 预设配色
                          Row(
                            children: [
                              Icon(
                                Icons.palette_rounded,
                                size: 18,
                                color: context.colors.primary,
                              ),
                              SizedBox(width: context.spacing.xs),
                              Text(
                                '预设配色'.tr(),
                                style: context.textStyle.titleSmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: context.spacing.xs),
                          Container(
                            padding: EdgeInsets.all(context.spacing.sm),
                            decoration: BoxDecoration(
                              color: context.colors.surfaceContainer,
                              borderRadius: context.radius.radiusMD,
                            ),
                            child: MasonryGridView.count(
                              crossAxisCount: 6,
                              padding: EdgeInsets.zero,
                              mainAxisSpacing: context.spacing.sm,
                              crossAxisSpacing: context.spacing.sm,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: colorSchemeRef.value.length,
                              itemBuilder: (context, index) {
                                final colors = colorSchemeRef.value[index];

                                String title = '';
                                switch (index) {
                                  case 0:
                                    title = '科技'.tr();
                                    break;
                                  case 1:
                                    title = '黑客'.tr();
                                    break;
                                  case 2:
                                    title = '卡通'.tr();
                                    break;
                                  case 3:
                                    title = '樱花'.tr();
                                    break;
                                  case 4:
                                    title = '海洋'.tr();
                                    break;
                                  case 5:
                                    title = '春风'.tr();
                                    break;
                                }

                                return InkWell(
                                  onTap: () async {
                                    // 将选中的预设配色应用到当前主题
                                    final customColors = CustomThemeColors.convertToCustomThemeColors(colors);

                                    // 根据当前模式设置颜色
                                    if (isDark) {
                                      await customThemeNotifier.setDarkColors(customColors);
                                    } else {
                                      await customThemeNotifier.setLightColors(customColors);
                                    }
                                  },
                                  borderRadius: context.radius.radiusSM,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: colors.primary,
                                          borderRadius: context.radius.radiusMD,
                                        ),
                                      ),
                                      SizedBox(height: context.spacing.xs),
                                      Text(title, style: context.textStyle.labelSmall),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '种子颜色'.tr(),
                      Icons.palette_rounded,
                      [
                        _ColorItem('种子色'.tr(), 'seed', currentColorsRef.value?.seed, defaultColorsRef.value.seed.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '主要颜色'.tr(),
                      Icons.star_rounded,
                      [
                        _ColorItem('主色'.tr(), 'primary', currentColorsRef.value?.primary, defaultColorsRef.value.primary.colorToInt()),
                        _ColorItem('主色文字'.tr(), 'onPrimary', currentColorsRef.value?.onPrimary, defaultColorsRef.value.onPrimary.colorToInt()),
                        _ColorItem('主容器'.tr(), 'primaryContainer', currentColorsRef.value?.primaryContainer, defaultColorsRef.value.primaryContainer.colorToInt()),
                        _ColorItem('主容器文字'.tr(), 'onPrimaryContainer', currentColorsRef.value?.onPrimaryContainer, defaultColorsRef.value.onPrimaryContainer.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '次要颜色'.tr(),
                      Icons.bookmark_rounded,
                      [
                        _ColorItem('次要色'.tr(), 'secondary', currentColorsRef.value?.secondary, defaultColorsRef.value.secondary.colorToInt()),
                        _ColorItem('次要色文字'.tr(), 'onSecondary', currentColorsRef.value?.onSecondary, defaultColorsRef.value.onSecondary.colorToInt()),
                        _ColorItem('次要容器'.tr(), 'secondaryContainer', currentColorsRef.value?.secondaryContainer, defaultColorsRef.value.secondaryContainer.colorToInt()),
                        _ColorItem('次要容器文字'.tr(), 'onSecondaryContainer', currentColorsRef.value?.onSecondaryContainer, defaultColorsRef.value.onSecondaryContainer.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '第三颜色'.tr(),
                      Icons.label_rounded,
                      [
                        _ColorItem('第三色'.tr(), 'tertiary', currentColorsRef.value?.tertiary, defaultColorsRef.value.tertiary.colorToInt()),
                        _ColorItem('第三色文字'.tr(), 'onTertiary', currentColorsRef.value?.onTertiary, defaultColorsRef.value.onTertiary.colorToInt()),
                        _ColorItem('第三容器'.tr(), 'tertiaryContainer', currentColorsRef.value?.tertiaryContainer, defaultColorsRef.value.tertiaryContainer.colorToInt()),
                        _ColorItem('第三容器文字'.tr(), 'onTertiaryContainer', currentColorsRef.value?.onTertiaryContainer, defaultColorsRef.value.onTertiaryContainer.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '背景与表面'.tr(),
                      Icons.layers_rounded,
                      [
                        _ColorItem('背景色'.tr(), 'background', currentColorsRef.value?.background, defaultColorsRef.value.background.colorToInt()),
                        _ColorItem('背景文字'.tr(), 'onBackground', currentColorsRef.value?.onBackground, defaultColorsRef.value.onBackground.colorToInt()),
                        _ColorItem('表面色'.tr(), 'surface', currentColorsRef.value?.surface, defaultColorsRef.value.surface.colorToInt()),
                        _ColorItem('表面文字'.tr(), 'onSurface', currentColorsRef.value?.onSurface, defaultColorsRef.value.onSurface.colorToInt()),
                        _ColorItem('表面变体'.tr(), 'surfaceVariant', currentColorsRef.value?.surfaceVariant, defaultColorsRef.value.surfaceVariant.colorToInt()),
                        _ColorItem('表面变体文字'.tr(), 'onSurfaceVariant', currentColorsRef.value?.onSurfaceVariant, defaultColorsRef.value.onSurfaceVariant.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '状态颜色'.tr(),
                      Icons.info_rounded,
                      [
                        _ColorItem('错误色'.tr(), 'error', currentColorsRef.value?.error, defaultColorsRef.value.error.colorToInt()),
                        _ColorItem('错误色文字'.tr(), 'onError', currentColorsRef.value?.onError, defaultColorsRef.value.onError.colorToInt()),
                        _ColorItem('错误容器'.tr(), 'errorContainer', currentColorsRef.value?.errorContainer, defaultColorsRef.value.errorContainer.colorToInt()),
                        _ColorItem('错误容器文字'.tr(), 'onErrorContainer', currentColorsRef.value?.onErrorContainer, defaultColorsRef.value.onErrorContainer.colorToInt()),
                        _ColorItem('成功色'.tr(), 'success', currentColorsRef.value?.success, defaultColorsRef.value.success.colorToInt()),
                        _ColorItem('成功色文字'.tr(), 'onSuccess', currentColorsRef.value?.onSuccess, defaultColorsRef.value.onSuccess.colorToInt()),
                        _ColorItem('警告色'.tr(), 'warning', currentColorsRef.value?.warning, defaultColorsRef.value.warning.colorToInt()),
                        _ColorItem('警告色文字'.tr(), 'onWarning', currentColorsRef.value?.onWarning, defaultColorsRef.value.onWarning.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '表面容器'.tr(),
                      Icons.view_compact_rounded,
                      [
                        _ColorItem('表面容器'.tr(), 'surfaceContainer', currentColorsRef.value?.surfaceContainer, defaultColorsRef.value.surfaceContainer.colorToInt()),
                        _ColorItem('低表面容器'.tr(), 'surfaceContainerLow', currentColorsRef.value?.surfaceContainerLow, defaultColorsRef.value.surfaceContainerLow.colorToInt()),
                        _ColorItem('高表面容器'.tr(), 'surfaceContainerHigh', currentColorsRef.value?.surfaceContainerHigh, defaultColorsRef.value.surfaceContainerHigh.colorToInt()),
                        _ColorItem('最高表面容器'.tr(), 'surfaceContainerHighest', currentColorsRef.value?.surfaceContainerHighest, defaultColorsRef.value.surfaceContainerHighest.colorToInt()),
                        _ColorItem('表面着色'.tr(), 'surfaceTint', currentColorsRef.value?.surfaceTint, defaultColorsRef.value.surfaceTint.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '边框与分割'.tr(),
                      Icons.border_all_rounded,
                      [
                        _ColorItem('边框色'.tr(), 'outline', currentColorsRef.value?.outline, defaultColorsRef.value.outline.colorToInt()),
                        _ColorItem('边框变体'.tr(), 'outlineVariant', currentColorsRef.value?.outlineVariant, defaultColorsRef.value.outlineVariant.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '阴影与遮罩'.tr(),
                      Icons.blur_on_rounded,
                      [
                        _ColorItem('阴影色'.tr(), 'shadow', currentColorsRef.value?.shadow, defaultColorsRef.value.shadow.colorToInt()),
                        _ColorItem('遮罩色'.tr(), 'scrim', currentColorsRef.value?.scrim, defaultColorsRef.value.scrim.colorToInt()),
                        _ColorItem('遮罩文字'.tr(), 'onScrim', currentColorsRef.value?.onScrim, defaultColorsRef.value.onScrim.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '反色主题'.tr(),
                      Icons.invert_colors_rounded,
                      [
                        _ColorItem('反色表面'.tr(), 'inverseSurface', currentColorsRef.value?.inverseSurface, defaultColorsRef.value.inverseSurface.colorToInt()),
                        _ColorItem('反色表面文字'.tr(), 'onInverseSurface', currentColorsRef.value?.onInverseSurface, defaultColorsRef.value.onInverseSurface.colorToInt()),
                        _ColorItem('反色主色'.tr(), 'inversePrimary', currentColorsRef.value?.inversePrimary, defaultColorsRef.value.inversePrimary.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.md),
                    _buildColorSection(
                      context,
                      ref,
                      '其他颜色'.tr(),
                      Icons.more_horiz_rounded,
                      [
                        _ColorItem('禁用色'.tr(), 'disabled', currentColorsRef.value?.disabled, defaultColorsRef.value.disabled.colorToInt()),
                        _ColorItem('禁用文字'.tr(), 'onDisabled', currentColorsRef.value?.onDisabled, defaultColorsRef.value.onDisabled.colorToInt()),
                        _ColorItem('链接色'.tr(), 'link', currentColorsRef.value?.link, defaultColorsRef.value.link.colorToInt()),
                        _ColorItem('链接文字'.tr(), 'onLink', currentColorsRef.value?.onLink, defaultColorsRef.value.onLink.colorToInt()),
                      ],
                      currentColorsRef.value,
                      isDark,
                      customThemeNotifier,
                    ),
                    SizedBox(height: context.spacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorItem {
  final String name;
  final String key;
  final int? currentValue;
  final int defaultValue;

  _ColorItem(this.name, this.key, this.currentValue, this.defaultValue);
}
