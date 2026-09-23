import 'package:equatable/equatable.dart';

abstract class TiffinZoneEvent extends Equatable {
  const TiffinZoneEvent();

  @override
  List<Object?> get props => [];
}

class LoadTiffinZoneDataEvent extends TiffinZoneEvent {
  const LoadTiffinZoneDataEvent();
}

class StartTiffinRouteEvent extends TiffinZoneEvent {
  const StartTiffinRouteEvent();
}
