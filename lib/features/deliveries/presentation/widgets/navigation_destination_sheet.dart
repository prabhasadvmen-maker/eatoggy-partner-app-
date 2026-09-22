import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

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
    const goldColor = AppColors.cardGoldAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 26),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF262628),
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
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
                color: goldColor,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),

            // Destination Title (Fraunces Cream Serif)
            Text(
              destinationTitle,
              style: GoogleFonts.fraunces(
                color: AppColors.creamText,
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
                color: const Color(0xFFA0A0A5),
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
                  child: InkWell(
                    onTap: onOpenMaps,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2E2E32),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Open Google Maps',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // "Mark Arrived" Gold CTA Button
                Expanded(
                  child: InkWell(
                    onTap: onMarkArrived,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: isArrived
                            ? const Color(0xFF00E676)
                            : goldColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: (isArrived
                                    ? const Color(0xFF00E676)
                                    : goldColor)
                                .withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isArrived ? 'Arrived ✓' : 'Mark Arrived',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF141416),
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
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
