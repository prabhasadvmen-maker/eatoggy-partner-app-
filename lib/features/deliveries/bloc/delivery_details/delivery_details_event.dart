import 'package:equatable/equatable.dart';

abstract class DeliveryDetailsEvent extends Equatable {
  const DeliveryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDeliveryDetailsEvent extends DeliveryDetailsEvent {
  final String orderId;

  const LoadDeliveryDetailsEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class ConfirmPickupEvent extends DeliveryDetailsEvent {
  const ConfirmPickupEvent();
}

class CallCustomerEvent extends DeliveryDetailsEvent {
  const CallCustomerEvent();
}

class CopyAddressEvent extends DeliveryDetailsEvent {
  const CopyAddressEvent();
}
