import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class OtpDigitBox extends StatelessWidget {
  final String digit;
  final bool isFocused;
  final bool isFilled;
  final VoidCallback? onTap;

  const OtpDigitBox({
    super.key,
    required this.digit,
    required this.isFocused,
    required this.isFilled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Exact visual matching with reference UI:
    // When filled: dark rounded box with subtle dark border and bold cream digit
    // When focused or waiting for input: highlighted with elegant gold border and dash '-'
    final bool showDash = !isFilled;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 72,
        height: 76,
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isFocused
                ? AppColors.cardGoldAccent
                : (isFilled
                    ? const Color(0xFF2E2E2A)
                    : AppColors.cardGoldAccent.withValues(alpha: 0.7)),
            width: isFocused ? 2.0 : 1.4,
          ),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: AppColors.cardGoldAccent.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          showDash ? '—' : digit,
          style: showDash
              ? GoogleFonts.inter(
                  color: AppColors.cardGoldAccent.withValues(alpha: 0.6),
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                )
              : GoogleFonts.fraunces(
                  color: AppColors.creamText,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
        ),
      ),
    );
  }
}
