import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItemModel notification;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF171719),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF262628),
            width: 0.8,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Icon Container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1D1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF2F2922),
                  width: 0.8,
                ),
              ),
              child: Icon(
                _getIconForType(notification.type),
                color: _getIconColorForType(notification.type),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),

            // Content: Title, Description, Timestamp
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textPrimaryDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                      if (!notification.isRead) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.cardGoldAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMutedDark,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.timeAgo,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textMutedDark.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return Icons.notifications_none_rounded;
      case NotificationType.support:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.alert:
        return Icons.warning_amber_rounded;
      case NotificationType.payout:
        return Icons.account_balance_wallet_outlined;
    }
  }

  Color _getIconColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
      case NotificationType.support:
        return AppColors.cardGoldAccent;
      case NotificationType.alert:
      case NotificationType.payout:
        return AppColors.textMutedDark;
    }
  }
}
