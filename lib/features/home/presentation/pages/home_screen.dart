import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const Color _screenBg = Color(0xFF111111);
  static const Color _cardBg = Color(0xFF1A1A1C);
  static const Color _cardBorder = Color(0xFF262628);
  static const Color _goldColor = Color(0xFFE5A64E);
  static const Color _textMuted = Color(0xFF8E8E93);
  static const Color _greenOnline = Color(0xFF00E676);

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
          backgroundColor: _screenBg,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header: Profile Avatar, Partner Info, Notification & Status Toggle
                _buildHeader(context, state),
                const SizedBox(height: 20),

                // Top Stats Row: Total Earnings & Deliveries
                _buildStatsCards(state),
                const SizedBox(height: 16),

                // Today's Breakdown
                _buildBreakdownCard(state),
                const SizedBox(height: 24),

                // Next Delivery Action Section Header
                Text(
                  'Next Delivery Action',
                  style: GoogleFonts.fraunces(
                    color: const Color(0xFFFFF1D2),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
        // Profile Avatar matching the cropped image (Olive green background, navy/orange polo)
        ClipOval(
          child: Image.asset(
            'assets/images/kabir_avatar.jpg',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFF707C54),
              child: Text(
                state.partnerName.isNotEmpty ? state.partnerName[0] : 'K',
                style: GoogleFonts.fraunces(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Partner Name (Warm Ivory Serif Fraunces) & ID (Clean Sans-serif)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.partnerName,
                style: GoogleFonts.fraunces(
                  color: const Color(0xFFFFF1D2),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Partner ID: ${state.partnerId}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF8E8E93),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),

        // Notification Bell Icon with Red Dot on top-right shoulder
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            context
                .read<HomeBloc>()
                .add(const ToggleNotificationsViewEvent(true));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: _goldColor,
                      size: 26,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    top: 0,
                    child: Container(
                      width: 7.5,
                      height: 7.5,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE54D4D),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ONLINE / OFFLINE Status Badge Pill
        GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(const ToggleOnlineStatus());
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 5, 5, 5),
            decoration: BoxDecoration(
              color: state.isOnline
                  ? const Color(0xFF0C1E14)
                  : const Color(0xFF261214),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: state.isOnline ? _greenOnline : const Color(0xFFFF5252),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.isOnline ? 'ONLINE' : 'OFFLINE',
                  style: GoogleFonts.inter(
                    color: state.isOnline ? _greenOnline : const Color(0xFFFF5252),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: state.isOnline ? _greenOnline : const Color(0xFFFF5252),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(HomeState state) {
    return Row(
      children: [
        // Total Earnings Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cardBorder, width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Earnings',
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.totalEarnings,
                  style: GoogleFonts.fraunces(
                    color: _goldColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cardBorder, width: 0.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Deliveries',
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${state.completedDeliveries} / ${state.totalTargetDeliveries}',
                  style: GoogleFonts.fraunces(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Breakdown",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              // Completed
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownCompleted}',
                      style: const TextStyle(
                        color: _greenOnline,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Completed',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 32, width: 1, color: _cardBorder),

              // Pending
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownPending}',
                      style: const TextStyle(
                        color: Color(0xFFF5A623),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Pending',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 32, width: 1, color: _cardBorder),

              // Rejected
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${state.breakdownRejected}',
                      style: const TextStyle(
                        color: Color(0xFFFF5252),
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Rejected',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _goldColor.withValues(alpha: 0.8),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Badges Row
          Row(
            children: [
              Text(
                'Order #${action.orderId}',
                style: const TextStyle(
                  color: _goldColor,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),

              // Status Badge (e.g. PICKUP PENDING)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF261214),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF7A2428),
                    width: 1,
                  ),
                ),
                child: Text(
                  action.status,
                  style: const TextStyle(
                    color: Color(0xFFE54D4D),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Payment Type Badge (COD in gold, PREPAID in green)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isCod ? _goldColor : _greenOnline,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  action.paymentType,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Pickup Location Row
          Row(
            children: [
              const Icon(
                Icons.cancel_outlined,
                color: _textMuted,
                size: 19,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  action.pickupAddress,
                  style: const TextStyle(
                    color: Color(0xFFC7C7CC),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dropoff Location Row
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: _goldColor,
                size: 19,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  action.dropAddress,
                  style: const TextStyle(
                    color: Color(0xFFE5E5EA),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Action Buttons Row: "View Order" & "Start Navigation"
          Row(
            children: [
              // View Order Button
              Expanded(
                child: SizedBox(
                  height: 48,
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
                      backgroundColor: const Color(0xFF181818),
                      side: const BorderSide(
                        color: Color(0xFF2C2C2E),
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'View Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Start Navigation Button
              Expanded(
                child: SizedBox(
                  height: 48,
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
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF3C06D),
                            _goldColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Start Navigation',
                          style: TextStyle(
                            color: Color(0xFF121212),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
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

