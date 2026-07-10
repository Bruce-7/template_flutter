// part of 'page.dart';
//
// extension ExportImportPageFunction on ExportImportPage {
//   /// 导出数据
//   Future<void> _exportData(
//     BuildContext context, {
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
//       CommonUtil.showLoading(msg: '导出中'.tr());
//
//       // 创建备份ZIP文件
//       final zipFilePath = await BackupUtil.createBackupZip();
//
//       CommonUtil.dismiss();
//
//       // 分享zip文件
//       await SharePlus.instance.share(
//         ShareParams(files: [XFile(zipFilePath)]),
//       );
//
//       // 分享完成后删除临时zip文件
//       final zipFile = File(zipFilePath);
//       if (await zipFile.exists()) {
//         await zipFile.delete();
//       }
//     } catch (e) {
//       CommonUtil.dismiss();
//       log.e('导出失败: $e');
//       CommonUtil.showToast('导出失败'.tr());
//     }
//   }
//
//   /// 导入数据
//   Future<void> _importData(
//     BuildContext context,
//     WidgetRef ref, {
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
//       // 选择zip文件
//       final result = await FilePicker.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['zip'],
//         allowMultiple: false,
//       );
//
//       if (result == null || result.files.isEmpty) {
//         return;
//       }
//
//       final pickedFile = result.files.first;
//       if (pickedFile.path == null) {
//         CommonUtil.showToast('文件路径无效'.tr());
//         return;
//       }
//
//       CommonUtil.showLoading(msg: '导入中'.tr());
//
//       // 使用BackupUtil完成导入流程
//       await BackupUtil.importFromZip(pickedFile.path!);
//
//       CommonUtil.dismiss();
//       CommonUtil.showToast('导入成功'.tr());
//     } catch (e) {
//       CommonUtil.dismiss();
//       log.e('导入失败: $e');
//       CommonUtil.showToast('导入失败'.tr());
//     }
//   }
// }
