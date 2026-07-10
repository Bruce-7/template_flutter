import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  final Color borderColor;
  final Color maskColor;
  final Color maskDownColor;

  const CircleEditorCropLayerPainter({
    required this.borderColor,
    required this.maskColor,
    required this.maskDownColor,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
    ExtendedImageCropLayerPainter painter,
    Rect rect,
  ) {
    final rect = painter.cropRect;
    final path = Path()..addOval(rect);

    // 绘制外部暗色遮罩
    final overlay = Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      path,
    );

    // 遮罩颜色
    canvas.saveLayer(Rect.largest, Paint());
    canvas.drawPath(
      overlay,
      Paint()..color = painter.pointerDown == true ? maskDownColor : maskColor,
    );
    canvas.restore();

    // 绘制圆形边框
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawOval(rect, borderPaint);
  }
}
