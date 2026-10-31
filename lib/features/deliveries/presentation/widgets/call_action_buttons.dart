import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class CallActionButtons extends StatelessWidget {
  final VoidCallback onVoiceCallTap;
  final VoidCallback onSecureChatTap;

  const CallActionButtons({
    super.key,
    required this.onVoiceCallTap,
    required this.onSecureChatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Voice Call Action (Crimson solid card)
        Expanded(
          child: InkWell(
            onTap: onVoiceCallTap,
            borderRadius: AppRadius.borderLg,
            child: Container(
              height: 104,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.borderLg,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_in_talk_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Voice Call',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Secure Chat Action (White Card with Stone Border)
        Expanded(
          child: InkWell(
            onTap: onSecureChatTap,
            borderRadius: AppRadius.borderLg,
            child: Container(
              height: 104,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.borderLg,
                border: Border.all(
                  color: AppColors.border,
                  width: 1.0,
                ),
                boxShadow: AppShadows.card,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.primary,
                    size: 26,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Secure Chat',
                    style: GoogleFonts.inter(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
