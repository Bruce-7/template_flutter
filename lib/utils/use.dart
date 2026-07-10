import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// 文本快速输入防抖。默认300毫秒。
ValueNotifier<String> useDebouncedTextController(
  TextEditingController controller, {
  Duration duration = const Duration(milliseconds: 300),
}) {
  final debouncedValue = useState(controller.text);

  useEffect(() {
    Timer? timer;

    void listener() {
      timer?.cancel();
      timer = Timer(duration, () {
        debouncedValue.value = controller.text;
      });
    }

    controller.addListener(listener);
    return () {
      timer?.cancel();
      controller.removeListener(listener);
    };
  }, [controller]);

  return debouncedValue;
}
