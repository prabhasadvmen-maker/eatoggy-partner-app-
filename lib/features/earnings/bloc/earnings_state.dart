import 'package:equatable/equatable.dart';
import '../data/models/earnings_model.dart';

enum EarningsStatus { initial, loading, loaded, error }

class EarningsState extends Equatable {
  final EarningsStatus status;
  final String selectedPeriod;
  final EarningsDataModel? earningsData;
  final bool isWithdrawing;
  final String? statusMessage;

  const EarningsState({
    this.status = EarningsStatus.initial,
    this.selectedPeriod = 'This Week',
    this.earningsData,
    this.isWithdrawing = false,
    this.statusMessage,
  });

  EarningsState copyWith({
    EarningsStatus? status,
    String? selectedPeriod,
    EarningsDataModel? earningsData,
    bool? isWithdrawing,
    String? statusMessage,
  }) {
    return EarningsState(
      status: status ?? this.status,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      earningsData: earningsData ?? this.earningsData,
      isWithdrawing: isWithdrawing ?? this.isWithdrawing,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedPeriod,
        earningsData,
        isWithdrawing,
        statusMessage,
      ];
}
