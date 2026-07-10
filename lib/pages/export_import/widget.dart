// part of 'page.dart';
//
// extension ExportImportPageWidget on ExportImportPage {
//   /// 构建主体内容
//   Widget _buildBody(
//     BuildContext context,
//     WidgetRef ref, {
//     required AsyncValue<User> userState,
//   }) {
//     return ListView(
//       padding: const EdgeInsets.all(12),
//       children: [
//         _buildInfoCard(context),
//         const SizedBox(height: 24),
//         _buildExportButton(context, userState: userState),
//         const SizedBox(height: 16),
//         _buildImportButton(context, ref, userState: userState),
//         SizedBox(height: CommonUtil.bottomViewPadding(context)),
//       ],
//     );
//   }
//
//   /// 构建信息卡片
//   Widget _buildInfoCard(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: context.colors.surfaceContainerLow,
//         borderRadius: BorderRadius.circular(context.radius.md),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 8,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.info_outline,
//                 color: context.colors.primary,
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '使用说明'.tr(),
//                 style: context.textStyle.titleMedium.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             '• 导出：将所有资产数据、礼记数据和图片打包成ZIP文件，可以保存到系统文件方便下次导入，也可以保存到其他设备或云端备份。'.tr(),
//             style: context.textStyle.bodyMedium,
//           ),
//           Text(
//             '• 导入：从备份的ZIP文件中恢复数据，重复的数据会自动合并更新（以ZIP备份数据为最新替换当前数据）。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//           Text(
//             '• 导出导入过程中请勿退出。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//           Text(
//             '• 导入数据不会主动刷新资产和礼记列表，需手动下拉刷新。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 构建导出按钮
//   Widget _buildExportButton(
//     BuildContext context, {
//     required AsyncValue<User> userState,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: FilledButton.icon(
//         onPressed: () => _exportData(context, userState: userState),
//         icon: const Icon(Icons.upload_outlined),
//         label: Text('导出数据'.tr()),
//       ),
//     );
//   }
//
//   /// 构建导入按钮
//   Widget _buildImportButton(
//     BuildContext context,
//     WidgetRef ref, {
//     required AsyncValue<User> userState,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         onPressed: () => _importData(context, ref, userState: userState),
//         icon: const Icon(Icons.download_outlined),
//         label: Text('导入数据'.tr()),
//       ),
//     );
//   }
// }
