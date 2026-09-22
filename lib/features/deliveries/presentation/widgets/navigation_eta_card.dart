import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationEtaCard extends StatelessWidget {
  final int etaMinutes;
  final double distanceKm;
  final String turnDirection;
  final VoidCallback onBack;

  const NavigationEtaCard({
    super.key,
    required this.etaMinutes,
    required this.distanceKm,
    required this.turnDirection,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF161618),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF262628),
                width: 1,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Main ETA Card matching screenshot
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF161618),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF262628),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Green Circular Direction Arrow
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F2618),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.north_east_rounded,
                      color: Color(0xFF00E676),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // ETA & Turn Instruction Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ETA $etaMinutes Mins • $distanceKm km',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF00E676),
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        turnDirection,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF8E8E93),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
