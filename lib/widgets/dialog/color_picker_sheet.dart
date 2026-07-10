import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/extension/color.dart';
import 'package:flutter_app/extension/string.dart';
import 'package:flutter_app/theme/app_theme_extension.dart';
import 'package:flutter_app/widgets/dialog/action_dialog.dart';
import 'package:flutter_app/widgets/dismiss_keyboard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorPickerSheet extends HookConsumerWidget {
  final Color? initialColor;
  final String title;

  const ColorPickerSheet({
    super.key,
    this.initialColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColorState = useState(initialColor ?? context.colors.primary);
    final showAdvancedState = useState(false);
    final hexController = useTextEditingController();

    final presetColorsRef = useRef([
      const Color(0xFFEF5350), // Red
      const Color(0xFFEC407A), // Pink
      const Color(0xFFAB47BC), // Purple
      const Color(0xFF7E57C2), // Deep Purple
      const Color(0xFF5C6BC0), // Indigo
      const Color(0xFF42A5F5), // Blue
      const Color(0xFF29B6F6), // Light Blue
      const Color(0xFF26C6DA), // Cyan
      const Color(0xFF26A69A), // Teal
      const Color(0xFF66BB6A), // Green
      const Color(0xFF9CCC65), // Light Green
      const Color(0xFFD4E157), // Lime
      const Color(0xFFFFEE58), // Yellow
      const Color(0xFFFFCA28), // Amber
      const Color(0xFFFFA726), // Orange
      const Color(0xFFFF7043), // Deep Orange
      const Color(0xFFE57373), // Light Red
      const Color(0xFF8D6E63), // Brown
      const Color(0xFFBDBDBD), // Grey
      const Color(0xFF78909C), // Blue Grey
      const Color(0xFF424242), // Dark Grey
    ]);

    useEffect(() {
      hexController.text = selectedColorState.value.colorToHexString(leadingHashSign: false);
      return null;
    }, [selectedColorState.value]);

    return DismissKeyboard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.spacing.sm),
                  // 标题栏
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.spacing.sm),
                        decoration: BoxDecoration(
                          color: context.colors.primaryContainer,
                          borderRadius: context.radius.radiusSM,
                        ),
                        child: Icon(
                          Icons.colorize_rounded,
                          size: 20,
                          color: context.colors.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(width: context.spacing.sm),
                      Expanded(
                        child: Text(
                          title,
                          style: context.textStyle.titleLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacing.md),

                  // 色板预览
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: selectedColorState.value,
                      borderRadius: context.radius.radiusMD,
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacing.md,
                          vertical: context.spacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.scrim,
                          borderRadius: context.radius.radiusMD,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              selectedColorState.value.colorToHexString(),
                              style: context.textStyle.titleMedium.copyWith(
                                color: context.colors.onScrim,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Alpha: ${(selectedColorState.value.a * 100).toInt()}%',
                              style: context.textStyle.bodySmall.copyWith(
                                color: context.colors.onScrim,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.spacing.lg),

                  // 自定义颜色输入栏
                  TextField(
                    controller: hexController,
                    decoration: InputDecoration(
                      labelText: '颜色值 (8位)'.tr(),
                      prefixIcon: Icon(Icons.tag_rounded),
                      hintText: 'AARRGGBB'.tr(),
                      helperText: '8位格式: 透明度+RGB'.tr(),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      FilteringTextInputFormatter.deny(RegExp(r'[^0-9A-Fa-f]')),
                    ],
                    onChanged: (hex) {
                      _updateColorFromHex(context, ref, hex: hex, selectedColorState: selectedColorState);
                    },
                  ),
                  SizedBox(height: context.spacing.md),

                  // 透明度信息
                  Row(
                    children: [
                      Icon(Icons.opacity_rounded, size: 18, color: context.colors.primary),
                      SizedBox(width: context.spacing.xs),
                      Text('透明度'.tr(), style: context.textStyle.titleSmall.copyWith(fontWeight: FontWeight.w600)),
                      Spacer(),
                      Text('${(selectedColorState.value.a * 100).toInt()}%', style: context.textStyle.bodyMedium),
                    ],
                  ),
                  SizedBox(height: context.spacing.xs),

                  // 透明度滑块
                  Slider(
                    value: selectedColorState.value.a,
                    onChanged: (value) {
                      _updateColorFromHSV(
                        context,
                        ref,
                        hsv: HSVColor.fromColor(selectedColorState.value).withAlpha(value),
                        selectedColorState: selectedColorState,
                      );
                    },
                  ),
                  SizedBox(height: context.spacing.xs),

                  TextButton.icon(
                    onPressed: () => showAdvancedState.value = !showAdvancedState.value,
                    icon: Icon(showAdvancedState.value ? Icons.expand_less : Icons.expand_more),
                    label: Text(showAdvancedState.value ? '隐藏高级选项'.tr() : '显示高级选项'.tr()),
                  ),

                  if (showAdvancedState.value) ...[
                    SizedBox(height: context.spacing.md),
                    _ColorPicker(
                      hsvColor: HSVColor.fromColor(selectedColorState.value),
                      onColorChanged: (hsv) {
                        _updateColorFromHSV(context, ref, hsv: hsv, selectedColorState: selectedColorState);
                      },
                    ),
                  ],
                  SizedBox(height: context.spacing.lg),

                  // 预设颜色
                  Row(
                    children: [
                      Icon(
                        Icons.palette_rounded,
                        size: 18,
                        color: context.colors.primary,
                      ),
                      SizedBox(width: context.spacing.xs),
                      Text(
                        '预设颜色'.tr(),
                        style: context.textStyle.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.spacing.md),
                  Container(
                    padding: EdgeInsets.all(context.spacing.sm),
                    decoration: BoxDecoration(
                      color: context.colors.surfaceContainer,
                      borderRadius: context.radius.radiusMD,
                    ),
                    child: MasonryGridView.count(
                      crossAxisCount: 7,
                      padding: EdgeInsets.zero,
                      mainAxisSpacing: context.spacing.xs,
                      crossAxisSpacing: context.spacing.xs,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: presetColorsRef.value.length,
                      itemBuilder: (context, index) {
                        final color = presetColorsRef.value[index];
                        final isSelected =
                            (selectedColorState.value.r - color.r).abs() < 0.01 && (selectedColorState.value.g - color.g).abs() < 0.01 && (selectedColorState.value.b - color.b).abs() < 0.01;

                        return InkWell(
                          onTap: () {
                            selectedColorState.value = color.withValues(alpha: selectedColorState.value.a);
                          },
                          borderRadius: context.radius.radiusSM,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: context.radius.radiusSM,
                              border: Border.all(
                                color: isSelected ? context.colors.primary : context.colors.outline,
                                width: isSelected ? context.spacing.strokeMedium : context.spacing.strokeThin,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check_rounded,
                                    color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                                    size: 24,
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.spacing.xl),
                ],
              ),
            ),
          ),

          // 底部按钮区域
          SizedBox(height: context.spacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('取消'.tr()),
                ),
              ),
              SizedBox(width: context.spacing.md),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, selectedColorState.value),
                  child: Text('确定'.tr()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension ColorPickerSheetFunction on ColorPickerSheet {
  Future<Color?> show(BuildContext context) async {
    return await ActionDialog(
      isDismissible: true,
      showCloseButton: true,
      style: ActionDialogStyle.sheet,
      showViewPaddingBottom: true,
      contentWidget: Flexible(child: this),
    ).show<Color?>(context);
  }

  void _updateColorFromHex(
    BuildContext context,
    WidgetRef ref, {
    required String hex,
    required ValueNotifier<Color> selectedColorState,
  }) {
    // 只在输入完整的8位十六进制值时才更新颜色
    if (hex.length != 8) {
      return;
    }

    try {
      final newColor = hex.toColor();
      selectedColorState.value = newColor;
    } catch (e) {
      // 忽略无效输入
    }
  }

  void _updateColorFromHSV(
    BuildContext context,
    WidgetRef ref, {
    required HSVColor hsv,
    required ValueNotifier<Color> selectedColorState,
  }) {
    selectedColorState.value = hsv.toColor();
  }
}

class _ColorPicker extends StatelessWidget {
  final HSVColor hsvColor;
  final ValueChanged<HSVColor> onColorChanged;

  const _ColorPicker({
    required this.hsvColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sliderThemeData = SliderThemeData(
      trackHeight: 24,
      trackShape: RoundedRectSliderTrackShape(),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
      activeTrackColor: context.colors.transparent,
      inactiveTrackColor: context.colors.transparent,
    );

    return Column(
      children: [
        // 色相选择器
        Row(
          children: [
            Icon(Icons.gradient_rounded, size: 18, color: context.colors.primary),
            SizedBox(width: context.spacing.xs),
            Text('色相'.tr(), style: context.textStyle.titleSmall.copyWith(fontWeight: FontWeight.w600)),
            Spacer(),
            Text('${(hsvColor.hue).toInt()}°', style: context.textStyle.bodyMedium),
          ],
        ),
        SizedBox(height: context.spacing.sm),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 24,
              margin: EdgeInsets.symmetric(horizontal: 20), // Slider的计算下面的overlayRadius导致的左右间距
              decoration: BoxDecoration(
                borderRadius: context.radius.radiusMD,
                gradient: LinearGradient(
                  colors: [
                    HSVColor.fromAHSV(1, 0, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 60, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 120, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 180, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 240, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 300, 1, 1).toColor(),
                    HSVColor.fromAHSV(1, 360, 1, 1).toColor(),
                  ],
                ),
              ),
            ),
            SliderTheme(
              data: sliderThemeData,
              child: Slider(
                value: hsvColor.hue.clamp(0.0, 359.0),
                min: 0,
                max: 359,
                onChanged: (value) {
                  onColorChanged(hsvColor.withHue(value));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing.md),

        // 饱和度选择器
        Row(
          children: [
            Icon(Icons.water_drop_rounded, size: 18, color: context.colors.primary),
            SizedBox(width: context.spacing.xs),
            Text('饱和度'.tr(), style: context.textStyle.titleSmall.copyWith(fontWeight: FontWeight.w600)),
            Spacer(),
            Text('${(hsvColor.saturation * 100).toInt()}%', style: context.textStyle.bodyMedium),
          ],
        ),
        SizedBox(height: context.spacing.sm),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 24,
              margin: EdgeInsets.symmetric(horizontal: 20), // Slider的计算下面的overlayRadius导致的左右间距
              decoration: BoxDecoration(
                borderRadius: context.radius.radiusMD,
                gradient: LinearGradient(
                  colors: [
                    HSVColor.fromAHSV(1, hsvColor.hue, 0, hsvColor.value).toColor(),
                    HSVColor.fromAHSV(1, hsvColor.hue, 1, hsvColor.value).toColor(),
                  ],
                ),
              ),
            ),
            SliderTheme(
              data: sliderThemeData,
              child: Slider(
                value: hsvColor.saturation,
                onChanged: (value) {
                  onColorChanged(hsvColor.withSaturation(value));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: context.spacing.md),

        // 明度选择器
        Row(
          children: [
            Icon(Icons.brightness_6_rounded, size: 18, color: context.colors.primary),
            SizedBox(width: context.spacing.xs),
            Text('明度'.tr(), style: context.textStyle.titleSmall.copyWith(fontWeight: FontWeight.w600)),
            Spacer(),
            Text('${(hsvColor.value * 100).toInt()}%', style: context.textStyle.bodyMedium),
          ],
        ),
        SizedBox(height: context.spacing.sm),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 24,
              margin: EdgeInsets.symmetric(horizontal: 20), // Slider的计算下面的overlayRadius导致的左右间距
              decoration: BoxDecoration(
                borderRadius: context.radius.radiusMD,
                gradient: LinearGradient(
                  colors: [
                    HSVColor.fromAHSV(1, hsvColor.hue, hsvColor.saturation, 0).toColor(),
                    HSVColor.fromAHSV(1, hsvColor.hue, hsvColor.saturation, 1).toColor(),
                  ],
                ),
              ),
            ),
            SliderTheme(
              data: sliderThemeData,
              child: Slider(
                value: hsvColor.value,
                onChanged: (value) {
                  onColorChanged(hsvColor.withValue(value));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
