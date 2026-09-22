import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/earnings_model.dart';

class EarningsOverviewCard extends StatelessWidget {
  final EarningsDataModel data;

  const EarningsOverviewCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
          // Period Label
          Text(
            data.periodLabel,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMutedDark,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),

          // Big Total Amount (Serif Fraunces in Gold)
          Text(
            data.totalEarnings,
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.cardGoldAccent,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),

          // Divider Line
          Container(
            height: 1,
            color: const Color(0xFF242426),
          ),
          const SizedBox(height: 16),

          // 3 Columns: Deliveries, Avg. per delivery, Payout Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Deliveries
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliveries',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMutedDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.deliveriesCount,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.creamText,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              // Avg. per delivery
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Avg. per delivery',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMutedDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.avgPerDelivery,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.creamText,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              // Payout Status Badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payout Status',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMutedDark,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3.5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C1F15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF00C853),
                        width: 0.9,
                      ),
                    ),
                    child: Text(
                      data.payoutStatus,
                      style: AppTextStyles.caption.copyWith(
                        color: const Color(0xFF00E676),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
