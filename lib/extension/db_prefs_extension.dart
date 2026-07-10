import 'dart:convert';

import 'package:flutter_app/constants/keys.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/theme/custom_theme_colors.dart';

/// 偏好设置存储读、写。
extension DbManagerPrefs on DbManager {
  List<String> categoriesName() {
    return prefs.getStringList(kCategoriesName) ?? [];
  }

  void setCategoriesName(List<String> categoriesName) {
    prefs.setStringList(kCategoriesName, categoriesName);
  }

  List<String> tagsName() {
    return prefs.getStringList(kTagsName) ?? [];
  }

  void setTagsName(List<String> tagsName) {
    prefs.setStringList(kTagsName, tagsName);
  }

  // 获取跳过的版本号
  String? getSkippedVersion() {
    return prefs.getString(kSkippedVersion);
  }

  // 设置跳过的版本号
  Future<bool> setSkippedVersion(String version) async {
    return prefs.setString(kSkippedVersion, version);
  }

  // 清除跳过的版本号
  Future<bool> clearSkippedVersion() async {
    return prefs.remove(kSkippedVersion);
  }

  // 获取是否启用自定义主题配色
  bool getEnableCustomTheme() {
    return prefs.getBool(kEnableCustomTheme) ?? false;
  }

  // 设置是否启用自定义主题配色
  Future<bool> setEnableCustomTheme(bool enable) async {
    return prefs.setBool(kEnableCustomTheme, enable);
  }

  // 获取自定义主题配色(Light模式)
  CustomThemeColors? getCustomThemeColorsLight() {
    final jsonString = prefs.getString(kCustomThemeColorsLight);
    if (jsonString != null) {
      return CustomThemeColors.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // 设置自定义主题配色(Light模式)
  Future<bool> setCustomThemeColorsLight(CustomThemeColors? colors) async {
    if (colors != null) {
      return prefs.setString(kCustomThemeColorsLight, jsonEncode(colors.toJson()));
    }
    return prefs.remove(kCustomThemeColorsLight);
  }

  // 获取自定义主题配色(Dark模式)
  CustomThemeColors? getCustomThemeColorsDark() {
    final jsonString = prefs.getString(kCustomThemeColorsDark);
    if (jsonString != null) {
      return CustomThemeColors.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  // 设置自定义主题配色(Dark模式)
  Future<bool> setCustomThemeColorsDark(CustomThemeColors? colors) async {
    if (colors != null) {
      return prefs.setString(kCustomThemeColorsDark, jsonEncode(colors.toJson()));
    }
    return prefs.remove(kCustomThemeColorsDark);
  }
}
