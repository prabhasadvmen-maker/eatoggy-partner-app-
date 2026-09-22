import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/delivery_assignment_model.dart';
import 'today_assignments_event.dart';
import 'today_assignments_state.dart';

class TodayAssignmentsBloc
    extends Bloc<TodayAssignmentsEvent, TodayAssignmentsState> {
  TodayAssignmentsBloc() : super(const TodayAssignmentsState()) {
    on<LoadTodayAssignmentsEvent>(_onLoadAssignments);
    on<FilterAssignmentsEvent>(_onFilterAssignments);
  }

  void _onLoadAssignments(
    LoadTodayAssignmentsEvent event,
    Emitter<TodayAssignmentsState> emit,
  ) {
    const list = DeliveryAssignmentModel.sampleAssignments;
    final filtered = _filterList(list, state.selectedFilter);

    emit(state.copyWith(
      status: AssignmentsStatus.loaded,
      allAssignments: list,
      filteredAssignments: filtered,
    ));
  }

  void _onFilterAssignments(
    FilterAssignmentsEvent event,
    Emitter<TodayAssignmentsState> emit,
  ) {
    final filtered = _filterList(state.allAssignments, event.filter);

    emit(state.copyWith(
      selectedFilter: event.filter,
      filteredAssignments: filtered,
    ));
  }

  List<DeliveryAssignmentModel> _filterList(
    List<DeliveryAssignmentModel> list,
    String filter,
  ) {
    switch (filter) {
      case 'Pending':
        return list
            .where((item) => item.status == AssignmentStatus.pending)
            .toList();
      case 'In Progress':
        return list
            .where((item) =>
                item.status == AssignmentStatus.outForDelivery ||
                item.status == AssignmentStatus.readyToPickup)
            .toList();
      case 'Delivered':
        return list
            .where((item) => item.status == AssignmentStatus.delivered)
            .toList();
      case 'All':
      default:
        return list;
    }
  }
}
