// import 'dart:io';
//
// import 'package:auto_route/annotations.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/models/user.dart';
// import 'package:flutter_app/providers/user_state.dart';
// import 'package:flutter_app/theme/app_theme_extension.dart';
// import 'package:flutter_app/utils/backup.dart';
// import 'package:flutter_app/utils/common.dart';
// import 'package:flutter_app/widgets/common.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:share_plus/share_plus.dart';
//
// part 'function.dart';
//
// part 'widget.dart';
//
// @RoutePage()
// class ExportImportPage extends HookConsumerWidget {
//   const ExportImportPage({super.key});
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
//     final userState = ref.watch(userStateProvider());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('导出导入备份'.tr()),
//       ),
//       body: SafeArea(
//         bottom: false,
//         child: _buildBody(context, ref, userState: userState),
//       ),
//     );
//   }
// }
