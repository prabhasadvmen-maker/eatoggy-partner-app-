import 'package:equatable/equatable.dart';

class PartnerProfileModel extends Equatable {
  final String name;
  final String partnerId;
  final bool isVerified;
  final String rating;
  final String totalDeliveries;
  final String memberSince;
  final String phoneNumber;
  final String vehicleDetails;
  final String preferredZone;
  final String avatarPath;

  const PartnerProfileModel({
    required this.name,
    required this.partnerId,
    this.isVerified = true,
    required this.rating,
    required this.totalDeliveries,
    required this.memberSince,
    required this.phoneNumber,
    required this.vehicleDetails,
    required this.preferredZone,
    required this.avatarPath,
  });

  PartnerProfileModel copyWith({
    String? name,
    String? partnerId,
    bool? isVerified,
    String? rating,
    String? totalDeliveries,
    String? memberSince,
    String? phoneNumber,
    String? vehicleDetails,
    String? preferredZone,
    String? avatarPath,
  }) {
    return PartnerProfileModel(
      name: name ?? this.name,
      partnerId: partnerId ?? this.partnerId,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      totalDeliveries: totalDeliveries ?? this.totalDeliveries,
      memberSince: memberSince ?? this.memberSince,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      preferredZone: preferredZone ?? this.preferredZone,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }

  static const PartnerProfileModel defaultProfile = PartnerProfileModel(
    name: 'Kabir Singh',
    partnerId: '#EG-992',
    isVerified: true,
    rating: '4.9 ★',
    totalDeliveries: '348 Total',
    memberSince: 'June 2025',
    phoneNumber: '+91 98765 43210',
    vehicleDetails: 'Electric Bike (KA-03-EX-1234)',
    preferredZone: 'Indiranagar & Defense Colony',
    avatarPath: 'assets/images/kabir_avatar.jpg',
  );

  @override
  List<Object?> get props => [
        name,
        partnerId,
        isVerified,
        rating,
        totalDeliveries,
        memberSince,
        phoneNumber,
        vehicleDetails,
        preferredZone,
        avatarPath,
      ];
}
