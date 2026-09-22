import 'package:equatable/equatable.dart';

abstract class EarningsEvent extends Equatable {
  const EarningsEvent();

  @override
  List<Object?> get props => [];
}

class LoadEarningsDataEvent extends EarningsEvent {
  const LoadEarningsDataEvent();
}

class ChangeTimePeriodEvent extends EarningsEvent {
  final String period;

  const ChangeTimePeriodEvent(this.period);

  @override
  List<Object?> get props => [period];
}

class WithdrawBalanceEvent extends EarningsEvent {
  const WithdrawBalanceEvent();
}
