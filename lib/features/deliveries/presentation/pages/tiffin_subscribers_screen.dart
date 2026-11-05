import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_bloc.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_event.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_state.dart';
import '../widgets/subscriber_card.dart';
import 'tiffin_delivery_detail_screen.dart';

class TiffinSubscribersScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const TiffinSubscribersScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TiffinSubscribersBloc()..add(const LoadTiffinSubscribersEvent()),
      child: TiffinSubscribersView(onBack: onBack),
    );
  }
}

class TiffinSubscribersView extends StatelessWidget {
  final VoidCallback? onBack;

  const TiffinSubscribersView({super.key, this.onBack});

  static const List<String> _filters = [
    'All',
    'Active',
    'Paused',
    'New',
  ];

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
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: BlocBuilder<TiffinSubscribersBloc, TiffinSubscribersState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header & Filter Chips
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row: Back Arrow + Title/Subtitle + "24 TOTAL" Badge
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (onBack != null) {
                                  onBack!();
                                } else if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 38,
                                height: 38,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 1.0,
                                  ),
                                  boxShadow: AppShadows.card,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.textPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tiffin Subscribers',
                                    style: GoogleFonts.fraunces(
                                      color: AppColors.textPrimary,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Manage your recurring customers',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                '${state.totalCount} TOTAL',
                                style: GoogleFonts.inter(
                                  color: AppColors.primary,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Horizontal Filter Chips Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: _filters.map((filter) {
                              final isSelected = state.selectedFilter == filter;

                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<TiffinSubscribersBloc>().add(
                                          FilterSubscribersEvent(filter),
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.surface,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary
                                            : AppColors.border,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Text(
                                      filter,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),

                  // Subscribers List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: state.filteredSubscribers.length,
                      itemBuilder: (context, index) {
                        final subscriber = state.filteredSubscribers[index];
                        return SubscriberCard(
                          subscriber: subscriber,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TiffinDeliveryDetailScreen(
                                  customerName: subscriber.name,
                                  address: subscriber.address,
                                ),
                              ),
                            );
                          },
                          onViewHistory: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TiffinDeliveryDetailScreen(
                                  customerName: subscriber.name,
                                  address: subscriber.address,
                                ),
                              ),
                            );
                          },
                        );
                      },
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
}
