import 'package:equatable/equatable.dart';
import '../../data/models/tiffin_zone_model.dart';

enum TiffinZoneStatus { initial, loading, loaded, error }

class TiffinZoneState extends Equatable {
  final TiffinZoneStatus status;
  final TiffinZoneModel? zone;
  final bool isRouteStarted;
  final String? statusMessage;

  const TiffinZoneState({
    this.status = TiffinZoneStatus.initial,
    this.zone,
    this.isRouteStarted = false,
    this.statusMessage,
  });

  TiffinZoneState copyWith({
    TiffinZoneStatus? status,
    TiffinZoneModel? zone,
    bool? isRouteStarted,
    String? statusMessage,
  }) {
    return TiffinZoneState(
      status: status ?? this.status,
      zone: zone ?? this.zone,
      isRouteStarted: isRouteStarted ?? this.isRouteStarted,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        zone,
        isRouteStarted,
        statusMessage,
      ];
}
