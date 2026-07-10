import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gen/assets.gen.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/routes/routes.gr.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'widget.dart';

@RoutePage()
class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');

      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Future.delayed(const Duration(seconds: 3), () {
      //     if (context.mounted) {
      //       UpdateChecker.autoCheckUpdate(context, ref);
      //     }
      //   });
      // });

      return () {
        log.d('$this dispose');
      };
    }, []);

    final selectedItemColor = context.colors.primary;
    final unselectedItemColor = context.colors.onSurface;
    const double widthHeight = 22.0;

    return AutoTabsScaffold(
      routes: const [
        ExampleRoute(),
        MatchColorsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          selectedFontSize: widthHeight,
          unselectedFontSize: widthHeight,
          selectedLabelStyle: context.textStyle.labelSmall,
          unselectedLabelStyle: context.textStyle.labelSmall,
          items: [
            BottomNavigationBarItem(
              label: '资产'.tr(),
              icon: Assets.icons.assets.svg(
                width: widthHeight,
                height: widthHeight,
                colorFilter: ColorFilter.mode(
                  tabsRouter.activeIndex == 0
                      ? selectedItemColor
                      : unselectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '设置'.tr(),
              icon: Assets.icons.setting.svg(
                width: widthHeight,
                height: widthHeight,
                colorFilter: ColorFilter.mode(
                  tabsRouter.activeIndex == 1
                      ? selectedItemColor
                      : unselectedItemColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
