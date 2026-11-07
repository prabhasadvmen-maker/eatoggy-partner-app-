import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../data/models/earnings_model.dart';

class EarningsOverviewCard extends StatelessWidget {
  final EarningsDataModel data;

  const EarningsOverviewCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Label
          Text(
            data.periodLabel,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),

          // Big Total Amount
          Text(
            data.totalEarnings,
            style: GoogleFonts.fraunces(
              color: AppColors.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),

          // Divider Line
          const Divider(color: AppColors.border, height: 1),
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
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.deliveriesCount,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.avgPerDelivery,
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
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
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StatusBadge(text: data.payoutStatus),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
