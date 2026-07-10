import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_state.g.dart';

@riverpod
class ThemeModeState extends _$ThemeModeState with WidgetsBindingObserver {
  @override
  ThemeMode build() {
    // 读取持久化的主题模式
    final index = dbManager.prefs.getInt(kAppThemeMode);
    final mode = ThemeMode.values[index ?? ThemeMode.system.index];

    return mode;
  }

  bool isDark(BuildContext context) {
    return state == ThemeMode.dark || (state == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);
  }

  /// 手动设置主题模式（亮、暗、跟随系统）
  void setMode(ThemeMode mode) {
    if (state == mode) return;
    state = mode;
    _save();
  }

  void forceUpdate() {
    final oldMode = state;
    setMode(oldMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    setMode(oldMode);
  }

  /// 保存到本地
  void _save() {
    dbManager.prefs.setInt(kAppThemeMode, state.index);
  }

  /// 获取主题模式文本
  String getThemeModeText() {
    switch (state) {
      case ThemeMode.system:
        return '跟随系统'.tr();
      case ThemeMode.light:
        return '浅色'.tr();
      case ThemeMode.dark:
        return '深色'.tr();
    }
  }
}
