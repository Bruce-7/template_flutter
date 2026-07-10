import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/extension/date_extension.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 时间计时器组件
class DateTimer extends HookConsumerWidget {
  final DateTime? dateTime;
  final TextStyle? style;

  const DateTimer({
    super.key,
    this.dateTime,
    this.style,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = dateTime ?? DateTime.now();
    final dateState = useState(time.formatDateWeekdayHmsLocalized());

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final tempTime = dateTime ?? DateTime.now();
        dateState.value = tempTime.formatDateWeekdayHmsLocalized();
      });
      return timer.cancel;
    }, const []);

    return Text(
      dateState.value,
      style: style ?? context.textStyle.labelMedium,
    );
  }
}
