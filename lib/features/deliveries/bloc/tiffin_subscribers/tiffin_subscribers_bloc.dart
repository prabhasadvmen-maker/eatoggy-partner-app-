import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/tiffin_subscriber_model.dart';
import 'tiffin_subscribers_event.dart';
import 'tiffin_subscribers_state.dart';

class TiffinSubscribersBloc
    extends Bloc<TiffinSubscribersEvent, TiffinSubscribersState> {
  TiffinSubscribersBloc() : super(const TiffinSubscribersState()) {
    on<LoadTiffinSubscribersEvent>(_onLoadSubscribers);
    on<FilterSubscribersEvent>(_onFilterSubscribers);
  }

  void _onLoadSubscribers(
    LoadTiffinSubscribersEvent event,
    Emitter<TiffinSubscribersState> emit,
  ) {
    const list = TiffinSubscriberModel.sampleSubscribers;
    final filtered = _filterList(list, state.selectedFilter);

    emit(state.copyWith(
      status: SubscribersStateStatus.loaded,
      allSubscribers: list,
      filteredSubscribers: filtered,
    ));
  }

  void _onFilterSubscribers(
    FilterSubscribersEvent event,
    Emitter<TiffinSubscribersState> emit,
  ) {
    final filtered = _filterList(state.allSubscribers, event.filter);

    emit(state.copyWith(
      selectedFilter: event.filter,
      filteredSubscribers: filtered,
    ));
  }

  List<TiffinSubscriberModel> _filterList(
    List<TiffinSubscriberModel> list,
    String filter,
  ) {
    switch (filter) {
      case 'Active':
        return list
            .where((item) => item.status == SubscriberStatus.active)
            .toList();
      case 'Paused':
        return list
            .where((item) => item.status == SubscriberStatus.paused)
            .toList();
      case 'New':
        return list.where((item) => item.isNew).toList();
      case 'All':
      default:
        return list;
    }
  }
}
