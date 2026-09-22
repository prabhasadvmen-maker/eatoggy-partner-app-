import 'package:equatable/equatable.dart';
import '../../data/models/delivery_assignment_model.dart';

enum AssignmentsStatus { initial, loading, loaded, error }

class TodayAssignmentsState extends Equatable {
  final AssignmentsStatus status;
  final List<DeliveryAssignmentModel> allAssignments;
  final List<DeliveryAssignmentModel> filteredAssignments;
  final String selectedFilter;
  final int totalScheduled;

  const TodayAssignmentsState({
    this.status = AssignmentsStatus.initial,
    this.allAssignments = const [],
    this.filteredAssignments = const [],
    this.selectedFilter = 'Pending',
    this.totalScheduled = 15,
  });

  TodayAssignmentsState copyWith({
    AssignmentsStatus? status,
    List<DeliveryAssignmentModel>? allAssignments,
    List<DeliveryAssignmentModel>? filteredAssignments,
    String? selectedFilter,
    int? totalScheduled,
  }) {
    return TodayAssignmentsState(
      status: status ?? this.status,
      allAssignments: allAssignments ?? this.allAssignments,
      filteredAssignments: filteredAssignments ?? this.filteredAssignments,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      totalScheduled: totalScheduled ?? this.totalScheduled,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allAssignments,
        filteredAssignments,
        selectedFilter,
        totalScheduled,
      ];
}
