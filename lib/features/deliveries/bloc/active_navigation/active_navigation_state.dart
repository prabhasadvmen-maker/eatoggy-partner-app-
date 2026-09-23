import 'package:equatable/equatable.dart';
import '../../data/models/active_navigation_model.dart';

enum NavigationStatus { initial, navigating, arrived, error }

class ActiveNavigationState extends Equatable {
  final NavigationStatus status;
  final ActiveNavigationModel navigationData;
  final String? message;

  const ActiveNavigationState({
    this.status = NavigationStatus.initial,
    this.navigationData = ActiveNavigationModel.defaultNavigation,
    this.message,
  });

  ActiveNavigationState copyWith({
    NavigationStatus? status,
    ActiveNavigationModel? navigationData,
    String? message,
  }) {
    return ActiveNavigationState(
      status: status ?? this.status,
      navigationData: navigationData ?? this.navigationData,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, navigationData, message];
}
