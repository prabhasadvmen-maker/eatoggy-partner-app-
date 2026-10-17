import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class IncentiveQuestsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const IncentiveQuestsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Incentives & Quests',
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'LIVE SURGES',
                      style: GoogleFonts.geist(
                        color: const Color(0xFF15803D),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total Earned from Quests Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.emoji_events_rounded,
                                color: Color(0xFFD97706),
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TODAY\'S INCENTIVE BONUS',
                                  style: GoogleFonts.geist(
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹370.00 Earned',
                                  style: GoogleFonts.fraunces(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '1 Milestone completed • 2 Active in progress',
                                  style: GoogleFonts.geist(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Active Surge Zones
                    Text(
                      'ACTIVE PEAK SURGES IN YOUR TERRITORY',
                      style: GoogleFonts.geist(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildSurgeCard(
                      title: 'Dinner Peak Surge',
                      reward: '+₹25.00 / run',
                      timeWindow: 'Active 7:00 PM – 10:30 PM',
                      zone: 'Indiranagar & Koramangala Zone',
                      icon: Icons.electric_bolt_rounded,
                      color: const Color(0xFFD97706),
                      bgColor: const Color(0xFFFEF3C7),
                    ),
                    const SizedBox(height: 8),
                    _buildSurgeCard(
                      title: 'Rain / Weather Surge',
                      reward: '+₹35.00 / run',
                      timeWindow: 'Active right now',
                      zone: 'Sector 4, Bangalore East',
                      icon: Icons.thunderstorm_rounded,
                      color: const Color(0xFF2563EB),
                      bgColor: const Color(0xFFEFF6FF),
                    ),
                    const SizedBox(height: 24),

                    // Daily Target Quests
                    Text(
                      'DAILY TARGET MILESTONES (TODAY)',
                      style: GoogleFonts.geist(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildQuestItem(
                      title: 'Tier 1: 6 Deliveries Completed',
                      bonus: '+₹120.00',
                      progress: 1.0,
                      progressText: '6 / 6 Completed',
                      isCompleted: true,
                    ),
                    const SizedBox(height: 10),
                    _buildQuestItem(
                      title: 'Tier 2: 12 Deliveries Goal',
                      bonus: '+₹250.00',
                      progress: 9 / 12,
                      progressText: '9 / 12 Completed (3 runs to go)',
                      isCompleted: false,
                    ),
                    const SizedBox(height: 10),
                    _buildQuestItem(
                      title: 'Tier 3: Super Fleet 18 Deliveries',
                      bonus: '+₹450.00',
                      progress: 0.0,
                      progressText: 'Unlocks after Tier 2 completion',
                      isCompleted: false,
                      isLocked: true,
                    ),
                    const SizedBox(height: 24),

                    // Weekly Mega Quest Card
                    Text(
                      'WEEKEND SUPER STREAK',
                      style: GoogleFonts.geist(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '35 Weekend Deliveries Quest',
                                style: GoogleFonts.fraunces(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '+₹1,200.00',
                                style: GoogleFonts.geist(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Complete 35 runs between Friday 6:00 PM and Sunday 11:59 PM with ≥90% acceptance.',
                            style: GoogleFonts.geist(
                              color: AppColors.textSecondary,
                              fontSize: 12.5,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 14),
                          LinearProgressIndicator(
                            value: 24 / 35,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                            backgroundColor: const Color(0xFFF5F5F4),
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '24 of 35 deliveries finished',
                                style: GoogleFonts.geist(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Ends in 14h 22m',
                                style: GoogleFonts.geist(
                                  color: const Color(0xFFB45309),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurgeCard({
    required String title,
    required String reward,
    required String timeWindow,
    required String zone,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      reward,
                      style: GoogleFonts.geist(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '$timeWindow • $zone',
                  style: GoogleFonts.geist(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestItem({
    required String title,
    required String bonus,
    required double progress,
    required String progressText,
    required bool isCompleted,
    bool isLocked = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked ? const Color(0xFFFAF7F2) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? const Color(0xFFBBF7D0) : AppColors.border,
          width: isCompleted ? 1.4 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.fraunces(
                    color: isLocked ? AppColors.textMuted : AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFDCFCE7)
                      : (isLocked ? const Color(0xFFE7E5E4) : const Color(0xFFFFF1F2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  bonus,
                  style: GoogleFonts.geist(
                    color: isCompleted
                        ? const Color(0xFF15803D)
                        : (isLocked ? AppColors.textMuted : AppColors.primary),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            borderRadius: BorderRadius.circular(3),
            backgroundColor: const Color(0xFFF5F5F4),
            valueColor: AlwaysStoppedAnimation<Color>(
              isCompleted ? const Color(0xFF16A34A) : AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (isCompleted) ...[
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF16A34A),
                  size: 14,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                progressText,
                style: GoogleFonts.geist(
                  color: isCompleted ? const Color(0xFF16A34A) : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
