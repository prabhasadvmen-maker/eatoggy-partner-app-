import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/support_faq_model.dart';

class FaqAccordionCard extends StatelessWidget {
  final SupportFaqItemModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqAccordionCard({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const goldColor = AppColors.cardGoldAccent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? goldColor : const Color(0xFF262628),
          width: isExpanded ? 1.3 : 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Title & Chevron)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      faq.title,
                      style: GoogleFonts.inter(
                        color: isExpanded ? goldColor : Colors.white,
                        fontSize: 15,
                        fontWeight: isExpanded ? FontWeight.w700 : FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: isExpanded ? goldColor : const Color(0xFF8E8E93),
                    size: 24,
                  ),
                ],
              ),

              // Expandable Answer Section
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    faq.answer,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFCCCCCC),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      height: 1.45,
                    ),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 240),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
