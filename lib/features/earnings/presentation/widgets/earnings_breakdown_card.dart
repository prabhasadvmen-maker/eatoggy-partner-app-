import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/earnings_model.dart';

class EarningsBreakdownCard extends StatelessWidget {
  final DailyEarningBreakdown breakdown;
  final VoidCallback? onTap;

  const EarningsBreakdownCard({
    super.key,
    required this.breakdown,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF171719),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF262628),
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Date Title & Deliveries Count
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breakdown.dateTitle,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  breakdown.deliveriesCountText,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMutedDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            // Right: Amount in Gold
            Text(
              breakdown.amount,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.cardGoldAccent,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
