import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/deliveries_bloc.dart';
import '../../bloc/deliveries_event.dart';
import '../../bloc/deliveries_state.dart';
import '../widgets/delivery_menu_card.dart';

import 'delivery_history_screen.dart';
import 'tiffin_subscribers_screen.dart';
import 'tiffin_zone_screen.dart';
import 'today_assignments_screen.dart';

class DeliveriesScreen extends StatelessWidget {
  const DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveriesBloc()..add(const LoadDeliveriesData()),
      child: const DeliveriesView(),
    );
  }
}

class DeliveriesView extends StatelessWidget {
  const DeliveriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveriesBloc, DeliveriesState>(
      builder: (context, state) {
        if (state.selectedCategoryId == 'todays_deliveries') {
          return TodayAssignmentsScreen(
            onBack: () {
              context
                  .read<DeliveriesBloc>()
                  .add(const ClearCategorySelectionEvent());
            },
          );
        }

        if (state.selectedCategoryId == 'delivery_history') {
          return DeliveryHistoryScreen(
            onBack: () {
              context
                  .read<DeliveriesBloc>()
                  .add(const ClearCategorySelectionEvent());
            },
          );
        }

        if (state.selectedCategoryId == 'tiffin_zone') {
          return TiffinZoneScreen(
            onBack: () {
              context
                  .read<DeliveriesBloc>()
                  .add(const ClearCategorySelectionEvent());
            },
          );
        }

        if (state.selectedCategoryId == 'tiffin_subscribers') {
          return TiffinSubscribersScreen(
            onBack: () {
              context
                  .read<DeliveriesBloc>()
                  .add(const ClearCategorySelectionEvent());
            },
          );
        }

        final categories = state.categories;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header Title (Fraunces)
                  Text(
                    state.headerTitle,
                    style: GoogleFonts.fraunces(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Page Header Subtitle (Stone Gray)
                  Text(
                    state.headerSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2x2 Menu Cards matching DELIVERY NAV.svg
                  if (categories.length >= 4) ...[
                    // Row 1: Today's Deliveries & Delivery History
                    SizedBox(
                      height: 165,
                      child: Row(
                        children: [
                          Expanded(
                            child: DeliveryMenuCard(
                              item: categories[0],
                              onTap: () {
                                context.read<DeliveriesBloc>().add(
                                      CategoryTappedEvent(categories[0].id),
                                    );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: DeliveryMenuCard(
                              item: categories[1],
                              onTap: () {
                                context.read<DeliveriesBloc>().add(
                                      CategoryTappedEvent(categories[1].id),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Row 2: Tiffin Zone & Tiffin Subscribers
                    SizedBox(
                      height: 165,
                      child: Row(
                        children: [
                          Expanded(
                            child: DeliveryMenuCard(
                              item: categories[2],
                              onTap: () {
                                context.read<DeliveriesBloc>().add(
                                      CategoryTappedEvent(categories[2].id),
                                    );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: DeliveryMenuCard(
                              item: categories[3],
                              onTap: () {
                                context.read<DeliveriesBloc>().add(
                                      CategoryTappedEvent(categories[3].id),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
