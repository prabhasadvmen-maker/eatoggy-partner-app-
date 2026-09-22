import 'package:equatable/equatable.dart';
import '../../data/models/active_tour_model.dart';

enum ActiveTourStatus { initial, inProgress, otpVerified, error }

class ActiveTourState extends Equatable {
  final ActiveTourStatus status;
  final ActiveTourModel tourData;
  final String? message;
  final String? otpError;

  const ActiveTourState({
    this.status = ActiveTourStatus.initial,
    this.tourData = ActiveTourModel.defaultTour,
    this.message,
    this.otpError,
  });

  ActiveTourState copyWith({
    ActiveTourStatus? status,
    ActiveTourModel? tourData,
    String? message,
    String? otpError,
  }) {
    return ActiveTourState(
      status: status ?? this.status,
      tourData: tourData ?? this.tourData,
      message: message,
      otpError: otpError,
    );
  }

  @override
  List<Object?> get props => [status, tourData, message, otpError];
}
