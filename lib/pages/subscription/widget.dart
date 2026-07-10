// part of 'page.dart';
//
// extension SubscriptionPageWidget on SubscriptionPage {
//   // 订阅产品项
//   Widget _buildSubscriptionItem(
//     BuildContext context,
//     WidgetRef ref, {
//     required SubscriptionPackage package,
//     required ValueNotifier<SubscriptionPackage?> selectedPackageState,
//   }) {
//     final product = package.package.storeProduct;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         selectedPackageState.value = package;
//       },
//       child: Container(
//         padding: context.spacing.paddingMD,
//         decoration: BoxDecoration(
//           color: context.colors.surfaceContainer,
//           borderRadius: context.radius.radiusMD,
//           border: selectedPackageState.value == package ? Border.all(color: context.colors.primary, width: context.spacing.strokeMedium) : null,
//           boxShadow: [
//             BoxShadow(
//               color: context.colors.shadow,
//               blurRadius: 4.0, // 模糊程度
//               spreadRadius: 0.0, // 不扩展阴影
//               offset: const Offset(0, 0),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 4,
//           children: [
//             Text(
//               product.title.tr(),
//               style: context.textStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
//             ),
//             Text(
//               product.description.tr(),
//               style: context.textStyle.bodySmall.copyWith(
//                 color: context.colors.onSurfaceVariant,
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   package.priceString(),
//                   style: context.textStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600).copyWith(
//                         color: context.colors.primary,
//                       ),
//                 ),
//                 SizedBox(width: 8),
//                 // 显示优惠信息
//                 if (package.offerDescription?.isNotEmpty == true)
//                   Text(
//                     package.offerDescription!,
//                     style: context.textStyle.labelSmall.copyWith(
//                       color: context.colors.onSurfaceVariant,
//                     ),
//                   ),
//               ],
//             ),
//             Text(
//               _getPackageTypeText(package),
//               style: context.textStyle.labelSmall.copyWith(
//                 color: context.colors.onSurfaceVariant,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 会员信息
//   Widget _buildSubscriptionInfo(
//     BuildContext context,
//     WidgetRef ref, {
//     required AsyncValue<User> userState,
//   }) {
//     if (userState.hasValue && userState.value != null && userState.value!.info != null) {
//       final customerInfo = userState.value!.info!;
//
//       final entitlementPremiumInfo = purchasesManager.getEntitlementPremiumInfo(customerInfo: customerInfo);
//
//       if (entitlementPremiumInfo != null && entitlementPremiumInfo.isActive) {
//         return CardContainer(
//           width: double.infinity,
//           margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
//           child: Column(
//             children: [
//               Text(
//                 '尊贵的资时会员'.tr(),
//                 style: context.textStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
//               ),
//               entitlementPremiumInfo.expirationDate != null
//                   ? Text(
//                       '到期日：'.tr() + DateFormatUtil.yMdLocalizedDate(DateTime.tryParse(entitlementPremiumInfo.expirationDate!) ?? DateTime.now()),
//                       style: context.textStyle.bodyMedium.copyWith(
//                         color: context.colors.onSurfaceVariant,
//                       ),
//                     )
//                   : Text(
//                       '永久会员'.tr(),
//                       style: context.textStyle.bodyMedium.copyWith(
//                         color: context.colors.onSurfaceVariant,
//                       ),
//                     ),
//             ],
//           ),
//         );
//       }
//     }
//
//     return CardContainer(
//       width: double.infinity,
//       margin: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
//       child: Column(
//         children: [
//           Text(
//             '成为资时会员'.tr(),
//             style: context.textStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
//           ),
//           Text(
//             '解锁全部权益'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.onSurfaceVariant,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 会员权益一栏
//   Widget _buildSubscriptionBenefits(BuildContext context, WidgetRef ref) {
//     return CardContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 标题
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '会员权益'.tr(),
//                 style: context.textStyle.titleMedium.copyWith(fontWeight: FontWeight.w600),
//               ),
//               TextButton(
//                 onPressed: () {
//                   showDetailed(context);
//                 },
//                 child: Text(
//                   '详细说明'.tr(),
//                   style: context.textStyle.labelSmall.copyWith(
//                     color: context.colors.onSurfaceVariant,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           _buildDashedDivider(context),
//           const SizedBox(height: 12),
//
//           // 权益列表
//           _buildBenefitItem(
//             context,
//             '资产'.tr(),
//             '无限制记录'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '附加费用'.tr(),
//             '无限制记录'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '图标移除背景'.tr(),
//             '无限制操作'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '到期通知'.tr(),
//             '无限制操作'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '资产标签'.tr(),
//             '支持最大个数'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '礼记'.tr(),
//             '无限制记录'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '往来记录'.tr(),
//             '无限制记录'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '备注图片'.tr(),
//             '支持最大张数'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             '导出导入备份'.tr(),
//             '无限制操作'.tr(),
//           ),
//           _buildBenefitItem(
//             context,
//             'iCloud',
//             '支持同步'.tr(),
//           ),
//
//           Center(
//             child: Text(
//               '~ 更多权益等待解锁 ~'.tr(),
//               style: context.textStyle.labelSmall.copyWith(
//                 color: context.colors.onSurfaceVariant,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 构建单个权益项
//   Widget _buildBenefitItem(
//     BuildContext context,
//     String title,
//     String description, {
//     bool showDashedDivider = true,
//   }) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: context.textStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: context.textStyle.bodySmall.copyWith(
//                       color: context.colors.onSurfaceVariant,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.check,
//               color: context.colors.primary,
//               size: 24,
//             ),
//           ],
//         ),
//         if (showDashedDivider) ...[
//           const SizedBox(height: 12),
//           _buildDashedDivider(context),
//           const SizedBox(height: 12),
//         ],
//       ],
//     );
//   }
//
//   // 构建虚线分隔线
//   Widget _buildDashedDivider(BuildContext context) {
//     return DashedDivider(
//       color: context.colors.outline,
//       strokeWidth: context.spacing.strokeThin,
//     );
//   }
//
//   // 底部按钮和协议信息
//   Widget _buildBottomButtons(
//     BuildContext context,
//     WidgetRef ref, {
//     required AsyncValue<List<SubscriptionPackage>> subscriptionState,
//     required ValueNotifier<SubscriptionPackage?> selectedPackageState,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(left: 12, right: 12, top: 6),
//       child: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: FilledButton(
//               onPressed: selectedPackageState.value != null
//                   ? () {
//                       _handlePurchase(context, ref, selectedPackageState: selectedPackageState);
//                     }
//                   : null,
//               child: Text('立即订阅'.tr()),
//             ),
//           ),
//           SizedBox(height: 12),
//           Center(
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     LaunchUrl.handleLink(kWebsite + kSubscription, fail: () async {
//                       await Clipboard.setData(ClipboardData(text: kWebsite + kSubscription));
//                       CommonUtil.showToast('已复制'.tr());
//                     });
//                   },
//                   child: Text(
//                     '会员服务协议'.tr(),
//                     style: context.textStyle.labelMedium,
//                   ),
//                 ),
//                 Container(
//                   width: 1,
//                   height: 10,
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   color: context.colors.outline,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     LaunchUrl.handleLink(kWebsite + kTerms, fail: () async {
//                       await Clipboard.setData(ClipboardData(text: kWebsite + kTerms));
//                       CommonUtil.showToast('已复制'.tr());
//                     });
//                   },
//                   child: Text(
//                     '服务协议'.tr(),
//                     style: context.textStyle.labelMedium,
//                   ),
//                 ),
//                 Container(
//                   width: 1,
//                   height: 10,
//                   margin: EdgeInsets.symmetric(horizontal: 8),
//                   color: context.colors.outline,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _handleRestorePurchases(context, ref, selectedPackageState: selectedPackageState);
//                   },
//                   child: Text(
//                     '恢复购买'.tr(),
//                     style: context.textStyle.labelMedium,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   /// 显示详细说明弹窗
//   void showDetailed(BuildContext context) {
//     ActionDialog(
//       title: '详细说明'.tr(),
//       contentAlign: TextAlign.left,
//       content:
//           'Apple的限时优惠价格会受到多种因素影响。请确保当前App Store所使用的Apple ID与应用内支付的Apple ID一致。\n若两者不一致，可能会出现实际支付价格与应用内显示价格不同的情况。\n最终价格以Apple实际扣费金额为准，所有交易均遵循苹果的支付规则。\n\n在点击恢复购买之前因确认之前应用内支付的Apple ID是否是当前App Store所使用的Apple ID是否一致，如有不一致则恢复失败。'
//               .tr(),
//       mainButtonText: '知道了'.tr(),
//     ).show(context);
//   }
// }
