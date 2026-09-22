import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class SecuredContactCard extends StatelessWidget {
  final String maskedPhone;
  final String proxyNotice;

  const SecuredContactCard({
    super.key,
    required this.maskedPhone,
    required this.proxyNotice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
          Text(
            'SECURED CONTACT LINE',
            style: GoogleFonts.inter(
              color: const Color(0xFF8E8E93),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            maskedPhone,
            style: GoogleFonts.inter(
              color: AppColors.creamText,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            proxyNotice,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF7A7A7E),
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
