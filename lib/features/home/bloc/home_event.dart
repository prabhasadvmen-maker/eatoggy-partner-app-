import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboardData extends HomeEvent {
  const LoadDashboardData();
}

class ToggleOnlineStatus extends HomeEvent {
  const ToggleOnlineStatus();
}

class StartNavigationEvent extends HomeEvent {
  final String orderId;
  const StartNavigationEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class ViewOrderEvent extends HomeEvent {
  final String orderId;
  const ViewOrderEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class ToggleNotificationsViewEvent extends HomeEvent {
  final bool show;
  const ToggleNotificationsViewEvent(this.show);

  @override
  List<Object?> get props => [show];
}
