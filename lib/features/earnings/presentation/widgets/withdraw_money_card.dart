import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WithdrawMoneyCard extends StatelessWidget {
  final String availableBalance;
  final String settlementNote;
  final String bankInfo;
  final VoidCallback onWithdraw;
  final VoidCallback? onChangeBank;

  const WithdrawMoneyCard({
    super.key,
    required this.availableBalance,
    required this.settlementNote,
    required this.bankInfo,
    required this.onWithdraw,
    this.onChangeBank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF171719),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.cardGoldAccent.withValues(alpha: 0.55),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Available Balance Label
          Text(
            'AVAILABLE BALANCE',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.cardGoldAccent,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 5),

          // Big Balance Amount (Serif Fraunces in Gold)
          Text(
            availableBalance,
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.cardGoldAccent,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),

          // Settlement Note
          Text(
            settlementNote,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMutedDark,
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 18),

          // Withdraw Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onWithdraw,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardGoldAccent,
                foregroundColor: const Color(0xFF11110F),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Withdraw to Bank Account',
                style: AppTextStyles.button.copyWith(
                  color: const Color(0xFF11110F),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Bank Account Info & Change Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankInfo,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMutedDark,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: onChangeBank,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF222225),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF353538),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.edit_outlined,
                        color: AppColors.creamText,
                        size: 13.5,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Change',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.creamText,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
