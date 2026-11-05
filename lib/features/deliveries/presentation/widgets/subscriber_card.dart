import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../data/models/tiffin_subscriber_model.dart';

class SubscriberCard extends StatelessWidget {
  final TiffinSubscriberModel subscriber;
  final VoidCallback? onTap;
  final VoidCallback? onViewHistory;

  const SubscriberCard({
    super.key,
    required this.subscriber,
    this.onTap,
    this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Avatar + Name & Plan + Status Badges
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.surfaceSubtle,
                  child: Text(
                    subscriber.name.isNotEmpty ? subscriber.name[0] : 'U',
                    style: GoogleFonts.fraunces(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name & Plan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subscriber.name,
                        style: GoogleFonts.fraunces(
                          color: AppColors.textPrimary,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subscriber.plan,
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Badges: "NEW" (if true) and "ACTIVE" / "PAUSED"
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (subscriber.isNew) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    StatusBadge(
                      text: subscriber.status == SubscriberStatus.active
                          ? 'ACTIVE'
                          : 'PAUSED',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Divider Line
            const Divider(color: AppColors.border, height: 1),
            const SizedBox(height: 12),

            // Address
            Text(
              subscriber.address,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Bottom Row: Subscription Date & "View History" Link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subscription Since: ${subscriber.subscriptionSince}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: onViewHistory,
                  child: Text(
                    'View History',
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
