// import 'dart:io';
//
// import 'package:auto_route/annotations.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app/constants/keys.dart';
// import 'package:flutter_app/managers/logger.dart';
// import 'package:flutter_app/models/user.dart';
// import 'package:flutter_app/providers/user_state.dart';
// import 'package:flutter_app/theme/app_theme_extension.dart';
// import 'package:flutter_app/utils/backup.dart';
// import 'package:flutter_app/utils/common.dart';
// import 'package:flutter_app/utils/date_format.dart';
// import 'package:flutter_app/widgets/common.dart';
// import 'package:flutter_app/widgets/dialog/action_dialog.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:icloud_storage_sync/icloud_storage_sync.dart';
// import 'package:icloud_storage_sync/models/icloud_file_download.dart';
// import 'package:path_provider/path_provider.dart';
//
// part 'function.dart';
//
// part 'widget.dart';
//
// @RoutePage()
// class ICloudPage extends HookConsumerWidget {
//   const ICloudPage({super.key});
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
//     /// 获取 iCloud 插件实例;
//     final iCloudStorage = useRef(IcloudStorageSync());
//     final userState = ref.watch(userStateProvider());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('iCloud 云同步'.tr()),
//       ),
//       body: SafeArea(
//         bottom: false,
//         child: _buildBody(context, ref, iCloudStorage: iCloudStorage, userState: userState),
//       ),
//     );
//   }
// }
