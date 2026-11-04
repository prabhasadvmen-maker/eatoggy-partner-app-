import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

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
        color: AppColors.surface,
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: AppColors.border,
          width: 1.0,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visual Radar & Map Container
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 145,
              width: double.infinity,
              color: const Color(0xFFF7F4EE),
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
                  style: GoogleFonts.fraunces(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  zoneSubtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
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

    // Subtle background radial glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primary.withValues(alpha: 0.12),
          AppColors.primary.withValues(alpha: 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 85));
    canvas.drawCircle(center, 85, glowPaint);

    final rayPaint = Paint()
      ..color = const Color(0xFFD6D3D1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const numRays = 18;
    for (int i = 0; i < numRays; i++) {
      final angle = (i * 2 * math.pi) / numRays;
      final rayLength = 55.0 + (i % 3) * 22.0;
      final end = Offset(
        center.dx + rayLength * math.cos(angle),
        center.dy + rayLength * math.sin(angle),
      );
      canvas.drawLine(center, end, rayPaint);
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
      ..color = AppColors.primary.withValues(alpha: 0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final outerRingPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.25)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 12, outerRingPaint);
    canvas.drawCircle(center, 26, ringPaint);
    canvas.drawCircle(center, 44, outerRingPaint);
    canvas.drawCircle(center, 64, outerRingPaint);

    // Center hub point
    final hubPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.0, hubPaint);

    // Location labels
    final textStyle = TextStyle(
      color: AppColors.textPrimary.withValues(alpha: 0.7),
      fontSize: 8.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    );

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    textPainter.text = TextSpan(text: 'INDIRANAGAR', style: textStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - 88, center.dy - 6));

    textPainter.text = TextSpan(text: 'KORAMANGALA', style: textStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx + 38, center.dy - 6));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
