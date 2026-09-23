import 'package:equatable/equatable.dart';

abstract class TodayAssignmentsEvent extends Equatable {
  const TodayAssignmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodayAssignmentsEvent extends TodayAssignmentsEvent {
  const LoadTodayAssignmentsEvent();
}

class FilterAssignmentsEvent extends TodayAssignmentsEvent {
  final String filter;

  const FilterAssignmentsEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
