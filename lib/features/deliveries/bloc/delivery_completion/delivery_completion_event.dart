import 'package:equatable/equatable.dart';

abstract class DeliveryCompletionEvent extends Equatable {
  const DeliveryCompletionEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryCompletionEvent extends DeliveryCompletionEvent {
  final String orderId;

  const LoadDeliveryCompletionEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class NextDeliveryTappedEvent extends DeliveryCompletionEvent {
  const NextDeliveryTappedEvent();
}

class BackToDashboardTappedEvent extends DeliveryCompletionEvent {
  const BackToDashboardTappedEvent();
}
