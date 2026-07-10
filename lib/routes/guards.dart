// 身份验证守卫示例
import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/routes/routes.gr.dart';

class AuthGuard extends AutoRouteGuard {
  // 模拟身份验证状态
  bool _authenticated = false;

  // 设置身份验证状态的方法（实际项目中可能来自状态管理或服务）
  void setAuthenticated(bool value) {
    _authenticated = value;
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // 判断是否需要身份验证
    final requiresAuth = ![MainRoute.name, NotFoundRoute.name].contains(resolver.route.name);

    if (!requiresAuth || _authenticated) {
      // 如果不需要身份验证或已经认证，继续导航
      resolver.next(true);
    } else {
      // 否则重定向到首页
      // 注意：实际应用中通常会重定向到登录页
      resolver.redirectUntil(const MainRoute());
    }
  }
}
