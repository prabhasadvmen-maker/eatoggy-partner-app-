import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_bloc.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_event.dart';
import '../../bloc/tiffin_subscribers/tiffin_subscribers_state.dart';
import '../widgets/subscriber_card.dart';

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
        backgroundColor: AppColors.darkBackground,
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
                                    'Tiffin Subscribers',
                                    style: AppTextStyles.displayLarge.copyWith(
                                      color: AppColors.creamText,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Manage your recurring customers',
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
                                '${state.totalCount} TOTAL',
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

                        // Horizontal Filter Chips Row
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: _filters.map((filter) {
                              final isSelected = state.selectedFilter == filter;

                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<TiffinSubscribersBloc>().add(
                                          FilterSubscribersEvent(filter),
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 9,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.cardGoldAccent
                                          : const Color(0xFF1B1B1D),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.cardGoldAccent
                                            : const Color(0xFF2C2C2E),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Text(
                                      filter,
                                      style: AppTextStyles.caption.copyWith(
                                        color: isSelected
                                            ? const Color(0xFF11110F)
                                            : AppColors.textPrimaryDark,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                          onTap: () {},
                          onViewHistory: () {},
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
