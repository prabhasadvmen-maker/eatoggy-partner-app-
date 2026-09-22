import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ZoneRadarCard extends StatelessWidget {
  final String zoneName;
  final String zoneSubtitle;

  const ZoneRadarCard({
    super.key,
    required this.zoneName,
    required this.zoneSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF171719),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visual Radar & Map Container
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
            child: Container(
              height: 145,
              width: double.infinity,
              color: const Color(0xFF0E0E10),
              child: CustomPaint(
                painter: _ZoneMapRadarPainter(),
              ),
            ),
          ),

          // Zone Title & Description
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  zoneName,
                  style: AppTextStyles.headingSmall.copyWith(
                    color: AppColors.creamText,
                    fontSize: 17.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  zoneSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMutedDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneMapRadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.49, size.height * 0.48);

    // Subtle background radial glow behind the center target
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFE5A64E).withValues(alpha: 0.18),
          const Color(0xFFE5A64E).withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 85));
    canvas.drawCircle(center, 85, glowPaint);

    // Network road lines / rays originating from center
    final rayPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.20)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    final faintRayPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.10)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;

    const numRays = 18;
    for (int i = 0; i < numRays; i++) {
      final angle = (i * 2 * math.pi) / numRays;
      final rayLength = 55.0 + (i % 3) * 22.0;
      final end = Offset(
        center.dx + rayLength * math.cos(angle),
        center.dy + rayLength * math.sin(angle),
      );
      canvas.drawLine(center, end, (i % 2 == 0) ? rayPaint : faintRayPaint);
    }

    // Branching cross-roads
    final roadPath = Path();
    roadPath.moveTo(center.dx - 80, center.dy + 15);
    roadPath.quadraticBezierTo(center.dx - 30, center.dy - 10, center.dx, center.dy);
    roadPath.quadraticBezierTo(center.dx + 40, center.dy + 12, center.dx + 90, center.dy - 8);

    roadPath.moveTo(center.dx - 70, center.dy - 25);
    roadPath.quadraticBezierTo(center.dx - 20, center.dy - 5, center.dx, center.dy);
    roadPath.quadraticBezierTo(center.dx + 35, center.dy - 15, center.dx + 85, center.dy + 20);

    canvas.drawPath(roadPath, rayPaint);

    // Concentric Radar Rings
    final ringPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.70)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final outerRingPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.35)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final innerRingPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.45)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    // Rings
    canvas.drawCircle(center, 12, innerRingPaint);
    canvas.drawCircle(center, 24, ringPaint);
    canvas.drawCircle(center, 38, innerRingPaint);
    canvas.drawCircle(center, 56, outerRingPaint);

    // Center hub point
    final hubPaint = Paint()
      ..color = const Color(0xFFE5A64E)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 3.2, hubPaint);

    // Location labels: "INDIRANAGAR" (left) and "KORAMANGALA" (right)
    final textStyle = TextStyle(
      color: const Color(0xFFE5A64E).withValues(alpha: 0.60),
      fontSize: 8.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    textPainter.text = TextSpan(text: 'INDIRANAGAR', style: textStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 88, center.dy - 6));

    textPainter.text = TextSpan(text: 'KORAMANGALA', style: textStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx + 38, center.dy - 6));

    // Compass star at bottom-left corner
    _drawCompassStar(canvas, Offset(24, size.height - 24));
  }

  void _drawCompassStar(Canvas canvas, Offset pos) {
    final starPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.65)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 4-point cross star
    canvas.drawLine(Offset(pos.dx - 7, pos.dy), Offset(pos.dx + 7, pos.dy), starPaint);
    canvas.drawLine(Offset(pos.dx, pos.dy - 7), Offset(pos.dx, pos.dy + 7), starPaint);

    // Diagonal subtle points
    final diagPaint = Paint()
      ..color = const Color(0xFFE5A64E).withValues(alpha: 0.35)
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(pos.dx - 3.5, pos.dy - 3.5), Offset(pos.dx + 3.5, pos.dy + 3.5), diagPaint);
    canvas.drawLine(Offset(pos.dx - 3.5, pos.dy + 3.5), Offset(pos.dx + 3.5, pos.dy - 3.5), diagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
