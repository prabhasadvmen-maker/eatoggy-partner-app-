import 'package:equatable/equatable.dart';

class DailyEarningBreakdown extends Equatable {
  final String dateTitle;
  final String deliveriesCountText;
  final String amount;

  const DailyEarningBreakdown({
    required this.dateTitle,
    required this.deliveriesCountText,
    required this.amount,
  });

  @override
  List<Object?> get props => [dateTitle, deliveriesCountText, amount];
}

class EarningsDataModel extends Equatable {
  final String periodLabel;
  final String totalEarnings;
  final String deliveriesCount;
  final String avgPerDelivery;
  final String payoutStatus;
  final String availableBalance;
  final String settlementNote;
  final String bankInfo;
  final List<DailyEarningBreakdown> breakdowns;

  const EarningsDataModel({
    required this.periodLabel,
    required this.totalEarnings,
    required this.deliveriesCount,
    required this.avgPerDelivery,
    required this.payoutStatus,
    required this.availableBalance,
    required this.settlementNote,
    required this.bankInfo,
    required this.breakdowns,
  });

  static const sampleWeek = EarningsDataModel(
    periodLabel: 'Total Earnings This Week',
    totalEarnings: '₹4,250.00',
    deliveriesCount: '18',
    avgPerDelivery: '₹236.11',
    payoutStatus: 'PROCESSED',
    availableBalance: '₹2,800.00',
    settlementNote: 'COD collections are settled after 24 hrs',
    bankInfo: 'HDFC Bank ••••4521',
    breakdowns: [
      DailyEarningBreakdown(
        dateTitle: 'Today, 15 Oct',
        deliveriesCountText: '3 Deliveries',
        amount: '₹365.00',
      ),
      DailyEarningBreakdown(
        dateTitle: 'Yesterday, 14 Oct',
        deliveriesCountText: '6 Deliveries',
        amount: '₹1,450.00',
      ),
      DailyEarningBreakdown(
        dateTitle: '13 Oct, 2026',
        deliveriesCountText: '5 Deliveries',
        amount: '₹1,215.00',
      ),
    ],
  );

  static const sampleToday = EarningsDataModel(
    periodLabel: 'Total Earnings Today',
    totalEarnings: '₹365.00',
    deliveriesCount: '3',
    avgPerDelivery: '₹121.66',
    payoutStatus: 'PENDING',
    availableBalance: '₹2,800.00',
    settlementNote: 'COD collections are settled after 24 hrs',
    bankInfo: 'HDFC Bank ••••4521',
    breakdowns: [
      DailyEarningBreakdown(
        dateTitle: 'Today, 15 Oct',
        deliveriesCountText: '3 Deliveries',
        amount: '₹365.00',
      ),
    ],
  );

  static const sampleMonth = EarningsDataModel(
    periodLabel: 'Total Earnings This Month',
    totalEarnings: '₹16,840.00',
    deliveriesCount: '72',
    avgPerDelivery: '₹233.88',
    payoutStatus: 'PROCESSED',
    availableBalance: '₹2,800.00',
    settlementNote: 'COD collections are settled after 24 hrs',
    bankInfo: 'HDFC Bank ••••4521',
    breakdowns: [
      DailyEarningBreakdown(
        dateTitle: 'Week 2 (08 - 15 Oct)',
        deliveriesCountText: '36 Deliveries',
        amount: '₹8,420.00',
      ),
      DailyEarningBreakdown(
        dateTitle: 'Week 1 (01 - 07 Oct)',
        deliveriesCountText: '36 Deliveries',
        amount: '₹8,420.00',
      ),
    ],
  );

  @override
  List<Object?> get props => [
        periodLabel,
        totalEarnings,
        deliveriesCount,
        avgPerDelivery,
        payoutStatus,
        availableBalance,
        settlementNote,
        bankInfo,
        breakdowns,
      ];
}
