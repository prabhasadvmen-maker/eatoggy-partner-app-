import 'package:equatable/equatable.dart';

class ActiveNavigationModel extends Equatable {
  final String orderId;
  final int etaMinutes;
  final double distanceKm;
  final String turnDirection;
  final String destinationTitle;
  final String destinationDetails;
  final String destinationAddress;
  final double latitude;
  final double longitude;
  final bool isArrived;

  const ActiveNavigationModel({
    required this.orderId,
    required this.etaMinutes,
    required this.distanceKm,
    required this.turnDirection,
    required this.destinationTitle,
    required this.destinationDetails,
    required this.destinationAddress,
    required this.latitude,
    required this.longitude,
    this.isArrived = false,
  });

  ActiveNavigationModel copyWith({
    String? orderId,
    int? etaMinutes,
    double? distanceKm,
    String? turnDirection,
    String? destinationTitle,
    String? destinationDetails,
    String? destinationAddress,
    double? latitude,
    double? longitude,
    bool? isArrived,
  }) {
    return ActiveNavigationModel(
      orderId: orderId ?? this.orderId,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      distanceKm: distanceKm ?? this.distanceKm,
      turnDirection: turnDirection ?? this.turnDirection,
      destinationTitle: destinationTitle ?? this.destinationTitle,
      destinationDetails: destinationDetails ?? this.destinationDetails,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isArrived: isArrived ?? this.isArrived,
    );
  }

  static const ActiveNavigationModel defaultNavigation = ActiveNavigationModel(
    orderId: '#EG-7840',
    etaMinutes: 8,
    distanceKm: 2.4,
    turnDirection: 'Head north on Indiranagar Double Rd',
    destinationTitle: 'Skyline Manor Residences',
    destinationDetails:
        'Defense Colony, Penthouse A • Customer Rohan Malhotra',
    destinationAddress:
        'Skyline Manor Residences, Defense Colony, New Delhi',
    latitude: 28.5729,
    longitude: 77.2289,
    isArrived: false,
  );

  @override
  List<Object?> get props => [
        orderId,
        etaMinutes,
        distanceKm,
        turnDirection,
        destinationTitle,
        destinationDetails,
        destinationAddress,
        latitude,
        longitude,
        isArrived,
      ];
}
