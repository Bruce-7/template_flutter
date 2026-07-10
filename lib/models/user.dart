// import 'package:flutter_app/extension/customer_info.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
//
// part 'user.g.dart';
//
// // enum UserMembershipLevel {
// //   ordinary /*普通用户*/,
// //   premium /*付费VIP用户*/,
// // }
//
// @JsonSerializable()
// class User {
//   // @JsonKey(
//   //   defaultValue: UserMembershipLevel.ordinary,
//   //   unknownEnumValue: UserMembershipLevel.ordinary,
//   // )
//   // final UserMembershipLevel level;
//   // final String uid;
//   //
//   // User({required this.level, required this.uid});
//
//   @JsonKey(includeFromJson: false)
//   final CustomerInfo? info;
//
//   User({this.info});
//
//   bool isPremiumActive() {
//     // if (kDebugMode) {
//     //   // Hse7enD 测试使用。方便测试会员功能。
//     //   if (!Platform.isIOS && !Platform.isMacOS) {
//     //     return true;
//     //   }
//     // }
//
//     if (info != null) {
//       return info!.isPremiumActive();
//     }
//
//     return false;
//   }
//
//   User copyWith({CustomerInfo? info}) {
//     return User(
//       info: info ?? this.info,
//     );
//   }
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }
