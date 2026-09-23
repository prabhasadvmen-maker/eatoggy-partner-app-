import 'package:equatable/equatable.dart';

abstract class CustomerCallEvent extends Equatable {
  const CustomerCallEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomerCallEvent extends CustomerCallEvent {
  final String orderId;

  const LoadCustomerCallEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class TriggerVoiceCallEvent extends CustomerCallEvent {
  const TriggerVoiceCallEvent();
}

class SendQuickMessageEvent extends CustomerCallEvent {
  final String message;

  const SendQuickMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}
