import 'package:equatable/equatable.dart';

abstract class ActiveNavigationEvent extends Equatable {
  const ActiveNavigationEvent();

  @override
  List<Object?> get props => [];
}

class LoadActiveNavigationEvent extends ActiveNavigationEvent {
  final String orderId;

  const LoadActiveNavigationEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class OpenGoogleMapsEvent extends ActiveNavigationEvent {
  const OpenGoogleMapsEvent();
}

class MarkArrivedEvent extends ActiveNavigationEvent {
  const MarkArrivedEvent();
}
