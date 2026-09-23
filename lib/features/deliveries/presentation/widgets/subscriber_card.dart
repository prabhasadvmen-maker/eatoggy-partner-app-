import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
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
            // Top Row: Avatar + Name & Plan + Status Badges
            Row(
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF252528),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFF38383C),
                        width: 1,
                      ),
                    ),
                    child: subscriber.avatarUrl.isNotEmpty
                        ? Image.network(
                            subscriber.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildInitialsAvatar(),
                          )
                        : _buildInitialsAvatar(),
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
                        style: AppTextStyles.headingSmall.copyWith(
                          color: AppColors.creamText,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subscriber.plan,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.cardGoldAccent,
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
                          horizontal: 7.5,
                          vertical: 3.5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardGoldAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'NEW',
                          style: AppTextStyles.caption.copyWith(
                            color: const Color(0xFF11110F),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    _buildStatusBadge(subscriber.status),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Divider Line
            Container(
              height: 1,
              color: const Color(0xFF242426),
            ),
            const SizedBox(height: 12),

            // Address
            Text(
              subscriber.address,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimaryDark,
                fontSize: 13,
                fontWeight: FontWeight.w400,
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
                    color: AppColors.textMutedDark,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: onViewHistory,
                  child: Text(
                    'View History',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.cardGoldAccent,
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

  Widget _buildInitialsAvatar() {
    final initials = subscriber.name.isNotEmpty
        ? subscriber.name
            .split(' ')
            .map((e) => e.isNotEmpty ? e[0] : '')
            .take(2)
            .join()
        : 'U';

    return Center(
      child: Text(
        initials,
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.creamText,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(SubscriberStatus status) {
    if (status == SubscriberStatus.active) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF0C1F15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF00C853), width: 0.9),
        ),
        child: Text(
          'ACTIVE',
          style: AppTextStyles.caption.copyWith(
            color: const Color(0xFF00E676),
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E20),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF48484A), width: 0.9),
      ),
      child: Text(
        'PAUSED',
        style: AppTextStyles.caption.copyWith(
          color: const Color(0xFF8E8E93),
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
