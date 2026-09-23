import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/earnings_bloc.dart';
import '../../bloc/earnings_event.dart';
import '../../bloc/earnings_state.dart';
import '../widgets/earnings_breakdown_card.dart';
import '../widgets/earnings_overview_card.dart';
import '../widgets/withdraw_money_card.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EarningsBloc()..add(const LoadEarningsDataEvent()),
      child: const EarningsView(),
    );
  }
}

class EarningsView extends StatelessWidget {
  const EarningsView({super.key});

  static const List<String> _periods = [
    'Today',
    'This Week',
    'This Month',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: BlocConsumer<EarningsBloc, EarningsState>(
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
            final data = state.earningsData;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.cardGoldAccent,
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Segmented Time Period Bar
                  Container(
                    height: 46,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF171719),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF262628),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      children: _periods.map((period) {
                        final isSelected = state.selectedPeriod == period;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<EarningsBloc>()
                                  .add(ChangeTimePeriodEvent(period));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF222225)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xFF333336),
                                        width: 0.8,
                                      )
                                    : null,
                              ),
                              child: Text(
                                period,
                                style: AppTextStyles.caption.copyWith(
                                  color: isSelected
                                      ? AppColors.cardGoldAccent
                                      : AppColors.textMutedDark,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
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

                  // Earnings Overview Card
                  EarningsOverviewCard(data: data),
                  const SizedBox(height: 22),

                  // Section: "Withdraw Money"
                  Text(
                    'Withdraw Money',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.creamText,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Withdraw Money Card
                  WithdrawMoneyCard(
                    availableBalance: data.availableBalance,
                    settlementNote: data.settlementNote,
                    bankInfo: data.bankInfo,
                    onWithdraw: () {
                      context
                          .read<EarningsBloc>()
                          .add(const WithdrawBalanceEvent());
                    },
                    onChangeBank: () {},
                  ),
                  const SizedBox(height: 22),

                  // Section: "Breakdown"
                  Text(
                    'Breakdown',
                    style: AppTextStyles.headingSmall.copyWith(
                      color: AppColors.creamText,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Daily Breakdown Cards
                  ...data.breakdowns.map(
                    (breakdown) => EarningsBreakdownCard(breakdown: breakdown),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
