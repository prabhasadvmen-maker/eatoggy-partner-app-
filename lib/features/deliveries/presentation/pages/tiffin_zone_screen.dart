import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/tiffin_zone/tiffin_zone_bloc.dart';
import '../../bloc/tiffin_zone/tiffin_zone_event.dart';
import '../../bloc/tiffin_zone/tiffin_zone_state.dart';
import '../widgets/tiffin_route_card.dart';
import '../widgets/zone_radar_card.dart';

class TiffinZoneScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const TiffinZoneScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TiffinZoneBloc()..add(const LoadTiffinZoneDataEvent()),
      child: TiffinZoneView(onBack: onBack),
    );
  }
}

class TiffinZoneView extends StatelessWidget {
  final VoidCallback? onBack;

  const TiffinZoneView({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onBack != null) {
          onBack!();
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: BlocConsumer<TiffinZoneBloc, TiffinZoneState>(
            listener: (context, state) {
              if (state.statusMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF1E1E20),
                    content: Text(
                      state.statusMessage!,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.cardGoldAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              final zone = state.zone;
              if (zone == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.cardGoldAccent,
                  ),
                );
              }

              return Column(
                children: [
                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Back Icon, Title, Subtitle, and Radius Badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (onBack != null) ...[
                                GestureDetector(
                                  onTap: onBack,
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1B1B1D),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF2C2C2E),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: AppColors.creamText,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      zone.title,
                                      style: AppTextStyles.displayLarge.copyWith(
                                        color: AppColors.creamText,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      zone.subtitle,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        color: AppColors.textMutedDark,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.cardGoldAccent,
                                    width: 0.9,
                                  ),
                                ),
                                child: Text(
                                  zone.radiusBadge,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.cardGoldAccent,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Zone Radar Map Card
                          ZoneRadarCard(
                            zoneName: zone.zoneName,
                            zoneSubtitle: zone.zoneSubtitle,
                          ),
                          const SizedBox(height: 14),

                          // 3 Summary Stats Cards Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  label: 'Subscribers',
                                  value: zone.subscribersCount,
                                  valueColor: AppColors.cardGoldAccent,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildStatCard(
                                  label: "Today's Runs",
                                  value: zone.todayRuns,
                                  valueColor: AppColors.creamText,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildStatCard(
                                  label: 'Completed',
                                  value: zone.completedRuns,
                                  valueColor: const Color(0xFF00E676),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),

                          // Section Title: "Today's Tiffin Route"
                          Text(
                            "Today's Tiffin Route",
                            style: AppTextStyles.headingSmall.copyWith(
                              color: AppColors.creamText,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Route Cards List
                          ...zone.routeStops.map(
                            (stop) => TiffinRouteCard(stop: stop),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Pinned Button: "Start Tiffin Route"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<TiffinZoneBloc>()
                              .add(const StartTiffinRouteEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardGoldAccent,
                          foregroundColor: const Color(0xFF11110F),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          state.isRouteStarted
                              ? 'Route In Progress'
                              : 'Start Tiffin Route',
                          style: AppTextStyles.button.copyWith(
                            color: const Color(0xFF11110F),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF171719),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF262628),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textMutedDark,
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppTextStyles.displayLarge.copyWith(
                color: valueColor,
                fontSize: 18.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
