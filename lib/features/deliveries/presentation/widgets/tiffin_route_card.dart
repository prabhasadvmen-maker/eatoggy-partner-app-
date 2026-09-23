import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
          color: const Color(0xFF171719),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF262628),
            width: 0.8,
          ),
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
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.cardGoldAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 0.2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF251C12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF45301B),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    stop.tiffinsCount,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.cardGoldAccent,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Customer Name (Serif Fraunces in Warm Cream)
            Text(
              stop.customerName,
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.creamText,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),

            // Pin Icon & Address Row
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textMutedDark,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    stop.address,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMutedDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
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
