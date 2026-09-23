import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class CustomerHistoryCard extends StatelessWidget {
  final int totalOrdersPlaced;
  final String memberSince;

  const CustomerHistoryCard({
    super.key,
    required this.totalOrdersPlaced,
    required this.memberSince,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF161615),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262624),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CUSTOMER HISTORY',
            style: GoogleFonts.inter(
              color: AppColors.cardGoldAccent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          // Total Orders Placed
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Orders Placed',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '$totalOrdersPlaced',
                style: GoogleFonts.inter(
                  color: AppColors.cardGoldAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Member Since
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Member Since',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                memberSince,
                style: GoogleFonts.inter(
                  color: const Color(0xFFE2E2E6),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
