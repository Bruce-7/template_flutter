import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/db.dart';
import 'package:flutter_app/managers/translations.dart';
import 'package:flutter_app/providers/theme_mode_state.dart';
import 'package:flutter_app/routes/routes_navigator.dart';
import 'package:flutter_app/theme/app_theme.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/widgets/smart_dialog/loading.dart';
import 'package:flutter_app/widgets/smart_dialog/toast.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 初始化全局配置
Future<void> _initGlobalConfig() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await dbManager.init();

  if (kDebugMode) {
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    // EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning, LevelMessages.info, LevelMessages.debug];
  }

  // 初始化订阅
  // await purchasesManager.initialize();

  // 全局锁定竖屏
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
}

void main() async {
  await _initGlobalConfig();

  runApp(
    EasyLocalization(
      supportedLocales: Translations.supportedLocales,
      path: 'assets/translations' /*更改翻译文件的路径*/,
      useFallbackTranslations: true /*如果在本地化文件中找不到本地化语言，则尝试使用 fallbackLocale 指定的语言。*/,
      fallbackLocale: Translations.chineseSimplified,
      useFallbackTranslationsForEmptyResources: true,
      child: const ProviderScope(
        // 为了让部件能够读取提供程序，我们需要用 “ProviderScope ”部件将整个
        // 应用程序封装在一个 “ProviderScope ”部件中。
        // 这是存储提供程序状态的地方。
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeModeStateProvider);

    final themeData = AppTheme.getTheme(context, false);
    final darkThemeData = AppTheme.getTheme(context, true);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false /*右上角debug角标*/,
        themeMode: themeModeState,
        theme: themeData,
        darkTheme: darkThemeData,
        highContrastTheme: themeData,
        highContrastDarkTheme: darkThemeData,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: RoutesNavigator.appRouter.config(
          navigatorObservers: () => [FlutterSmartDialog.observer],
        ),
        builder: (context, child) {
          EasyRefresh.defaultHeaderBuilder = () => _buildMaterialHeader(context);
          EasyRefresh.defaultFooterBuilder = () => _buildClassicFooter(context);

          return FlutterSmartDialog.init(
            toastBuilder: (msg) => Toast(msg: msg),
            loadingBuilder: (msg) => Loading(msg: msg),
          )(context, child);
        });
  }

  MaterialHeader _buildMaterialHeader(BuildContext context) {
    return MaterialHeader(
      clamping: false,
      triggerOffset: 70,
      color: context.colors.primary,
      valueColor: AlwaysStoppedAnimation(context.colors.primary),
      backgroundColor: context.colors.onPrimary,
    );
  }

  ClassicFooter _buildClassicFooter(BuildContext context) {
    return ClassicFooter(
      position: IndicatorPosition.behind,
      dragText: '上拉加载'.tr(),
      armedText: '释放立即加载'.tr(),
      readyText: '准备加载'.tr(),
      processingText: '加载中'.tr(),
      processedText: '加载完成'.tr(),
      noMoreText: '没有更多数据了'.tr(),
      failedText: '加载失败'.tr(),
      messageText: '${'最后加载时间'.tr()} %T',
      textStyle: context.textStyle.labelMedium.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      messageStyle: context.textStyle.labelMedium.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      iconTheme: IconThemeData(
        size: 24,
        color: context.colors.onSurfaceVariant,
      ),
    );
  }
}
