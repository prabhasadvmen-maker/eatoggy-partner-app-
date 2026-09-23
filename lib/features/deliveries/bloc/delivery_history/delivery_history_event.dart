import 'package:equatable/equatable.dart';

abstract class DeliveryHistoryEvent extends Equatable {
  const DeliveryHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryHistoryEvent extends DeliveryHistoryEvent {
  const LoadDeliveryHistoryEvent();
}

class FilterHistoryEvent extends DeliveryHistoryEvent {
  final String filter;

  const FilterHistoryEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
