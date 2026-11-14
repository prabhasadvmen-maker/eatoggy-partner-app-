import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class NavigationDestinationSheet extends StatelessWidget {
  final String destinationTitle;
  final String destinationDetails;
  final bool isArrived;
  final VoidCallback onOpenMaps;
  final VoidCallback onMarkArrived;

  const NavigationDestinationSheet({
    super.key,
    required this.destinationTitle,
    required this.destinationDetails,
    required this.isArrived,
    required this.onOpenMaps,
    required this.onMarkArrived,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 26),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: const Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header: DELIVERY DESTINATION
            Text(
              'DELIVERY DESTINATION',
              style: GoogleFonts.inter(
                color: AppColors.primary,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),

            // Destination Title (Fraunces Stone Charcoal Serif)
            Text(
              destinationTitle,
              style: GoogleFonts.fraunces(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 4),

            // Destination Details
            Text(
              destinationDetails,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons Row: Open Google Maps & Mark Arrived
            Row(
              children: [
                // "Open Google Maps" Button
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: onOpenMaps,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.border),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.borderLg,
                        ),
                      ),
                      child: Text(
                        'Open Google Maps',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // "Mark Arrived" Crimson CTA Button
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onMarkArrived,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isArrived ? AppColors.success : AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.borderLg,
                        ),
                      ),
                      child: Text(
                        isArrived ? 'Arrived ✓' : 'Mark Arrived',
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
