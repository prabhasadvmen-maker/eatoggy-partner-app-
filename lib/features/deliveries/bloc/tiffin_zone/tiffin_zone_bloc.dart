import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/tiffin_zone_model.dart';
import 'tiffin_zone_event.dart';
import 'tiffin_zone_state.dart';

class TiffinZoneBloc extends Bloc<TiffinZoneEvent, TiffinZoneState> {
  TiffinZoneBloc() : super(const TiffinZoneState()) {
    on<LoadTiffinZoneDataEvent>(_onLoadData);
    on<StartTiffinRouteEvent>(_onStartRoute);
  }

  void _onLoadData(
    LoadTiffinZoneDataEvent event,
    Emitter<TiffinZoneState> emit,
  ) {
    emit(state.copyWith(
      status: TiffinZoneStatus.loaded,
      zone: TiffinZoneModel.sampleZone,
    ));
  }

  void _onStartRoute(
    StartTiffinRouteEvent event,
    Emitter<TiffinZoneState> emit,
  ) {
    emit(state.copyWith(
      isRouteStarted: true,
      statusMessage: 'Tiffin Route Started Successfully!',
    ));
  }
}
