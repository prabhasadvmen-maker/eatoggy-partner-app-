import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<ToggleOnlineStatus>(_onToggleOnlineStatus);
    on<StartNavigationEvent>(_onStartNavigation);
    on<ViewOrderEvent>(_onViewOrder);
    on<ToggleNotificationsViewEvent>(_onToggleNotificationsView);
  }

  void _onToggleNotificationsView(
      ToggleNotificationsViewEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(showNotifications: event.show));
  }

  void _onLoadDashboardData(LoadDashboardData event, Emitter<HomeState> emit) {
    emit(state);
  }

  void _onToggleOnlineStatus(ToggleOnlineStatus event, Emitter<HomeState> emit) {
    emit(state.copyWith(isOnline: !state.isOnline));
  }

  void _onStartNavigation(StartNavigationEvent event, Emitter<HomeState> emit) {
    // Navigation triggered
  }

  void _onViewOrder(ViewOrderEvent event, Emitter<HomeState> emit) {
    // View order triggered
  }
}
