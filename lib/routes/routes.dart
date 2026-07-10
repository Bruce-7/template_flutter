import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.material(); // 统一使用material风格

  @override
  List<AutoRoute> get routes => [
        // 主要页面Tab bar
        AutoRoute(
          initial: true,
          path: '/${MainRoute.name}',
          page: MainRoute.page,
          children: [
            // 示例页面
            AutoRoute(
              path: ExampleRoute.name,
              page: ExampleRoute.page,
            ),
            // 主题配色页面
            AutoRoute(
              path: MatchColorsRoute.name,
              page: MatchColorsRoute.page,
            ),
          ],
        ),

        // 图片裁剪页面
        CustomRoute(
          path: '/${ImageCropRoute.name}',
          page: ImageCropRoute.page,
          duration: Duration.zero,
          transitionsBuilder: TransitionsBuilders.fadeIn /*淡入淡出*/,
        ),

        // 预览图片页面
        CustomRoute(
          path: '/${PreviewImageRoute.name}',
          page: PreviewImageRoute.page,
          opaque: false,
          duration: Duration.zero,
          transitionsBuilder: TransitionsBuilders.fadeIn /*淡入淡出*/,
          fullscreenDialog: true /*全屏显示，避免A push B，A其实会左偏移导致右边有很宽的黑边。滑动退出页面就看见了*/,
        ),

        // // 订阅页面
        // AutoRoute(
        //   path: '/${SubscriptionRoute.name}',
        //   page: SubscriptionRoute.page,
        // ),

        // 主题配色页面
        AutoRoute(
          path: '/${MatchColorsRoute.name}',
          page: MatchColorsRoute.page,
        ),

        // 示例页面（测试用）
        AutoRoute(
          path: '/${ExampleRoute.name}',
          page: ExampleRoute.page,
          // initial: true,
        ),

        // 通配符路由 - 必须放在最后
        AutoRoute(
          path: '*',
          page: NotFoundRoute.page,
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // 身份验证守卫示例
        // AuthGuard(),
      ];
}
