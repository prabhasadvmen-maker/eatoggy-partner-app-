import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../shared/models/app_models.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../../../notifications/presentation/pages/notifications_screen.dart';
import '../../../deliveries/presentation/pages/delivery_details_screen.dart';
import '../../../deliveries/presentation/pages/active_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(Restaurant)? onRestaurantTap;

  const HomeScreen({super.key, this.onRestaurantTap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const LoadDashboardData()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _dismissedReminder = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.showNotifications) {
          return NotificationsScreen(
            onBack: () => context
                .read<HomeBloc>()
                .add(const ToggleNotificationsViewEvent(false)),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Profile Avatar, Partner Info, Notification Bell & Online Status Toggle
                _buildHeader(context, state),
                const SizedBox(height: 18),

                // Urgent Alert Banner (d03-dashboard-1.svg)
                if (!_dismissedReminder) ...[
                  _buildReminderBanner(context),
                  const SizedBox(height: 16),
                ],

                // Top Stats Row: Total Earnings & Deliveries
                _buildStatsCards(state),
                const SizedBox(height: 16),

                // Today's Breakdown
                _buildBreakdownCard(state),
                const SizedBox(height: 18),

                // Active Quests & Surges Banner (Screen #3: IncentiveQuestsScreen)
                GestureDetector(
                  onTap: () => context.push(AppRoutes.incentiveQuests),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD97706).withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.military_tech_rounded,
                            color: Color(0xFFD97706),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Active Quests & Surges',
                                    style: GoogleFonts.geist(
                                      color: const Color(0xFF92400E),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD97706),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'LIVE',
                                      style: GoogleFonts.geist(
                                        color: Colors.white,
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Complete 4 more orders to unlock +₹250 bonus',
                                style: GoogleFonts.geist(
                                  color: const Color(0xFFB45309),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFFD97706),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Incoming Order Radar Preview Banner (Screen #1: IncomingOrderModalScreen)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDC2626),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.radar_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Incoming Order Dispatch',
                              style: GoogleFonts.geist(
                                color: const Color(0xFF991B1B),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Simulate live 30s countdown dispatch modal',
                              style: GoogleFonts.geist(
                                color: const Color(0xFFB91C1C),
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.push(AppRoutes.incomingOrder),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC2626),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Test Run',
                          style: GoogleFonts.geist(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Next Delivery Action Section Header
                Text(
                  'Next Delivery Action',
                  style: GoogleFonts.fraunces(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 14),

                // Delivery Action Cards List
                ...state.nextDeliveries.map(
                  (action) => _buildDeliveryCard(context, action),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, HomeState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Avatar with fallback
        ClipOval(
          child: Image.asset(
            'assets/images/kabir_avatar.jpg',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.surfaceSubtle,
              child: Text(
                state.partnerName.isNotEmpty ? state.partnerName[0] : 'K',
                style: GoogleFonts.fraunces(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Partner Name & Partner ID
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.partnerName,
                style: GoogleFonts.fraunces(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Partner ID: ${state.partnerId}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // Notification Bell Icon with Red Dot
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context
                .read<HomeBloc>()
                .add(const ToggleNotificationsViewEvent(true));
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
                Positioned(
                  right: 9,
                  top: 9,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ONLINE / OFFLINE Status Badge Pill
        GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(const ToggleOnlineStatus());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: state.isOnline ? AppColors.successLight : AppColors.errorLight,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: state.isOnline
                    ? AppColors.success.withValues(alpha: 0.3)
                    : AppColors.error.withValues(alpha: 0.3),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: state.isOnline ? AppColors.successDark : AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  state.isOnline ? 'ONLINE' : 'OFFLINE',
                  style: TextStyle(
                    color: state.isOnline ? AppColors.successText : AppColors.error,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: AppRadius.borderLg,
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_filled_rounded,
              color: Color(0xFFD97706),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tiffin Pickup Reminder',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF92400E),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pickup in 15 minutes!',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB45309),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: Color(0xFF92400E)),
            onPressed: () {
              setState(() {
                _dismissedReminder = true;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(HomeState state) {
    return Row(
      children: [
        // Total Earnings Card
        Expanded(
          child: AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Earnings',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.totalEarnings,
                  style: GoogleFonts.fraunces(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Deliveries Card
        Expanded(
          child: AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliveries',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.completedDeliveries} / ${state.totalTargetDeliveries}',
                  style: GoogleFonts.fraunces(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownCard(HomeState state) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Breakdown",
            style: GoogleFonts.fraunces(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Completed
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownCompleted}',
                      style: const TextStyle(
                        color: AppColors.successDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Completed',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 32, width: 1, color: AppColors.border),

              // Pending
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownPending}',
                      style: const TextStyle(
                        color: AppColors.warning,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pending',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 32, width: 1, color: AppColors.border),

              // Rejected
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownRejected}',
                      style: const TextStyle(
                        color: AppColors.error,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rejected',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(
    BuildContext context,
    PartnerDeliveryAction action,
  ) {
    final bool isCod = action.paymentType.toUpperCase() == 'COD';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID & Badges Row
            Row(
              children: [
                Text(
                  'Order #${action.orderId}',
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),

                // Status Badge (e.g. PICKUP PENDING)
                StatusBadge(text: action.status),
                const SizedBox(width: 8),

                // Payment Type Badge (COD in amber badge, PREPAID in green badge)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCod ? AppColors.warningBadgeBg : AppColors.successLight,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    action.paymentType,
                    style: TextStyle(
                      color: isCod ? AppColors.warning : AppColors.successText,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pickup Location Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.radio_button_checked,
                    color: AppColors.primary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    action.pickupAddress,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Dropoff Location Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    action.dropAddress,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons Row: "View Order" & "Start Navigation"
            Row(
              children: [
                // View Order Button
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                          ViewOrderEvent(action.orderId),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DeliveryDetailsScreen(
                              orderId: action.orderId,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(
                          color: AppColors.border,
                          width: 1.2,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.borderMd,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'View Order',
                        style: GoogleFonts.inter(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Start Navigation Button
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(
                          StartNavigationEvent(action.orderId),
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActiveNavigationScreen(
                              orderId: action.orderId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.borderMd,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Start Navigation',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
