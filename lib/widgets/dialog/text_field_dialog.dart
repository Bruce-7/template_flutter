import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/widgets/common.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextFieldDialog extends HookConsumerWidget {
  final String title;
  final String? hintText;
  final String? initialValue;
  final int? maxLength;
  final Function(String text)? onConfirmClick;

  const TextFieldDialog({
    super.key,
    required this.title,
    this.hintText,
    this.initialValue,
    this.maxLength,
    this.onConfirmClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: initialValue);
    final focusNode = useFocusNode();
    final confirmButtonEnabledState = useState(initialValue?.trim().isNotEmpty ?? false);

    // 监听文本变化
    useEffect(() {
      void listener() {
        final length = textController.text.trim().length;
        confirmButtonEnabledState.value = length > 0 && (maxLength != null ? length <= maxLength! : true);
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    return Column(
      children: [
        TextFormField(
          controller: textController,
          focusNode: focusNode,
          autofocus: true,
          maxLength: maxLength,
          buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
          style: context.textStyle.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            suffix: maxLength == null ? null : fieldCustomCounterSuffix(textController, maxLength!),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (maxLength != null && value != null && value.length > maxLength!) {
              return '超出最大长度'.tr();
            }

            return null;
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: confirmButtonEnabledState.value
                ? () {
                    if (onConfirmClick != null) {
                      onConfirmClick!(textController.text);
                    } else {
                      Navigator.pop(context, textController.text);
                    }
                  }
                : null,
            child: Text('确定'.tr()),
          ),
        ),
      ],
    );
  }
}

extension TextFieldDialogFunction on TextFieldDialog {
  Future<String?> show(BuildContext context) async {
    return await ActionDialog(
      isDismissible: true,
      showCloseButton: true,
      style: ActionDialogStyle.sheet,
      title: title,
      contentWidget: this,
      showViewInsetsBottom: true,
    ).show(context);
  }
}
