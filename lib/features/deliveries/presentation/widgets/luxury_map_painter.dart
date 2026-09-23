import 'dart:math' as math;
import 'package:flutter/material.dart';

class LuxuryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Dark Gradient Background
    final bgPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, 0.05),
        radius: 1.1,
        colors: [
          Color(0xFF1B1812),
          Color(0xFF0F0E0B),
          Color(0xFF0A0A09),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final center = Offset(size.width * 0.5, size.height * 0.5);

    // Paints
    final goldGridPaint = Paint()
      ..color = const Color(0xFF8C6F34).withValues(alpha: 0.35)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    final goldMajorRoadPaint = Paint()
      ..color = const Color(0xFFD4A24E).withValues(alpha: 0.65)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final brightRoutePaint = Paint()
      ..color = const Color(0xFFFFCC66)
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;

    // 2. Concentric Central City Squares
    for (double r = 18; r <= 160; r += 24) {
      final rect = Rect.fromCenter(center: center, width: r * 2, height: r * 2);
      canvas.drawRect(rect, goldGridPaint);
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

    for (final a in angles) {
      final endX = center.dx + math.cos(a) * size.height * 0.8;
      final endY = center.dy + math.sin(a) * size.height * 0.8;
      canvas.drawLine(center, Offset(endX, endY), goldMajorRoadPaint);
    }

    // 4. Secondary Grid Blocks in 4 Quadrants
    _drawGridBlocks(canvas, center, goldGridPaint);

    // 5. Active Glowing Delivery Route
    final routePath = Path();
    routePath.moveTo(center.dx - 80, center.dy + 140);
    routePath.lineTo(center.dx - 40, center.dy + 50);
    routePath.lineTo(center.dx, center.dy);
    routePath.lineTo(center.dx + 60, center.dy - 70);
    routePath.lineTo(center.dx + 80, center.dy - 180);

    // Glow under route
    final routeGlowPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.25)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(routePath, routeGlowPaint);
    canvas.drawPath(routePath, brightRoutePaint);

    // 6. Sparkling Starburst Nodes along intersections
    _drawSparkle(canvas, Offset(center.dx - 80, center.dy + 140));
    _drawSparkle(canvas, Offset(center.dx - 40, center.dy + 50));
    _drawSparkle(canvas, center);
    _drawSparkle(canvas, Offset(center.dx + 60, center.dy - 70));
    _drawSparkle(canvas, Offset(center.dx + 80, center.dy - 180));
    _drawSparkle(canvas, Offset(center.dx - 90, center.dy - 110));
    _drawSparkle(canvas, Offset(center.dx + 110, center.dy + 80));

    // 7. Top Right Compass Rose
    _drawCompass(canvas, Offset(size.width - 45, 90));
  }

  void _drawGridBlocks(Canvas canvas, Offset center, Paint paint) {
    // Quadrant grid blocks
    for (int i = 1; i <= 5; i++) {
      final offset = i * 28.0;
      // Top Right
      canvas.drawLine(
        Offset(center.dx + offset, center.dy - 120),
        Offset(center.dx + offset, center.dy - 20),
        paint,
      );
      canvas.drawLine(
        Offset(center.dx + 20, center.dy - offset),
        Offset(center.dx + 130, center.dy - offset),
        paint,
      );

      // Top Left
      canvas.drawLine(
        Offset(center.dx - offset, center.dy - 130),
        Offset(center.dx - offset, center.dy - 20),
        paint,
      );
      canvas.drawLine(
        Offset(center.dx - 130, center.dy - offset),
        Offset(center.dx - 20, center.dy - offset),
        paint,
      );

      // Bottom Left
      canvas.drawLine(
        Offset(center.dx - offset, center.dy + 20),
        Offset(center.dx - offset, center.dy + 120),
        paint,
      );
      canvas.drawLine(
        Offset(center.dx - 120, center.dy + offset),
        Offset(center.dx - 20, center.dy + offset),
        paint,
      );

      // Bottom Right
      canvas.drawLine(
        Offset(center.dx + offset, center.dy + 20),
        Offset(center.dx + offset, center.dy + 120),
        paint,
      );
      canvas.drawLine(
        Offset(center.dx + 20, center.dy + offset),
        Offset(center.dx + 120, center.dy + offset),
        paint,
      );
    }
  }

  void _drawSparkle(Canvas canvas, Offset pos) {
    final sparklePaint = Paint()
      ..color = const Color(0xFFFFDE99)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    const len = 7.0;
    // Cross
    canvas.drawLine(Offset(pos.dx - len, pos.dy), Offset(pos.dx + len, pos.dy), sparklePaint);
    canvas.drawLine(Offset(pos.dx, pos.dy - len), Offset(pos.dx, pos.dy + len), sparklePaint);

    // Diagonal
    const dLen = 4.0;
    canvas.drawLine(Offset(pos.dx - dLen, pos.dy - dLen), Offset(pos.dx + dLen, pos.dy + dLen), sparklePaint);
    canvas.drawLine(Offset(pos.dx - dLen, pos.dy + dLen), Offset(pos.dx + dLen, pos.dy - dLen), sparklePaint);

    // Glowing dot in center
    final dotPaint = Paint()
      ..color = const Color(0xFFFFF2D0)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 2.0, dotPaint);
  }

  void _drawCompass(Canvas canvas, Offset pos) {
    final compassPaint = Paint()
      ..color = const Color(0xFFC79E49).withValues(alpha: 0.6)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(pos, 22, compassPaint);
    canvas.drawCircle(pos, 17, compassPaint);

    // Star points for compass
    final path = Path();
    path.moveTo(pos.dx, pos.dy - 20);
    path.lineTo(pos.dx + 4, pos.dy);
    path.lineTo(pos.dx + 20, pos.dy);
    path.lineTo(pos.dx, pos.dy + 4);
    path.lineTo(pos.dx, pos.dy + 20);
    path.lineTo(pos.dx - 4, pos.dy);
    path.lineTo(pos.dx - 20, pos.dy);
    path.lineTo(pos.dx, pos.dy - 4);
    path.close();
    canvas.drawPath(path, compassPaint);

    // N letter text
    const textStyle = TextStyle(
      color: Color(0xFFD4A24E),
      fontSize: 8,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(text: 'N', style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(pos.dx - 3, pos.dy - 32));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
