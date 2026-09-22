import 'package:equatable/equatable.dart';

abstract class ActiveTourEvent extends Equatable {
  const ActiveTourEvent();

  @override
  List<Object?> get props => [];
}

class LoadActiveTourEvent extends ActiveTourEvent {
  final String orderId;

  const LoadActiveTourEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class VerifyOtpEvent extends ActiveTourEvent {
  final String enteredOtp;

  const VerifyOtpEvent(this.enteredOtp);

  @override
  List<Object?> get props => [enteredOtp];
}

class InitiateCustomerCallEvent extends ActiveTourEvent {
  const InitiateCustomerCallEvent();
}

class DismissTourEvent extends ActiveTourEvent {
  const DismissTourEvent();
}
