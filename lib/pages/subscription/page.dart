// import 'package:auto_route/annotations.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_app/constants/keys.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/managers/purchases.dart';
// import 'package:flutter_app/models/subscription_offer_info.dart';
// import 'package:flutter_app/models/user.dart';
// import 'package:flutter_app/providers/subscription_state.dart';
// import 'package:flutter_app/providers/user_state.dart';
// import 'package:flutter_app/theme/app_theme_extension.dart';
// import 'package:flutter_app/utils/common.dart';
// import 'package:flutter_app/utils/date_format.dart';
// import 'package:flutter_app/utils/launch_url.dart';
// import 'package:flutter_app/widgets/card_container.dart';
// import 'package:flutter_app/widgets/dashed_divider.dart';
// import 'package:flutter_app/widgets/dialog/action_dialog.dart';
// import 'package:flutter_app/widgets/empty_placeholder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
//
// part 'function.dart';
//
// part 'widget.dart';
//
// @RoutePage()
// class SubscriptionPage extends HookConsumerWidget {
//   const SubscriptionPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     useEffect(() {
//       log.d('$this init');
//       return () {
//         log.d('$this dispose');
//       };
//     }, []);
//
//     final userState = ref.watch(userStateProvider(showToast: true));
//     final subscriptionState = ref.watch(subscriptionStateProvider);
//     final selectedPackageState = useState<SubscriptionPackage?>(null);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('订阅'.tr()),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.redeem),
//             onPressed: () async {
//               purchasesManager.presentCodeRedemptionSheet();
//             },
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             _buildSubscriptionInfo(context, ref, userState: userState),
//
//             // 订阅产品列表
//             subscriptionState.when(
//               data: (packages) {
//                 if (packages.isEmpty) {
//                   return CardContainer(
//                     margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     child: EmptyPlaceholder(
//                       message: '~ 暂无订阅信息 ~',
//                     ),
//                   );
//                 }
//
//                 return Align(
//                   alignment: Alignment.centerLeft,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     child: Row(
//                       children: [
//                         for (final package in packages) ...[
//                           _buildSubscriptionItem(
//                             context,
//                             ref,
//                             package: package,
//                             selectedPackageState: selectedPackageState,
//                           ),
//                           SizedBox(width: 12),
//                         ],
//                       ],
//                     ),
//                   ),
//                 );
//               },
//               error: (Object error, StackTrace stackTrace) {
//                 return CardContainer(
//                   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: EmptyPlaceholder(
//                     message: error.toString(),
//                     showButton: true,
//                     onButtonClick: () {},
//                   ),
//                 );
//               },
//               loading: () {
//                 return CardContainer(
//                   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 36),
//                   child: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               },
//             ),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: _buildSubscriptionBenefits(context, ref),
//               ),
//             ),
//
//             _buildBottomButtons(
//               context,
//               ref,
//               subscriptionState: subscriptionState,
//               selectedPackageState: selectedPackageState,
//             ),
//             SizedBox(height: CommonUtil.bottomViewPadding(context)),
//           ],
//         ),
//       ),
//     );
//   }
// }
