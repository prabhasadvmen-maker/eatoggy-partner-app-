import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/delivery_history_model.dart';

class HistoryCard extends StatelessWidget {
  final DeliveryHistoryModel history;
  final VoidCallback? onTap;

  const HistoryCard({
    super.key,
    required this.history,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFailed = history.status == HistoryStatus.failed;
    final isZeroEarnings = history.earningsText == '₹0.00';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF171719),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF262628),
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID & Status Badge Row
            Row(
              children: [
                Text(
                  history.orderId,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(history.status, history.statusText),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Name (Serif Fraunces in Warm Cream)
            Text(
              history.customerName,
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.creamText,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),

            // Timestamp (Muted Grey)
            Text(
              history.timestamp,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textMutedDark,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),

            // Divider Line
            Container(
              height: 1,
              color: const Color(0xFF242426),
            ),
            const SizedBox(height: 12),

            // Bottom Earnings Credited Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Earnings Credited',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMutedDark,
                    fontSize: 13,
                  ),
                ),
                Text(
                  history.earningsText,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isZeroEarnings || isFailed
                        ? AppColors.textMutedDark
                        : AppColors.cardGoldAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(HistoryStatus status, String text) {
    Color borderColor;
    Color bgColor;
    Color textColor;

    switch (status) {
      case HistoryStatus.failed:
        borderColor = const Color(0xFFE53935);
        bgColor = const Color(0xFF251010);
        textColor = const Color(0xFFEF5350);
        break;
      case HistoryStatus.delivered:
        borderColor = const Color(0xFF00C853);
        bgColor = const Color(0xFF0C1F15);
        textColor = const Color(0xFF00E676);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 0.9),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
