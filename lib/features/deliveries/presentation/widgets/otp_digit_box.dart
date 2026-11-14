import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

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
    final bool showDash = !isFilled;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 68,
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.borderLg,
          border: Border.all(
            color: isFocused
                ? AppColors.primary
                : (isFilled ? AppColors.textPrimary : AppColors.border),
            width: isFocused ? 2.0 : 1.2,
          ),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : AppShadows.card,
        ),
        alignment: Alignment.center,
        child: Text(
          showDash ? '—' : digit,
          style: showDash
              ? GoogleFonts.inter(
                  color: AppColors.textPlaceholder,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )
              : GoogleFonts.fraunces(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
        ),
      ),
    );
  }
}
