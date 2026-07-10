// part of 'page.dart';
//
// extension ICloudPageFunction on ICloudPage {
//   /// 上传到iCloud
//   Future<void> _uploadToICloud(
//     BuildContext context, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) async {
//     if (!userState.hasValue || userState.value?.isPremiumActive() != true) {
//       showPremiumActiveDialog(
//         context,
//         content: '这是会员专享功能，开通会员即可无限畅享。'.tr(),
//       );
//       return;
//     }
//
//     try {
//       CommonUtil.showLoading(msg: '正在上传到iCloud'.tr());
//
//       // 创建备份ZIP文件
//       final zipFilePath = await BackupUtil.createBackupZip();
//       final zipFileName = zipFilePath.split('/').last;
//
//       // 上传到iCloud
//       await iCloudStorage.value.upload(
//         containerId: kICloudContainerId,
//         filePath: zipFilePath,
//         destinationRelativePath: zipFileName,
//         onProgress: (progressStream) {
//           progressStream.listen((progress) {
//             log.d('上传进度: $progress%');
//           });
//         },
//       );
//
//       // 删除临时zip文件
//       final zipFile = File(zipFilePath);
//       if (await zipFile.exists()) {
//         await zipFile.delete();
//       }
//
//       CommonUtil.dismiss();
//       CommonUtil.showToast('上传成功'.tr());
//     } catch (e) {
//       CommonUtil.dismiss();
//       log.e('上传到iCloud失败: $e');
//       CommonUtil.showToast('上传失败'.tr());
//     }
//   }
//
//   /// 从iCloud恢复
//   Future<void> _downloadFromICloud(
//     BuildContext context,
//     WidgetRef ref, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) async {
//     if (!userState.hasValue || userState.value?.isPremiumActive() != true) {
//       showPremiumActiveDialog(
//         context,
//         content: '这是会员专享功能，开通会员即可无限畅享。'.tr(),
//       );
//       return;
//     }
//
//     try {
//       CommonUtil.showLoading(msg: '正在获取iCloud文件列表'.tr());
//
//       // 获取iCloud文件列表
//       final cloudFiles = await iCloudStorage.value.getCloudFiles(
//         containerId: kICloudContainerId,
//       );
//
//       CommonUtil.dismiss();
//
//       if (cloudFiles.isEmpty) {
//         CommonUtil.showToast('iCloud中没有备份文件'.tr());
//         return;
//       }
//
//       // 过滤出备份文件
//       final backupFiles = cloudFiles.where((file) {
//         return file.relativePath?.startsWith('app_backup_') == true && file.relativePath?.endsWith('.zip') == true;
//       }).toList();
//
//       if (backupFiles.isEmpty) {
//         CommonUtil.showToast('iCloud中没有备份文件'.tr());
//         return;
//       }
//
//       // 按文件名排序，最新的在前面
//       backupFiles.sort((a, b) => (b.relativePath ?? '').compareTo(a.relativePath ?? ''));
//
//       // 显示文件选择对话框
//       if (!context.mounted) return;
//
//       final selectedFile = await _showFileSelectionDialog(context, backupFiles);
//       if (selectedFile == null) return;
//
//       CommonUtil.showLoading(msg: '正在从iCloud恢复'.tr());
//
//       final tempDir = await getTemporaryDirectory();
//       final downloadPath = '${tempDir.path}/${selectedFile.relativePath}';
//
//       // 下载文件
//       await iCloudStorage.value.download(
//         containerId: kICloudContainerId,
//         relativePath: selectedFile.relativePath!,
//         destinationFilePath: downloadPath,
//         onProgress: (progressStream) {
//           progressStream.listen((progress) {
//             log.d('下载进度: $progress%');
//           });
//         },
//       );
//
//       // 解压并导入数据
//       await _extractAndImportData(downloadPath);
//
//       // 删除临时下载文件
//       final downloadFile = File(downloadPath);
//       if (await downloadFile.exists()) {
//         await downloadFile.delete();
//       }
//
//       CommonUtil.dismiss();
//       CommonUtil.showToast('恢复成功'.tr());
//     } catch (e) {
//       CommonUtil.dismiss();
//       log.e('从iCloud恢复失败: $e');
//       CommonUtil.showToast('恢复失败'.tr());
//     }
//   }
//
//   /// 删除iCloud备份
//   Future<void> _deleteFromICloud(
//     BuildContext context, {
//     required ObjectRef<IcloudStorageSync> iCloudStorage,
//     required AsyncValue<User> userState,
//   }) async {
//     if (!userState.hasValue || userState.value?.isPremiumActive() != true) {
//       showPremiumActiveDialog(
//         context,
//         content: '这是会员专享功能，开通会员即可无限畅享。'.tr(),
//       );
//       return;
//     }
//
//     try {
//       CommonUtil.showLoading(msg: '正在获取iCloud文件列表'.tr());
//
//       // 获取iCloud文件列表
//       final cloudFiles = await iCloudStorage.value.getCloudFiles(
//         containerId: kICloudContainerId,
//       );
//
//       CommonUtil.dismiss();
//
//       if (cloudFiles.isEmpty) {
//         CommonUtil.showToast('iCloud中没有备份文件'.tr());
//         return;
//       }
//
//       // 过滤出备份文件
//       final backupFiles = cloudFiles.where((file) {
//         return file.relativePath?.startsWith('app_backup_') == true && file.relativePath?.endsWith('.zip') == true;
//       }).toList();
//
//       if (backupFiles.isEmpty) {
//         CommonUtil.showToast('iCloud中没有备份文件'.tr());
//         return;
//       }
//
//       // 显示确认对话框
//       if (!context.mounted) return;
//       final confirmed = await _showDeleteConfirmDialog(context, backupFiles.length);
//       if (confirmed != true) return;
//
//       CommonUtil.showLoading(msg: '正在删除iCloud备份'.tr());
//
//       // 删除所有备份文件
//       for (final file in backupFiles) {
//         if (file.relativePath != null) {
//           await iCloudStorage.value.delete(
//             containerId: kICloudContainerId,
//             relativePath: file.relativePath!,
//             isDirectory: false,
//           );
//         }
//       }
//
//       CommonUtil.dismiss();
//       CommonUtil.showToast('删除成功'.tr());
//     } catch (e) {
//       CommonUtil.dismiss();
//       log.e('删除iCloud备份失败: $e');
//       CommonUtil.showToast('删除失败'.tr());
//     }
//   }
//
//   /// 显示文件选择对话框
//   Future<CloudFiles?> _showFileSelectionDialog(
//     BuildContext context,
//     List<CloudFiles> files,
//   ) async {
//     return ActionDialog(
//       isDismissible: true,
//       showCloseButton: true,
//       style: ActionDialogStyle.sheet,
//       showViewPaddingBottom: true,
//       title: '选择要恢复的备份'.tr(),
//       contentWidget: Flexible(
//         child: ListView.builder(
//           shrinkWrap: true,
//           padding: EdgeInsets.zero,
//           itemCount: files.length,
//           itemBuilder: (context, index) {
//             final file = files[index];
//             final fileName = file.relativePath ?? '';
//             return ListTile(
//               // contentPadding: EdgeInsets.zero,
//               leading: Icon(
//                 Icons.cloud_outlined,
//                 color: context.colors.primary,
//               ),
//               title: Text(fileName),
//               subtitle: file.lastSyncDt != null ? Text(DateFormatUtil.yMDHMS(file.lastSyncDt!)) : null,
//               onTap: () => Navigator.of(context).pop(file),
//             );
//           },
//         ),
//       ),
//     ).show<CloudFiles?>(context);
//   }
//
//   /// 显示删除确认对话框
//   Future<bool?> _showDeleteConfirmDialog(BuildContext context, int fileCount) async {
//     return ActionDialog(
//       title: '确认删除'.tr(),
//       content: '确定要删除iCloud中的 {} 个备份文件吗？此操作不可恢复。'.tr(args: ['$fileCount']),
//       contentAlign: TextAlign.left,
//       mainButtonText: '删除'.tr(),
//       mainButtonAction: (_) {
//         Navigator.of(context).pop(true);
//       },
//       subButtonText: '取消'.tr(),
//     ).show<bool?>(context);
//   }
//
//   /// 解压并导入数据
//   Future<void> _extractAndImportData(String zipFilePath) async {
//     // 使用BackupUtil完成导入流程
//     await BackupUtil.importFromZip(zipFilePath);
//   }
// }
