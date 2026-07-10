// 路由助手，用于简化路由跳转
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/routes/routes.dart';

class RoutesNavigator {
  // 私有构造函数，防止被实例化
  RoutesNavigator._();

  static final appRouter = AppRouter();

  // 路由导航方法（内部使用）
  static Future<T?> push<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) =>
      appRouter.push(route, onFailure: onFailure);

  static Future<T?> replace<T extends Object?>(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) =>
      appRouter.replace(route, onFailure: onFailure);

  static Future<dynamic> navigate(
    PageRouteInfo route, {
    OnNavigationFailure? onFailure,
  }) =>
      appRouter.navigate(route, onFailure: onFailure);

  static Future<T?> pushWidget<T extends Object?>(
    Widget widget, {
    RouteTransitionsBuilder? transitionBuilder,
    bool fullscreenDialog = false,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool opaque = true,
  }) =>
      appRouter.pushWidget(
        widget,
        transitionBuilder: transitionBuilder,
        fullscreenDialog: fullscreenDialog,
        transitionDuration: transitionDuration,
        opaque: opaque,
      );

  // 路径导航方法（对外提供path跳转方式。对内禁止使用，统一使用PageRouteInfo安全类型方式）
  static Future<T?> pushPath<T extends Object?>(
    String path, {
    bool includePrefixMatches = false,
    OnNavigationFailure? onFailure,
  }) =>
      appRouter.pushPath(path, includePrefixMatches: includePrefixMatches, onFailure: onFailure);

  static Future<bool> maybePop<T extends Object?>([T? result]) => appRouter.maybePop<T>(result);

  static void popUntilRoot() => appRouter.popUntilRoot();

  // 调试工具 - 打印当前路由栈
  static void printRouteStack() {
    log.i('当前路由栈: ${appRouter.currentSegments.map((e) => e.name).join(' -> ')}');
  }
}
