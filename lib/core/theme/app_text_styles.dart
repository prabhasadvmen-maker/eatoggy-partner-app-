import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings using Fraunces
  static TextStyle displayLarge = GoogleFonts.fraunces(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.goldFont,
    letterSpacing: -0.5,
  );

  static TextStyle headingLarge = GoogleFonts.fraunces(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.goldFont,
  );

  static TextStyle headingMedium = GoogleFonts.fraunces(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle headingSmall = GoogleFonts.fraunces(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  // Body and Labels using Geist
  static TextStyle titleLarge = GoogleFonts.geist(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle titleMedium = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle bodyLarge = GoogleFonts.geist(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle bodyMedium = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
  );

  static TextStyle bodySmall = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
  );

  static TextStyle button = GoogleFonts.geist(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.darkBackground,
  );

  static TextStyle caption = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textMutedDark,
  );

  static TextStyle label = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.goldFont,
    letterSpacing: 1.2,
  );

  // Splash Screen specific text styles
  static TextStyle splashPartnerTitle = GoogleFonts.geist(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.goldFont,
    letterSpacing: 1.8,
  );

  static TextStyle splashSubtitle = GoogleFonts.geist(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.goldFont.withValues(alpha: 0.65),
    letterSpacing: 0.5,
  );
}
