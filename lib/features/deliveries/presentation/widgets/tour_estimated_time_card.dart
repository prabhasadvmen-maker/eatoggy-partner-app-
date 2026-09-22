import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class TourEstimatedTimeCard extends StatelessWidget {
  final String estimatedTimeLeft;
  final VoidCallback onClose;

  const TourEstimatedTimeCard({
    super.key,
    required this.estimatedTimeLeft,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    const goldColor = AppColors.cardGoldAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: goldColor,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Estimated Time Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ESTIMATED TIME',
                style: GoogleFonts.inter(
                  color: goldColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                estimatedTimeLeft,
                style: GoogleFonts.fraunces(
                  color: AppColors.creamText,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),

          // Right: Circular Gold Close Icon Button
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFD4A24E),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.close_rounded,
                  color: Color(0xFF1A1408),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
