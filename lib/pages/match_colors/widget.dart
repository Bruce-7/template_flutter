part of 'page.dart';

extension MatchColorsPageWidget on MatchColorsPage {
  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref, {
    required bool isDark,
    required CustomThemeStateData customThemeState,
    required CustomThemeState customThemeNotifier,
  }) {
    return SliverToBoxAdapter(
      child: CardContainer(
        margin: EdgeInsets.all(context.spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.spacing.sm),
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: context.radius.radiusMD,
                  ),
                  child: Icon(
                    Icons.palette_outlined,
                    color: context.colors.onPrimaryContainer,
                    size: 24,
                  ),
                ),
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '自定义主题'.tr(),
                        style: context.textStyle.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isDark ? '当前编辑: 深色模式'.tr() : '当前编辑: 浅色模式'.tr(),
                        style: context.textStyle.bodySmall.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: customThemeState.enableCustomTheme,
                  onChanged: (value) {
                    customThemeNotifier.setEnableCustomTheme(value);
                  },
                ),
              ],
            ),
            if (customThemeState.enableCustomTheme) ...[
              SizedBox(height: context.spacing.md),
              Divider(color: context.colors.outlineVariant),
              SizedBox(height: context.spacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '已启用自定义配色'.tr(),
                      style: context.textStyle.bodySmall.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (isDark) {
                        customThemeNotifier.resetDarkColors();
                      } else {
                        customThemeNotifier.resetLightColors();
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing.md,
                        vertical: context.spacing.md,
                      ),
                      textStyle: context.textStyle.bodySmall,
                    ),
                    child: Text('恢复默认'.tr()),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection(
    BuildContext context,
    WidgetRef ref,
    String title,
    IconData icon,
    List<_ColorItem> items,
    CustomThemeColors? currentColors,
    bool isDark,
    CustomThemeState customThemeNotifier,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: context.radius.radiusMD,
        border: Border.all(
          color: context.colors.outline,
          width: context.spacing.strokeThin,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.spacing.paddingMD,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: context.colors.primary,
                ),
                SizedBox(width: context.spacing.sm),
                Flexible(
                  child: Text(
                    title,
                    style: context.textStyle.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: context.spacing.strokeThin, color: context.colors.outline),
          ...items.asMap().entries.map((entry) {
            final item = entry.value;
            return Column(
              children: [
                _buildColorItem(context, ref, item, currentColors, isDark, customThemeNotifier),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildColorItem(
    BuildContext context,
    WidgetRef ref,
    _ColorItem item,
    CustomThemeColors? currentColors,
    bool isDark,
    CustomThemeState customThemeNotifier,
  ) {
    final colorValue = item.currentValue ?? item.defaultValue;
    final currentColor = Color(colorValue);
    final isCustomized = item.currentValue != null;

    return InkWell(
      onTap: () async {
        final color = await ColorPickerSheet(
          initialColor: currentColor,
          title: item.name,
        ).show(context);

        if (color != null && context.mounted) {
          _updateColor(context, ref, key: item.key, color: color, currentColors: currentColors, isDark: isDark, customThemeNotifier: customThemeNotifier);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.md,
          vertical: context.spacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: context.radius.radiusMD,
                boxShadow: item.key == 'shadow'
                    ? [
                        BoxShadow(
                          color: currentColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
            ),
            SizedBox(width: context.spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          style: context.textStyle.bodyMedium.copyWith(
                            fontWeight: isCustomized ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (isCustomized) ...[
                        SizedBox(width: context.spacing.xs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.spacing.xs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: context.colors.primaryContainer,
                            borderRadius: context.radius.radiusSM,
                          ),
                          child: Text(
                            '已修改'.tr(),
                            style: context.textStyle.labelSmall.copyWith(
                              color: context.colors.onPrimaryContainer,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    currentColor.colorToHexString(),
                    style: context.textStyle.bodySmall.copyWith(
                      color: context.colors.onSurfaceVariant,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            if (isCustomized)
              IconButton(
                icon: Icon(Icons.refresh_rounded, size: 20),
                color: context.colors.primary,
                onPressed: () {
                  _updateColor(
                    context,
                    ref,
                    key: item.key,
                    color: null,
                    currentColors: currentColors,
                    isDark: isDark,
                    customThemeNotifier: customThemeNotifier,
                  );
                },
                tooltip: '恢复默认'.tr(),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: context.colors.onSurfaceVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
