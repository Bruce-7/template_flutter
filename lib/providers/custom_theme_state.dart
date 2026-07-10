import 'package:flutter_app/extension/db_prefs_extension.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/providers/theme_mode_state.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_app/theme/custom_theme_colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_theme_state.g.dart';

@riverpod
class CustomThemeState extends _$CustomThemeState {
  @override
  CustomThemeStateData build() {
    final enableCustomTheme = dbManager.getEnableCustomTheme();
    final lightColors = dbManager.getCustomThemeColorsLight();
    final darkColors = dbManager.getCustomThemeColorsDark();

    return CustomThemeStateData(
      enableCustomTheme: enableCustomTheme,
      lightColors: lightColors,
      darkColors: darkColors,
    );
  }

  Future<void> setEnableCustomTheme(bool enable) async {
    await dbManager.setEnableCustomTheme(enable);
    AppTheme.clearThemeCache();

    state = state.copyWith(enableCustomTheme: enable);
    _refreshTheme(force: true);
  }

  Future<void> setLightColors(CustomThemeColors colors) async {
    await dbManager.setCustomThemeColorsLight(colors);
    AppTheme.clearThemeCache();

    state = state.copyWith(lightColors: colors);
    _refreshTheme();
  }

  Future<void> setDarkColors(CustomThemeColors colors) async {
    await dbManager.setCustomThemeColorsDark(colors);
    AppTheme.clearThemeCache();

    state = state.copyWith(darkColors: colors);
    _refreshTheme();
  }

  Future<void> resetLightColors() async {
    await dbManager.setCustomThemeColorsLight(null);
    AppTheme.clearThemeCache();

    state = state.copyWith(lightColors: null, clearLightColors: true);
    _refreshTheme();
  }

  Future<void> resetDarkColors() async {
    await dbManager.setCustomThemeColorsDark(null);
    AppTheme.clearThemeCache();

    state = state.copyWith(darkColors: null, clearDarkColors: true);
    _refreshTheme();
  }

  CustomThemeColors? getColors(bool isDark) {
    return isDark ? state.darkColors : state.lightColors;
  }

  void _refreshTheme({bool? force}) {
    if (state.enableCustomTheme || force == true) {
      ref.read(themeModeStateProvider.notifier).forceUpdate();
    }
  }
}

class CustomThemeStateData {
  final bool enableCustomTheme;
  final CustomThemeColors? lightColors;
  final CustomThemeColors? darkColors;

  const CustomThemeStateData({
    required this.enableCustomTheme,
    this.lightColors,
    this.darkColors,
  });

  CustomThemeStateData copyWith({
    bool? enableCustomTheme,
    CustomThemeColors? lightColors,
    CustomThemeColors? darkColors,
    bool clearLightColors = false,
    bool clearDarkColors = false,
  }) {
    return CustomThemeStateData(
      enableCustomTheme: enableCustomTheme ?? this.enableCustomTheme,
      lightColors: clearLightColors ? null : (lightColors ?? this.lightColors),
      darkColors: clearDarkColors ? null : (darkColors ?? this.darkColors),
    );
  }
}
