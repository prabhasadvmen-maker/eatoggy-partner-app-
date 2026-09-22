import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class CustomerLocationCard extends StatelessWidget {
  final String customerName;
  final String subscriptionType;
  final String address;
  final VoidCallback onCall;
  final VoidCallback onCopyAddress;

  const CustomerLocationCard({
    super.key,
    required this.customerName,
    required this.subscriptionType,
    required this.address,
    required this.onCall,
    required this.onCopyAddress,
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
          // Customer Info & Phone Action Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: GoogleFonts.fraunces(
                      color: AppColors.creamText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subscriptionType,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8E8E93),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // Phone Call Icon Button
              InkWell(
                onTap: onCall,
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF242018),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.call_outlined,
                      color: goldColor,
                      size: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF262628),
            ),
          ),

          // Delivery Location Subsection
          Text(
            'DELIVERY LOCATION',
            style: GoogleFonts.inter(
              color: goldColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            address,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Copy Address Action
          InkWell(
            onTap: onCopyAddress,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.copy_rounded,
                  color: goldColor,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Copy Address',
                  style: GoogleFonts.inter(
                    color: goldColor,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
