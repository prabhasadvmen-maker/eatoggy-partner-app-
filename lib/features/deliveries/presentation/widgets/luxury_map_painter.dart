import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LuxuryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Warm Ivory Background
    final bgPaint = Paint()
      ..color = const Color(0xFFF7F4EE);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final center = Offset(size.width * 0.5, size.height * 0.45);

    // Paints
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E0D6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final majorRoadPaint = Paint()
      ..color = const Color(0xFFD8D2C6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final brightRoutePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 2. Concentric Central City Squares
    for (double r = 24; r <= 180; r += 28) {
      final rect = Rect.fromCenter(center: center, width: r * 2, height: r * 2);
      canvas.drawRect(rect, gridPaint);
    }

    // 3. Radial Arterial Roads from Center
    final angles = [
      0.0,
      math.pi / 4,
      math.pi / 2,
      3 * math.pi / 4,
      math.pi,
      5 * math.pi / 4,
      3 * math.pi / 2,
      7 * math.pi / 4,
      math.pi / 6,
      5 * math.pi / 6,
      7 * math.pi / 6,
      11 * math.pi / 6,
      math.pi / 3,
      2 * math.pi / 3,
      4 * math.pi / 3,
      5 * math.pi / 3,
    ];

    for (final angle in angles) {
      final endX = center.dx + math.cos(angle) * 320;
      final endY = center.dy + math.sin(angle) * 320;
      canvas.drawLine(center, Offset(endX, endY), majorRoadPaint);
    }

    // 4. Subtle City Block Details
    _drawCityBlocks(canvas, center, gridPaint);

    // 5. Active Crimson Delivery Route Line
    final routePath = Path();
    routePath.moveTo(center.dx - 110, center.dy + 140);
    routePath.lineTo(center.dx - 40, center.dy + 70);
    routePath.lineTo(center.dx - 40, center.dy - 30);
    routePath.lineTo(center.dx + 50, center.dy - 30);
    routePath.lineTo(center.dx + 50, center.dy - 110);
    canvas.drawPath(routePath, brightRoutePaint);

    // 6. Start Pin (Gourmet Kitchen)
    final startPinPaint = Paint()..color = const Color(0xFF1C1917);
    canvas.drawCircle(Offset(center.dx - 110, center.dy + 140), 6, startPinPaint);
    final startInner = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(center.dx - 110, center.dy + 140), 2.5, startInner);

    // 7. Destination Pin (Customer Location)
    final destPinPaint = Paint()..color = AppColors.primary;
    canvas.drawCircle(Offset(center.dx + 50, center.dy - 110), 8, destPinPaint);
    final destInner = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(center.dx + 50, center.dy - 110), 3.5, destInner);

    // 8. Compass Rose Accent
    _drawCompass(canvas, Offset(size.width - 45, 120));
  }

  void _drawCityBlocks(Canvas canvas, Offset center, Paint paint) {
    for (double offset = -120; offset <= 120; offset += 36) {
      canvas.drawLine(
        Offset(center.dx - 140, center.dy + offset),
        Offset(center.dx - 40, center.dy + offset),
        paint,
      );
      canvas.drawLine(
        Offset(center.dx + 20, center.dy + offset),
        Offset(center.dx + 140, center.dy + offset),
        paint,
      );
    }
  }

  void _drawCompass(Canvas canvas, Offset pos) {
    final compassPaint = Paint()
      ..color = const Color(0xFFA8A29E)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(pos, 18, compassPaint);

    // Star points for compass
    final path = Path();
    path.moveTo(pos.dx, pos.dy - 16);
    path.lineTo(pos.dx + 3, pos.dy);
    path.lineTo(pos.dx + 16, pos.dy);
    path.lineTo(pos.dx, pos.dy + 3);
    path.lineTo(pos.dx, pos.dy + 16);
    path.lineTo(pos.dx - 3, pos.dy);
    path.lineTo(pos.dx - 16, pos.dy);
    path.lineTo(pos.dx, pos.dy - 3);
    path.close();
    canvas.drawPath(path, compassPaint);

    const textStyle = TextStyle(
      color: AppColors.primary,
      fontSize: 9,
      fontWeight: FontWeight.bold,
    );
    final textSpan = const TextSpan(text: 'N', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(pos.dx - 3, pos.dy - 28));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
