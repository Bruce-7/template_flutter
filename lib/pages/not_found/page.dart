import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/managers/logger.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'function.dart';

part 'widget.dart';

@RoutePage()
class NotFoundPage extends HookConsumerWidget {
  const NotFoundPage({super.key});

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
        title: Text('页面未找到'.tr()),
      ),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.colors.error,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  '您访问的页面不存在'.tr(),
                  style: context.textStyle.bodyMedium,
                ),
                const SizedBox(height: 30),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('返回上一页'.tr()),
                ),
                SizedBox(height: CommonUtil.bottomViewPadding(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
