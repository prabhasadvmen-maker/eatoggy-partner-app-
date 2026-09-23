import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/delivery_completion_model.dart';

class DeliveryCompletionCard extends StatelessWidget {
  final DeliveryCompletionModel model;

  const DeliveryCompletionCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF161615),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262624),
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Row 1: Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                model.orderId,
                style: GoogleFonts.inter(
                  color: AppColors.creamText,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Row 2: Timestamp
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Timestamp',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                model.timestamp,
                style: GoogleFonts.inter(
                  color: const Color(0xFFE2E2E6),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Row 3: Customer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customer',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                model.customerName,
                style: GoogleFonts.inter(
                  color: AppColors.creamText,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: Color(0xFF262624), thickness: 1.0),
          const SizedBox(height: 16),

          // Row 4: Earnings Credited
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Earnings Credited',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                model.earningsCredited,
                style: GoogleFonts.fraunces(
                  color: AppColors.cardGoldAccent,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
