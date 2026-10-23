import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';

class TourDeliveryForCard extends StatelessWidget {
  final String customerName;
  final String address;
  final String gateAccessCode;

  const TourDeliveryForCard({
    super.key,
    required this.customerName,
    required this.address,
    required this.gateAccessCode,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: DELIVERY FOR
          Text(
            'DELIVERY FOR',
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),

          // Customer Name (Fraunces Stone Charcoal Serif)
          Text(
            customerName,
            style: GoogleFonts.fraunces(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),

          // Address
          Text(
            address,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              color: AppColors.border,
            ),
          ),

          // Gate/Access Code Subsection
          Text(
            'Gate/Access Code:',
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            gateAccessCode,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
