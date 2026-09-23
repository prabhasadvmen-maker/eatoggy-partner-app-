import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/earnings_model.dart';
import 'earnings_event.dart';
import 'earnings_state.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  EarningsBloc() : super(const EarningsState()) {
    on<LoadEarningsDataEvent>(_onLoadData);
    on<ChangeTimePeriodEvent>(_onChangePeriod);
    on<WithdrawBalanceEvent>(_onWithdraw);
  }

  void _onLoadData(
    LoadEarningsDataEvent event,
    Emitter<EarningsState> emit,
  ) {
    final data = _getDataForPeriod(state.selectedPeriod);
    emit(state.copyWith(
      status: EarningsStatus.loaded,
      earningsData: data,
    ));
  }

  void _onChangePeriod(
    ChangeTimePeriodEvent event,
    Emitter<EarningsState> emit,
  ) {
    final data = _getDataForPeriod(event.period);
    emit(state.copyWith(
      selectedPeriod: event.period,
      earningsData: data,
    ));
  }

  void _onWithdraw(
    WithdrawBalanceEvent event,
    Emitter<EarningsState> emit,
  ) {
    emit(state.copyWith(
      statusMessage: 'Withdrawal request of ${state.earningsData?.availableBalance ?? "balance"} initiated successfully!',
    ));
  }

  EarningsDataModel _getDataForPeriod(String period) {
    switch (period) {
      case 'Today':
        return EarningsDataModel.sampleToday;
      case 'This Month':
        return EarningsDataModel.sampleMonth;
      case 'This Week':
      default:
        return EarningsDataModel.sampleWeek;
    }
  }
}
