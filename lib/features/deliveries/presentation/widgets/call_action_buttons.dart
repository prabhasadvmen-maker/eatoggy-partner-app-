import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

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
        // Voice Call Action
        Expanded(
          child: InkWell(
            onTap: onVoiceCallTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 108,
              decoration: BoxDecoration(
                color: const Color(0xFF161615),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF262624),
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone_in_talk_outlined,
                    color: AppColors.cardGoldAccent,
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Voice Call',
                    style: GoogleFonts.inter(
                      color: AppColors.creamText,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Secure Chat Action
        Expanded(
          child: InkWell(
            onTap: onSecureChatTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 108,
              decoration: BoxDecoration(
                color: const Color(0xFF161615),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF262624),
                  width: 1.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.cardGoldAccent,
                    size: 28,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Secure Chat',
                    style: GoogleFonts.inter(
                      color: AppColors.creamText,
                      fontSize: 15.5,
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
