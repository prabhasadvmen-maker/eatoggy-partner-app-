import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/tiffin_zone_model.dart';

class TiffinRouteCard extends StatelessWidget {
  final TiffinRouteStop stop;
  final VoidCallback? onTap;

  const TiffinRouteCard({
    super.key,
    required this.stop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
            // Top Row: Time Slot & Tiffins Count Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stop.timeSlot,
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    stop.tiffinsCount,
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Customer Name
            Text(
              stop.customerName,
              style: GoogleFonts.fraunces(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),

            // Pin Icon & Address Row
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textSecondary,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    stop.address,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
