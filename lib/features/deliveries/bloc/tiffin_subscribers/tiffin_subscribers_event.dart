import 'package:equatable/equatable.dart';

abstract class TiffinSubscribersEvent extends Equatable {
  const TiffinSubscribersEvent();

  @override
  List<Object?> get props => [];
}

class LoadTiffinSubscribersEvent extends TiffinSubscribersEvent {
  const LoadTiffinSubscribersEvent();
}

class FilterSubscribersEvent extends TiffinSubscribersEvent {
  final String filter;

  const FilterSubscribersEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
