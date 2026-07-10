// import 'package:purchases_flutter/purchases_flutter.dart';
//
// /// 优惠信息数据模型
// class SubscriptionPackage {
//   // 原始包信息
//   final Package package;
//
//   // 推介促销优惠信息
//   final IntroductoryPrice? introductoryPrice;
//
//   // 促销优惠信息 promotionalOffer 给苹果购买的签名等信息，discount优惠信息。
//   final PromotionalOffer? promotionalOffer;
//   final StoreProductDiscount? discount;
//
//   // 回归优惠信息
//   final WinBackOffer? winBackOffer;
//
//   // 自定义提示文案
//   final String? offerDescription;
//
//   SubscriptionPackage({
//     required this.package,
//     this.introductoryPrice,
//     this.promotionalOffer,
//     this.discount,
//     this.winBackOffer,
//     this.offerDescription,
//   });
//
//   /// 显示UI价格，如果有优惠按优先级取。
//   String priceString() {
//     if (introductoryPrice?.priceString.isNotEmpty == true) {
//       return introductoryPrice!.priceString;
//     }
//
//     if (winBackOffer?.priceString.isNotEmpty == true) {
//       return winBackOffer!.priceString;
//     }
//
//     if (discount?.priceString.isNotEmpty == true) {
//       return discount!.priceString;
//     }
//
//     return package.storeProduct.priceString;
//   }
//
//   /// 用于计算价格
//   double price() {
//     if (introductoryPrice?.price != null) {
//       return introductoryPrice!.price;
//     }
//
//     if (winBackOffer?.price != null) {
//       return winBackOffer!.price;
//     }
//
//     if (discount?.price != null) {
//       return discount!.price;
//     }
//
//     return package.storeProduct.price;
//   }
// }
