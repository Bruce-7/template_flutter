import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'widget.dart';

// pages目录下template目录下的所有文件是模板代码，仅供拷贝快速使用。
@RoutePage()
class TemplatePage extends HookConsumerWidget {
  const TemplatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log.d('$this init');
      return () {
        log.d('$this dispose');
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        // titleSpacing: 12,
        // centerTitle: false,
        title: Text('测试页面'.tr()),
      ),
      body: const SafeArea(
        bottom: false,
        child: SizedBox(),
      ),
    );
  }
}
