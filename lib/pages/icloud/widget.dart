// part of 'page.dart';
//
// extension ICloudPageWidget on ICloudPage {
//   /// 构建主体内容
//   Widget _buildBody(
//     BuildContext context,
//     WidgetRef ref, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) {
//     return ListView(
//       padding: const EdgeInsets.all(12),
//       children: [
//         _buildInfoCard(context),
//         const SizedBox(height: 24),
//         _buildUploadButton(context, iCloudStorage: iCloudStorage, userState: userState),
//         const SizedBox(height: 16),
//         _buildDownloadButton(context, ref, iCloudStorage: iCloudStorage, userState: userState),
//         const SizedBox(height: 16),
//         _buildDeleteButton(context, iCloudStorage: iCloudStorage, userState: userState),
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
//                 Icons.cloud_outlined,
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
//             '• 上传到iCloud：将所有资产数据、礼记数据和图片打包上传到iCloud云端备份，需手动上传同步，未开启自动同步。'.tr(),
//             style: context.textStyle.bodyMedium,
//           ),
//           Text(
//             '• 如果您的iCloud空间不足，请您使用导出导入备份。'.tr(),
//             style: context.textStyle.bodyMedium,
//           ),
//           Text(
//             '• 不开通会员也可以通过电脑备份应用。'.tr(),
//             style: context.textStyle.bodyMedium,
//           ),
//           Text(
//             '• 从iCloud恢复：从iCloud云端下载备份数据并恢复，重复的数据会自动合并更新（以iCloud云端备份数据为最新替换当前数据）。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//           Text(
//             '• 上传到iCloud，从iCloud恢复过程中请勿退出。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//           Text(
//             '• 恢复数据不会主动刷新资产和礼记列表，需手动下拉刷新。'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//           Text(
//             '• 删除iCloud备份：删除iCloud云端的所有备份数据。谨慎操作！'.tr(),
//             style: context.textStyle.bodyMedium.copyWith(
//               color: context.colors.error,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 构建上传按钮
//   Widget _buildUploadButton(
//     BuildContext context, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: FilledButton.icon(
//         onPressed: () => _uploadToICloud(context, iCloudStorage: iCloudStorage, userState: userState),
//         icon: const Icon(Icons.cloud_upload_outlined),
//         label: Text('上传到iCloud'.tr()),
//       ),
//     );
//   }
//
//   /// 构建下载按钮
//   Widget _buildDownloadButton(
//     BuildContext context,
//     WidgetRef ref, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         onPressed: () => _downloadFromICloud(context, ref, iCloudStorage: iCloudStorage, userState: userState),
//         icon: const Icon(Icons.cloud_download_outlined),
//         label: Text('从iCloud恢复'.tr()),
//       ),
//     );
//   }
//
//   /// 构建删除按钮
//   Widget _buildDeleteButton(
//     BuildContext context, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton.icon(
//         onPressed: () => _deleteFromICloud(context, iCloudStorage: iCloudStorage, userState: userState),
//         icon: Icon(
//           Icons.delete_outline,
//           color: context.colors.error,
//         ),
//         label: Text(
//           '删除iCloud备份'.tr(),
//           style: TextStyle(color: context.colors.error),
//         ),
//         style: OutlinedButton.styleFrom(
//           side: BorderSide(
//             color: context.colors.error,
//           ),
//           overlayColor: context.colors.error.withValues(alpha: 0.1),
//         ),
//       ),
//     );
//   }
// }
