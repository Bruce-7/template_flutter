// part of 'page.dart';
//
// extension SubscriptionPageFunction on SubscriptionPage {
//   /// 刷新订阅状态
//   void _refreshState(
//     BuildContext context,
//     WidgetRef ref, {
//     required ValueNotifier<SubscriptionPackage?> selectedPackageState,
//   }) {
//     selectedPackageState.value = null;
//     ref.invalidate(subscriptionStateProvider);
//   }
//
//   /// 处理购买
//   Future<void> _handlePurchase(
//     BuildContext context,
//     WidgetRef ref, {
//     required ValueNotifier<SubscriptionPackage?> selectedPackageState,
//   }) async {
//     if (selectedPackageState.value != null) {
//       await purchasesManager.purchasePackage(selectedPackageState.value!);
//
//       if (context.mounted) {
//         _refreshState(context, ref, selectedPackageState: selectedPackageState);
//       }
//     }
//   }
//
//   /// 处理恢复购买
//   Future<void> _handleRestorePurchases(
//     BuildContext context,
//     WidgetRef ref, {
//     required ValueNotifier<SubscriptionPackage?> selectedPackageState,
//   }) async {
//     final result = await purchasesManager.restorePurchases();
//
//     if (result && context.mounted) {
//       _refreshState(context, ref, selectedPackageState: selectedPackageState);
//     }
//   }
//
//   // 提取符号
//   String _extractCurrencySymbol(String price) {
//     final s = price.trim();
//     if (s.isEmpty) return '';
//
//     final match = RegExp(r'\d').firstMatch(s);
//     if (match == null) {
//       // 字符串里没有数字，认为整个字符串是“前缀”
//       return s;
//     }
//
//     final idx = match.start;
//     if (idx == 0) return ''; // 第一个字符就是数字
//
//     return s.substring(0, idx).trim();
//   }
//
//   // 获取订阅文本
//   String _getPackageTypeText(SubscriptionPackage package) {
//     PackageType type = package.package.packageType;
//     final price = package.price();
//
//     // 如果价格第一个不是数字则获取价格第一个符号
//     final currencySymbol = _extractCurrencySymbol(package.priceString());
//
//     switch (type) {
//       case PackageType.monthly:
//         final averagePrice = price / 30;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.annual:
//         final averagePrice = price / 365;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.weekly:
//         final averagePrice = price / 7;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.twoMonth:
//         final averagePrice = price / 60;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.threeMonth:
//         final averagePrice = price / 90;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.sixMonth:
//         final averagePrice = price / 180;
//         return '低至 {}/天'.tr(args: [(currencySymbol + averagePrice.toStringAsFixed(3))]);
//       case PackageType.lifetime:
//         return '一次费用，永久权益'.tr();
//       default:
//         return '';
//     }
//   }
// }
