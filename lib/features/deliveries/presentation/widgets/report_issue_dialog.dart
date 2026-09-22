import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ReportIssueBottomSheet extends StatefulWidget {
  final Function(String selectedReason) onReasonSubmitted;

  const ReportIssueBottomSheet({
    super.key,
    required this.onReasonSubmitted,
  });

  static Future<void> show(
    BuildContext context, {
    required Function(String) onReasonSubmitted,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReportIssueBottomSheet(
        onReasonSubmitted: onReasonSubmitted,
      ),
    );
  }

  @override
  State<ReportIssueBottomSheet> createState() => _ReportIssueBottomSheetState();
}

class _ReportIssueBottomSheetState extends State<ReportIssueBottomSheet> {
  final List<String> _issues = const [
    "Customer hasn't received the OTP notification",
    "Customer phone is switched off or unreachable",
    "Customer refusing delivery / payment dispute",
    "Incorrect customer address or building access denied",
    "Order items damaged or spilled in transit",
    "Other issue (contact fleet supervisor)",
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF181816),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Color(0xFF2E2E2A), width: 1.2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.report_problem_rounded,
                    color: AppColors.error,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Report Delivery Issue',
                  style: GoogleFonts.fraunces(
                    color: AppColors.creamText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Select the reason for verification issue to request supervisor override.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 18),

            // List of reasons
            ...List.generate(_issues.length, (index) {
              final isSelected = _selectedIndex == index;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.cardGoldAccent.withValues(alpha: 0.08)
                        : const Color(0xFF1E1E1C),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.cardGoldAccent
                          : const Color(0xFF2A2A27),
                      width: isSelected ? 1.2 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? AppColors.cardGoldAccent
                            : AppColors.textMutedDark,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _issues[index],
                          style: GoogleFonts.inter(
                            color: isSelected
                                ? AppColors.creamText
                                : AppColors.textPrimaryDark,
                            fontSize: 13.5,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardGoldAccent,
                  foregroundColor: const Color(0xFF11110F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  final reason = _issues[_selectedIndex];
                  Navigator.pop(context);
                  widget.onReasonSubmitted(reason);
                },
                child: Text(
                  'Submit Issue to Support',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF11110F),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
