import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/delivery_assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  final DeliveryAssignmentModel assignment;
  final VoidCallback? onTap;

  const AssignmentCard({
    super.key,
    required this.assignment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                  assignment.orderId,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(assignment.status, assignment.statusText),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Name (Serif Fraunces in Warm Cream)
            Text(
              assignment.customerName,
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.creamText,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),

            // Address (Muted Grey)
            Text(
              assignment.address,
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

            // Bottom Slot & Tiffins Info Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  assignment.timeSlot,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMutedDark,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  assignment.tiffinsCountText,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.cardGoldAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(AssignmentStatus status, String text) {
    Color borderColor;
    Color bgColor;
    Color textColor;

    switch (status) {
      case AssignmentStatus.pending:
      case AssignmentStatus.outForDelivery:
        borderColor = AppColors.cardGoldAccent;
        bgColor = const Color(0xFF241910);
        textColor = AppColors.cardGoldAccent;
        break;
      case AssignmentStatus.readyToPickup:
        borderColor = const Color(0xFF00C853);
        bgColor = const Color(0xFF0C1F15);
        textColor = const Color(0xFF00E676);
        break;
      case AssignmentStatus.delivered:
        borderColor = const Color(0xFF48484A);
        bgColor = const Color(0xFF1E1E20);
        textColor = const Color(0xFF8E8E93);
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
