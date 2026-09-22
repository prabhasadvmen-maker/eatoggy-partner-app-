import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/today_assignments/today_assignments_bloc.dart';
import '../../bloc/today_assignments/today_assignments_event.dart';
import '../../bloc/today_assignments/today_assignments_state.dart';
import '../widgets/assignment_card.dart';

class TodayAssignmentsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const TodayAssignmentsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodayAssignmentsBloc()..add(const LoadTodayAssignmentsEvent()),
      child: TodayAssignmentsView(onBack: onBack),
    );
  }
}

class TodayAssignmentsView extends StatelessWidget {
  final VoidCallback? onBack;

  const TodayAssignmentsView({super.key, this.onBack});

  static const List<String> _filters = [
    'All',
    'Pending',
    'In Progress',
    'Delivered',
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
          child: BlocBuilder<TodayAssignmentsBloc, TodayAssignmentsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header & Filter Chips (Pinned at top)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    "Today's Assignments",
                                    style: AppTextStyles.displayLarge.copyWith(
                                      color: AppColors.creamText,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${state.totalScheduled} Scheduled Deliveries',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textMutedDark,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
                              final isSelected =
                                  state.selectedFilter == filter;

                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<TodayAssignmentsBloc>().add(
                                          FilterAssignmentsEvent(filter),
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
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

                  // Assignment Cards List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: state.filteredAssignments.length,
                      itemBuilder: (context, index) {
                        final assignment = state.filteredAssignments[index];
                        return AssignmentCard(
                          assignment: assignment,
                          onTap: () {},
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
