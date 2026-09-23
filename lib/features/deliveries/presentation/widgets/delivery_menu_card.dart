import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/delivery_category_model.dart';

class GoldenBracketBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double cornerRadius;
  final double extension;

  const GoldenBracketBorderPainter({
    required this.color,
    this.strokeWidth = 3.5,
    this.cornerRadius = 24.0,
    this.extension = 22.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final halfStroke = strokeWidth / 2;
    final r = cornerRadius;
    final strokeRadius = r - halfStroke;

    final path = Path();

    // 1. Start on the top edge curve
    path.moveTo(r + extension, halfStroke);

    // 2. Line to start of top-left corner arc
    path.lineTo(r, halfStroke);

    // 3. Exact circular 90-degree arc around top-left corner (12 o'clock to 9 o'clock)
    path.arcTo(
      Rect.fromCircle(center: Offset(r, r), radius: strokeRadius),
      -math.pi / 2,
      -math.pi / 2,
      false,
    );

    // 4. Straight line down the left edge
    path.lineTo(halfStroke, size.height - r);

    // 5. Exact circular 90-degree arc around bottom-left corner (9 o'clock to 6 o'clock)
    path.arcTo(
      Rect.fromCircle(center: Offset(r, size.height - r), radius: strokeRadius),
      math.pi,
      -math.pi / 2,
      false,
    );

    // 6. Line along bottom edge
    path.lineTo(r + extension, size.height - halfStroke);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GoldenBracketBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.cornerRadius != cornerRadius ||
      oldDelegate.extension != extension;
}

class DeliveryMenuCard extends StatelessWidget {
  final DeliveryCategoryModel item;
  final VoidCallback? onTap;

  const DeliveryMenuCard({
    super.key,
    required this.item,
    this.onTap,
  });

  static const Color _honeyGold = Color(0xFFD89B48);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: const GoldenBracketBorderPainter(
          color: _honeyGold,
          strokeWidth: 3.5,
          cornerRadius: 24.0,
          extension: 22.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 18, 12, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF171718),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Gold Rounded Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _honeyGold,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  color: const Color(0xFF121212),
                  size: 26,
                ),
              ),
              const SizedBox(height: 16),

              // Title (Serif Fraunces in Warm Ivory/Cream) - Complete on 1 line without '...'
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title,
                    maxLines: 1,
                    style: GoogleFonts.fraunces(
                      color: AppColors.creamText,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle (Sans-serif in Muted Grey)
              Flexible(
                child: Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8E8E93),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

