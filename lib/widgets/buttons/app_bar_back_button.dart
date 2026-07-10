import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '返回'.tr(),
      child: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
