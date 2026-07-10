part of 'page.dart';

extension MatchColorsPageFunction on MatchColorsPage {
  void _updateColor(
    BuildContext context,
    WidgetRef ref, {
    required String key,
    required Color? color,
    required CustomThemeColors? currentColors,
    required bool isDark,
    required CustomThemeState customThemeNotifier,
  }) {
    final colorValue = color?.colorToInt();
    final baseColors = currentColors ?? const CustomThemeColors();

    final json = baseColors.toJson();
    json[key] = colorValue;
    final updatedColors = CustomThemeColors.fromJson(json);

    if (isDark) {
      customThemeNotifier.setDarkColors(updatedColors);
    } else {
      customThemeNotifier.setLightColors(updatedColors);
    }
  }
}
