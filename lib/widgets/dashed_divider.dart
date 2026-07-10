import 'package:flutter/material.dart';

/// 虚线分隔线组件
class DashedDivider extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double height;

  const DashedDivider({
    super.key,
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _DashedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
    );
  }
}

/// 虚线绘制器
class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
