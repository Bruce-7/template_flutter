// import 'package:flutter_app/managers/purchases.dart';
// import 'package:flutter_app/models/user.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'user_state.g.dart';
//
// // 主要目的触发状态改变UI好及时刷新，业务取对应信息还是通过subscriptionManager。
// // keepAlive 保持状态，不销毁。
// @Riverpod(keepAlive: true)
// class UserState extends _$UserState {
//   @override
//   Future<User> build({bool showToast = false}) async {
//     purchasesManager.addUserUpdateListener(change: (user) {
//       updateUser(user);
//     });
//
//     ref.onDispose(() {
//       purchasesManager.removeCustomerInfoUpdateListener();
//     });
//
//     return await purchasesManager.getCustomerInfo(showToast: showToast) ?? User();
//   }
//
//   /// 更新用户信息
//   void updateUser(User user) {
//     state = AsyncValue.data((state.hasValue ? state.value?.copyWith(info: user.info) : null) ?? user);
//   }
// }
