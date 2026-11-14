import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
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
    final iconData = _getIconForType(notification.type);
    final iconColor = _getIconColorForType(notification.type);
    final iconBgColor = _getIconBgColorForType(notification.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Icon Container
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 20,
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
                          style: GoogleFonts.fraunces(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      if (!notification.isRead) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.description,
                    style: GoogleFonts.geist(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.timeAgo,
                    style: GoogleFonts.geist(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
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
        return AppColors.primary;
      case NotificationType.support:
        return const Color(0xFF2563EB); // Royal Blue
      case NotificationType.alert:
        return const Color(0xFFD97706); // Amber
      case NotificationType.payout:
        return const Color(0xFF16A34A); // Emerald
    }
  }

  Color _getIconBgColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.assignment:
        return const Color(0xFFFFF1F2); // Rose light
      case NotificationType.support:
        return const Color(0xFFEFF6FF); // Blue light
      case NotificationType.alert:
        return const Color(0xFFFEF3C7); // Amber light
      case NotificationType.payout:
        return const Color(0xFFDCFCE7); // Green light
    }
  }
}
