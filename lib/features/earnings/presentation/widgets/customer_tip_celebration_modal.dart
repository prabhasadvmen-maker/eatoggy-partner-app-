import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class CustomerTipCelebrationModal extends StatefulWidget {
  final double tipAmount;
  final String customerName;
  final String orderId;
  final VoidCallback onClaimed;

  const CustomerTipCelebrationModal({
    super.key,
    this.tipAmount = 50.00,
    this.customerName = 'Rohan Malhotra',
    this.orderId = '#EG-7840',
    required this.onClaimed,
  });

  static Future<void> show(
    BuildContext context, {
    double tipAmount = 50.00,
    String customerName = 'Rohan Malhotra',
    String orderId = '#EG-7840',
    VoidCallback? onClaimed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CustomerTipCelebrationModal(
        tipAmount: tipAmount,
        customerName: customerName,
        orderId: orderId,
        onClaimed: () {
          Navigator.pop(context);
          if (onClaimed != null) onClaimed();
        },
      ),
    );
  }

  @override
  State<CustomerTipCelebrationModal> createState() =>
      _CustomerTipCelebrationModalState();
}

class _CustomerTipCelebrationModalState
    extends State<CustomerTipCelebrationModal> {
  int _selectedNoteIndex = 0;
  final List<String> _thankYouNotes = [
    '🙏 Thank you so much for your generosity!',
    '✨ Have a wonderful, delicious meal!',
    '⭐ It was a pleasure delivering to you!',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Golden Celebration Coin Icon
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFDE68A), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD97706).withValues(alpha: 0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFD97706),
                  size: 38,
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Heading
            Text(
              'You Received a Customer Tip!',
              style: GoogleFonts.fraunces(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

            // Tip Amount
            Text(
              '+ ₹${widget.tipAmount.toStringAsFixed(2)}',
              style: GoogleFonts.fraunces(
                color: const Color(0xFF15803D),
                fontSize: 36,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              '${widget.customerName} tipped you for exceptional service on Order ${widget.orderId}.',
              style: GoogleFonts.geist(
                color: AppColors.textSecondary,
                fontSize: 13.5,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),

            // 100% Policy Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    color: Color(0xFF15803D),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '100% of customer tips are yours (0% platform fee)',
                    style: GoogleFonts.geist(
                      color: const Color(0xFF15803D),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Quick Thank You Note selector
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SEND A THANK YOU NOTE TO ROHAN',
                style: GoogleFonts.geist(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(_thankYouNotes.length, (index) {
              final isSelected = _selectedNoteIndex == index;
              return InkWell(
                onTap: () => setState(() => _selectedNoteIndex = index),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFF1F2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFECACA) : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                        color: isSelected ? AppColors.primary : AppColors.textMuted,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _thankYouNotes[index],
                          style: GoogleFonts.geist(
                            color: isSelected ? AppColors.primary : AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),

            // Claim & Acknowledge CTA
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  widget.onClaimed();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('₹${widget.tipAmount.toStringAsFixed(2)} added to your earnings balance!'),
                      backgroundColor: const Color(0xFF16A34A),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Claim & Send Note',
                  style: GoogleFonts.geist(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
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
