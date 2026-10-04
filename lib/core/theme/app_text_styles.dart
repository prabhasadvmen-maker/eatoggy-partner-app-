import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Headings using Fraunces (Luxury Serif for Brand, Numbers & Headers)
  static TextStyle displayLarge = GoogleFonts.fraunces(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle headingLarge = GoogleFonts.fraunces(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headingMedium = GoogleFonts.fraunces(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle headingSmall = GoogleFonts.fraunces(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body and Labels using Geist (Clean Modern Sans-Serif)
  static TextStyle titleLarge = GoogleFonts.geist(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = GoogleFonts.geist(
    fontSize: 14.5.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.geist(
    fontSize: 14.5.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.geist(
    fontSize: 13.5.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle bodySmall = GoogleFonts.geist(
    fontSize: 12.5.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle button = GoogleFonts.geist(
    fontSize: 14.5.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
    letterSpacing: 0.3,
  );

  static TextStyle caption = GoogleFonts.geist(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle label = GoogleFonts.geist(
    fontSize: 11.5.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 1.1,
  );

  // Currency & KPI Metrics
  static TextStyle kpiMetric = GoogleFonts.fraunces(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Splash Screen specific text styles
  static TextStyle splashPartnerTitle = GoogleFonts.geist(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
  );

  static TextStyle splashSubtitle = GoogleFonts.geist(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
