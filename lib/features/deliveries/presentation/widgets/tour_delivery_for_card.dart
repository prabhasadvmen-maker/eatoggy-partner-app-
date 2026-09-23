import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

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
    const goldColor = AppColors.cardGoldAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: DELIVERY FOR
          Text(
            'DELIVERY FOR',
            style: GoogleFonts.inter(
              color: goldColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),

          // Customer Name (Fraunces Cream Serif)
          Text(
            customerName,
            style: GoogleFonts.fraunces(
              color: AppColors.creamText,
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
              color: const Color(0xFF8E8E93),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF242426),
            ),
          ),

          // Gate/Access Code Subsection
          Text(
            'Gate/Access Code:',
            style: GoogleFonts.inter(
              color: const Color(0xFF8E8E93),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            gateAccessCode,
            style: GoogleFonts.inter(
              color: const Color(0xFFD6D6DA),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
