import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/language.dart';

abstract class Translations {
  /// 跟随系统（特殊处理）if (result.languageCode == Translations.system) await context.resetLocale();
  static String system = 'system';
  static const Locale systemLocale = Locale('system', 'System');

  /// 简体中文（中国）
  static const Locale chineseSimplified = Locale('zh', 'CN');

  /// 繁体中文（中国香港）= zh_HK
  static const Locale chineseHongKong = Locale('zh', 'HK');

  /// 繁体中文（中国台湾）= zh_TW
  static const Locale chineseTraditional = Locale('zh', 'TW');

  /// 美国英语
  static const Locale englishUnitedStates = Locale('en', 'US');

  /// 日语（日本）= ja_JP
  static const Locale japanese = Locale('ja', 'JP');

  /// 韩语（韩国）= ko_KR
  static const Locale korean = Locale('ko', 'KR');

  /// 保加利亚语（保加利亚）
  static const Locale bulgarian = Locale('bg', 'BG');

  /// 丹麦语（丹麦）
  static const Locale danish = Locale('da', 'DK');

  /// 德语（德国）
  static const Locale german = Locale('de', 'DE');

  /// 芬兰语（芬兰）
  static const Locale finnish = Locale('fi', 'FI');

  /// 法语（法国）
  static const Locale french = Locale('fr', 'FR');

  /// 意大利语（意大利）
  static const Locale italian = Locale('it', 'IT');

  /// 挪威语（挪威）
  static const Locale norwegian = Locale('nb', 'NO');

  /// 罗马尼亚语（罗马尼亚）
  static const Locale romanian = Locale('ro', 'RO');

  /// 俄语（俄罗斯）
  static const Locale russian = Locale('ru', 'RU');

  /// 瑞典语（瑞典）
  static const Locale swedish = Locale('sv', 'SE');

  /// 泰语（泰国）
  static const Locale thai = Locale('th', 'TH');

  static List<Locale> supportedLocales = [
    chineseSimplified,
    // chineseHongKong,
    // chineseTraditional,
    englishUnitedStates,
    // japanese,
    // korean,
    // bulgarian,
    // danish,
    // german,
    // finnish,
    // french,
    // italian,
    // norwegian,
    // romanian,
    // russian,
    // swedish,
    // thai,
  ];

  /// 获取语言名称（显示各自看得懂的语言不用在国际化）
  static String getLocaleName(Locale locale) {
    switch (locale) {
      case Translations.systemLocale:
        return '跟随系统'.tr();

      case Translations.chineseSimplified:
        return '简体中文';

      case Translations.chineseHongKong:
        return '繁體中文（香港）';

      case Translations.chineseTraditional:
        return '繁體中文（台灣）';

      case Translations.englishUnitedStates:
        return 'English';

      case Translations.japanese:
        return '日本語';

      case Translations.korean:
        return '한국어';

      case Translations.bulgarian:
        return 'Български';

      case Translations.danish:
        return 'Dansk';

      case Translations.german:
        return 'Deutsch';

      case Translations.finnish:
        return 'Suomi';

      case Translations.french:
        return 'Français';

      case Translations.italian:
        return 'Italiano';

      case Translations.norwegian:
        return 'Norsk Bokmål';

      case Translations.romanian:
        return 'Română';

      case Translations.russian:
        return 'Русский';

      case Translations.swedish:
        return 'Svenska';

      case Translations.thai:
        return 'ไทย';

      default:
        return '简体中文';
    }
  }

  static List<Language> languages = [
    Language(locale: Translations.chineseSimplified, name: getLocaleName(Translations.chineseSimplified)),
    Language(locale: Translations.chineseHongKong, name: getLocaleName(Translations.chineseHongKong)),
    Language(locale: Translations.chineseTraditional, name: getLocaleName(Translations.chineseTraditional)),
    Language(locale: Translations.englishUnitedStates, name: getLocaleName(Translations.englishUnitedStates)),
    Language(locale: Translations.japanese, name: getLocaleName(Translations.japanese)),
    Language(locale: Translations.korean, name: getLocaleName(Translations.korean)),
    Language(locale: Translations.bulgarian, name: getLocaleName(Translations.bulgarian)),
    Language(locale: Translations.danish, name: getLocaleName(Translations.danish)),
    Language(locale: Translations.german, name: getLocaleName(Translations.german)),
    Language(locale: Translations.finnish, name: getLocaleName(Translations.finnish)),
    Language(locale: Translations.french, name: getLocaleName(Translations.french)),
    Language(locale: Translations.italian, name: getLocaleName(Translations.italian)),
    Language(locale: Translations.norwegian, name: getLocaleName(Translations.norwegian)),
    Language(locale: Translations.romanian, name: getLocaleName(Translations.romanian)),
    Language(locale: Translations.russian, name: getLocaleName(Translations.russian)),
    Language(locale: Translations.swedish, name: getLocaleName(Translations.swedish)),
    Language(locale: Translations.thai, name: getLocaleName(Translations.thai)),
  ];
}
