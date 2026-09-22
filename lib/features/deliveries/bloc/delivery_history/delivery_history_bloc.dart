import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/delivery_history_model.dart';
import 'delivery_history_event.dart';
import 'delivery_history_state.dart';

class DeliveryHistoryBloc
    extends Bloc<DeliveryHistoryEvent, DeliveryHistoryState> {
  DeliveryHistoryBloc() : super(const DeliveryHistoryState()) {
    on<LoadDeliveryHistoryEvent>(_onLoadHistory);
    on<FilterHistoryEvent>(_onFilterHistory);
  }

  void _onLoadHistory(
    LoadDeliveryHistoryEvent event,
    Emitter<DeliveryHistoryState> emit,
  ) {
    const list = DeliveryHistoryModel.sampleHistory;
    final filtered = _filterList(list, state.selectedFilter);

    emit(state.copyWith(
      status: HistoryStateStatus.loaded,
      allHistory: list,
      filteredHistory: filtered,
    ));
  }

  void _onFilterHistory(
    FilterHistoryEvent event,
    Emitter<DeliveryHistoryState> emit,
  ) {
    final filtered = _filterList(state.allHistory, event.filter);

    emit(state.copyWith(
      selectedFilter: event.filter,
      filteredHistory: filtered,
    ));
  }

  List<DeliveryHistoryModel> _filterList(
    List<DeliveryHistoryModel> list,
    String filter,
  ) {
    switch (filter) {
      case 'Today':
        return list.where((item) => item.timeFilter == 'Today').toList();
      case 'This Week':
        return list
            .where((item) =>
                item.timeFilter == 'Today' || item.timeFilter == 'This Week')
            .toList();
      case 'This Month':
        return list
            .where((item) =>
                item.timeFilter == 'Today' ||
                item.timeFilter == 'This Week' ||
                item.timeFilter == 'This Month')
            .toList();
      case 'Custom':
      default:
        return list;
    }
  }
}
