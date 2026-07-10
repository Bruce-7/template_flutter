// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_app/constants/keys.dart';
// import 'package:flutter_app/constants/product_details.dart';
// import 'package:flutter_app/extension/customer_info.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/models/subscription_offer_info.dart';
// import 'package:flutter_app/models/user.dart';
// import 'package:flutter_app/utils/common.dart';
// import 'package:flutter_app/utils/launch_url.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
//
// typedef UserUpdateListener = void Function(User user);
//
// /// 购买服务管理类
// class PurchasesManager {
//   PurchasesManager._();
//
//   static final PurchasesManager instance = PurchasesManager._();
//
//   User? _user;
//
//   /// 初始化 RevenueCat
//   Future<void> initialize({String? appUserId}) async {
//     if (!Platform.isIOS && !Platform.isMacOS) {
//       log.d('当前平台不支持 RevenueCat');
//       return;
//     }
//
//     try {
//       // 设置revenuecat代理
//       await Purchases.setProxyURL("https://api.rc-backup.com/");
//
//       if (kDebugMode) {
//         await Purchases.setLogLevel(LogLevel.debug);
//       }
//
//       PurchasesConfiguration config;
//       // if (kDebugMode) {
//       //   config = PurchasesConfiguration(kRevenueTestCatProjectAppleApiKey);
//       // } else {
//       config = PurchasesConfiguration(kRevenueCatProjectAppleApiKey);
//       // }
//
//       if (appUserId?.isNotEmpty == true) {
//         // 如果没有，revenuecat 默认生成：匿名ID
//         config.appUserID = appUserId;
//       }
//
//       await Purchases.configure(config);
//       log.d('RevenueCat 初始化成功');
//     } catch (e) {
//       log.e('RevenueCat 初始化失败: $e');
//     }
//   }
//
//   // 监听用户信息改变
//   void addUserUpdateListener({UserUpdateListener? change}) {
//     if (!Platform.isIOS && !Platform.isMacOS) return;
//
//     Purchases.addCustomerInfoUpdateListener((customerInfo) {
//       _user = _user?.copyWith(info: customerInfo) ?? User(info: customerInfo);
//       change?.call(_user!);
//     });
//   }
//
//   // 移除用户信息监听
//   void removeCustomerInfoUpdateListener() {
//     if (!Platform.isIOS && !Platform.isMacOS) return;
//
//     Purchases.removeCustomerInfoUpdateListener((_) {});
//   }
//
//   /// 获取当前用户信息
//   Future<User?> getCustomerInfo({bool showToast = false}) async {
//     if (!Platform.isIOS && !Platform.isMacOS) return null;
//
//     try {
//       if (_user != null) return _user!;
//
//       final customerInfo = await Purchases.getCustomerInfo();
//       _user = _user?.copyWith(info: customerInfo) ?? User(info: customerInfo);
//       return _user!;
//     } on PlatformException catch (e) {
//       // Error fetching purchaser info
//       log.e(e);
//       if (showToast) {
//         CommonUtil.showToast('获取当前会员信息失败'.tr());
//       }
//       return null;
//     }
//   }
//
//   /// 获取会员资格信息
//   EntitlementInfo? getEntitlementPremiumInfo({required CustomerInfo customerInfo}) {
//     if (!Platform.isIOS && !Platform.isMacOS) return null;
//
//     // 查询订阅ID，有效才代表订阅会员。
//     // final isPremium = purchasePremiumIdentifiers.any(
//     //   (id) => tempCustomerInfo.entitlements.active.containsKey(id),
//     // );
//
//     // 使用 Entitlement 规则获取会员资格
//     if (customerInfo.entitlements.active.containsKey(kEntitlementPremium)) {
//       return customerInfo.entitlements.active[kEntitlementPremium];
//     }
//
//     return null;
//   }
//
//   // 会员是否有效
//   bool isPremiumActive({required CustomerInfo customerInfo}) {
//     final entitlementPremiumInfo = getEntitlementPremiumInfo(customerInfo: customerInfo);
//
//     if (entitlementPremiumInfo != null && entitlementPremiumInfo.isActive) {
//       return true;
//     }
//
//     return false;
//   }
//
//   /// 获取可用的产品信息
//   Future<List<SubscriptionPackage>> getSubscriptionPackages() async {
//     if (!Platform.isIOS && !Platform.isMacOS) return [];
//
//     try {
//       // // 原始产品信息
//       // final products = await Purchases.getProducts(purchasePremiumIdentifiers);
//
//       // 按 revenuecat 的 Offerings 和 Entitlements 规则使用。
//       final offerings = await Purchases.getOfferings();
//
//       final current = offerings.current;
//
//       // Hse7enD 测试使用
//       // final current = offerings.all['com.example.premium.month.year.lifetime'];
//
//       if (current != null) {
//         // 后台配置的有效默认方案
//         List<SubscriptionPackage> tempList = [];
//         for (Package originPackage in current.availablePackages) {
//           SubscriptionPackage package = await _getSubscriptionPackages(originPackage);
//           tempList.add(package);
//         }
//
//         return tempList;
//       }
//
//       return [];
//     } catch (error) {
//       log.e('获取产品信息失败: $error');
//       // 未抛出错误，UI层显示啰嗦的英文，影响用户体验。
//       // rethrow;
//
//       _handleError(error);
//       return [];
//     }
//   }
//
//   /// 购买
//   Future<User?> purchasePackage(SubscriptionPackage package) async {
//     if (!Platform.isIOS && !Platform.isMacOS) {
//       CommonUtil.showToast('当前平台不支持购买'.tr());
//       return null;
//     }
//
//     try {
//       CommonUtil.showLoading(msg: '购买中'.tr());
//
//       // 目前只支持iOS
//       final purchaseResult = await Purchases.purchase(
//         PurchaseParams.package(
//           package.package,
//           // googleProductChangeInfo: null,
//           // googleIsPersonalizedPrice: null,
//           promotionalOffer: package.promotionalOffer,
//           winBackOffer: package.winBackOffer,
//           // customerEmail: customerEmail,
//         ),
//       );
//
//       final isNewPremiumActive = purchaseResult.customerInfo.isPremiumActive();
//
//       if (isNewPremiumActive) {
//         CommonUtil.showToast('🎉恭喜加入资时会员！您的专属特权已全面解锁，尽情体验吧~'.tr());
//       } else {
//         CommonUtil.showToast('稍后再试'.tr());
//       }
//
//       _user = _user?.copyWith(info: purchaseResult.customerInfo) ?? User(info: purchaseResult.customerInfo);
//       return _user;
//     } catch (error) {
//       log.e('购买订阅失败: $error');
//
//       if (_handleError(error)) {
//         return null;
//       }
//
//       CommonUtil.showToast('购买订阅失败'.tr());
//       return null;
//     } finally {
//       CommonUtil.dismiss();
//     }
//   }
//
//   /// 恢复购买
//   Future<bool> restorePurchases() async {
//     if (!Platform.isIOS && !Platform.isMacOS) {
//       CommonUtil.showToast('当前平台不支持恢复购买'.tr());
//       return false;
//     }
//
//     try {
//       CommonUtil.showLoading(msg: '恢复购买中'.tr());
//       final customerInfo = await Purchases.restorePurchases();
//       _user = _user?.copyWith(info: customerInfo) ?? User(info: customerInfo);
//
//       if (customerInfo.isPremiumActive()) {
//         CommonUtil.showToast('恢复购买成功'.tr());
//         return true;
//       } else {
//         CommonUtil.showToast('无效恢复'.tr());
//         return false;
//       }
//     } catch (error) {
//       log.e('恢复购买失败: $error');
//
//       if (_handleError(error)) {
//         return false;
//       }
//
//       CommonUtil.showToast('恢复购买失败'.tr());
//       return false;
//     } finally {
//       CommonUtil.dismiss();
//     }
//   }
//
//   // 唤起系统兑换特别优惠弹窗
//   Future<void> presentCodeRedemptionSheet() async {
//     if (!Platform.isIOS && !Platform.isMacOS) return;
//
//     await Purchases.presentCodeRedemptionSheet();
//   }
//
// // 唤起订阅管理页面
//   void showManageSubscriptions() async {
//     if (!Platform.isIOS && !Platform.isMacOS) return;
//
//     final url = 'https://apps.apple.com/account/subscriptions';
//     LaunchUrl.handleLink(url, fail: () async {
//       await Clipboard.setData(ClipboardData(text: url));
//       CommonUtil.showToast('已复制'.tr());
//     });
//   }
// }
//
// extension SubscriptionManagerFunction on PurchasesManager {
//   /// 检查产品是否满足优惠资格
//   Future<bool> _checkTrialOrIntroductoryPriceEligibility(StoreProduct product) async {
//     if (!Platform.isIOS && !Platform.isMacOS) return false;
//
//     try {
//       Map<String, IntroEligibility> introMap = await Purchases.checkTrialOrIntroductoryPriceEligibility([product.identifier]);
//       if (introMap.containsKey(product.identifier)) {
//         IntroEligibility? intro = introMap[product.identifier];
//         if (intro?.status == IntroEligibilityStatus.introEligibilityStatusEligible) {
//           return true;
//         }
//       }
//     } catch (error) {
//       log.e('验证优惠资格失败： $error');
//     }
//
//     return false;
//   }
//
//   /// 获取老顾客回归优惠
//   /// 从 Package 中获取可用的 winBackOffer
//   WinBackOffer? _getWinBackOffer(Package package) {
//     // 暂不支持这套业务
//     // try {
//     //   // iOS 18+ 支持老顾客回归优惠
//     //   // 注意：winBackOffer 可能在较新版本的 SDK 中可用
//     //   // 如果当前版本不支持，此方法将返回 null
//     //   return null;
//     // } catch (e) {
//     //   log.e('获取老顾客回归优惠失败: $e');
//     //   return null;
//     // }
//
//     return null;
//   }
//
//   /// 获取促销优惠
//   /// 需要传入产品和折扣信息
//   Future<PromotionalOffer?> _getPromotionalOffer(StoreProduct product,
//       StoreProductDiscount discount,) async {
//     if (!Platform.isIOS && !Platform.isMacOS) return null;
//
//     try {
//       return Purchases.getPromotionalOffer(product, discount);
//     } catch (e) {
//       log.e('获取促销优惠失败: $e');
//       return null;
//     }
//   }
//
//   /// 获取产品的优惠信息
//   /// 优先级：促销优惠 > 老顾客回归优惠 > 推介促销优惠
//   Future<SubscriptionPackage> _getSubscriptionPackages(Package package) async {
//     final product = package.storeProduct;
//     final offerDescription = '原价 {} 限时优惠'.tr(args: [package.storeProduct.priceString]);
//     final pass = await _checkTrialOrIntroductoryPriceEligibility(product);
//
//     // 1. 检查是否有促销优惠，且满足优惠资格
//     if (product.discounts?.isNotEmpty == true && pass) {
//       try {
//         final discount = product.discounts!.first;
//         PromotionalOffer? promoOffer = await _getPromotionalOffer(product, discount);
//
//         if (promoOffer != null) {
//           return SubscriptionPackage(
//             package: package,
//             promotionalOffer: promoOffer,
//             discount: discount,
//             offerDescription: offerDescription,
//           );
//         }
//       } catch (error) {
//         log.e('获取促销优惠失败: $error');
//       }
//     }
//
//     // 2. 检查老顾客回归优惠
//     final winBackOffer = _getWinBackOffer(package);
//     if (winBackOffer != null && pass) {
//       return SubscriptionPackage(
//         package: package,
//         winBackOffer: winBackOffer,
//         offerDescription: offerDescription,
//       );
//     }
//
//     // 3. 检查是否满足推介促销优惠资格
//     if (product.introductoryPrice != null && pass) {
//       return SubscriptionPackage(
//         package: package,
//         introductoryPrice: product.introductoryPrice,
//         offerDescription: offerDescription,
//       );
//     }
//
//     PackageType type = package.packageType;
//     if (type == PackageType.lifetime) {
//       return SubscriptionPackage(
//         package: package,
//         offerDescription: '限时优惠'.tr(),
//       );
//     }
//
//     return SubscriptionPackage(package: package);
//   }
//
//   // 返回true代表处理
//   bool _handleError(Object error) {
//     if (error is PlatformException) {
//       if (error.details is Map) {
//         String readableErrorCode = error.details['readable_error_code'];
//
//         switch (readableErrorCode) {
//           case 'PURCHASE_CANCELLED':
//             CommonUtil.showToast('取消了购买'.tr());
//             return true;
//
//           case 'PURCHASE_INVALID':
//             CommonUtil.showToast('购买参数之一无效'.tr());
//             return true;
//
//           case 'INVALID_CREDENTIALS':
//             CommonUtil.showToast('配置了无效的凭据'.tr());
//             return true;
//
//           case 'NETWORK_ERROR':
//             CommonUtil.showToast('操作过程中发生网络错误'.tr());
//             return true;
//
//           case 'OFFLINE_CONNECTION_ERROR':
//             CommonUtil.showToast('尝试发起网络请求时处于离线状态'.tr());
//             return true;
//
//           case 'OPERATION_ALREADY_IN_PROGRESS':
//             CommonUtil.showToast('已存在相同的操作正在进行中'.tr());
//             return true;
//
//           case 'UNKNOWN_BACKEND_ERROR':
//             CommonUtil.showToast('未知服务器错误'.tr());
//             return true;
//
//           case 'UNKNOWN':
//             CommonUtil.showToast('发生未知错误'.tr());
//             return true;
//
//           case 'RECEIPT_ALREADY_IN_USE':
//             CommonUtil.showToast('已有其他用户正在使用相同的收据'.tr());
//             return true;
//
//           case 'INELIGIBLE_ERROR':
//             CommonUtil.showToast('不符合特定订阅优惠的条件'.tr());
//             return true;
//
//           case 'INSUFFICIENT_PERMISSIONS_ERROR':
//             CommonUtil.showToast('没有足够的权限进行应用内购买'.tr());
//             return true;
//
//           case 'PRODUCT_ALREADY_PURCHASED':
//           case 'ITEM_ALREADY_OWNED':
//             CommonUtil.showToast('该产品已激活'.tr());
//             return true;
//
//           case 'PRODUCT_NOT_AVAILABLE_FOR_PURCHASE':
//           case 'ITEM_UNAVAILABLE':
//             CommonUtil.showToast('无法通过该设备购买'.tr());
//             return true;
//
//           case 'PURCHASE_NOT_ALLOWED':
//             CommonUtil.showToast('该设备无权进行购买'.tr());
//             return true;
//         }
//       }
//
//       if (error.message?.isNotEmpty == true) {
//         CommonUtil.showToast(error.message!);
//         return true;
//       }
//     }
//
//     return false;
//   }
// }
//
// // 购买服务管理
// final purchasesManager = PurchasesManager.instance;
