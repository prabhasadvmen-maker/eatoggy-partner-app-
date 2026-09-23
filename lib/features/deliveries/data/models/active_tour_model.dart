import 'package:equatable/equatable.dart';

class ActiveTourModel extends Equatable {
  final String title;
  final String statusText;
  final String orderId;
  final String estimatedTimeLeft;
  final String customerName;
  final String phoneNumber;
  final String address;
  final String gateAccessCode;
  final String correctOtp;
  final bool isDelivered;

  const ActiveTourModel({
    required this.title,
    required this.statusText,
    required this.orderId,
    required this.estimatedTimeLeft,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.gateAccessCode,
    this.correctOtp = '4821',
    this.isDelivered = false,
  });

  ActiveTourModel copyWith({
    String? title,
    String? statusText,
    String? orderId,
    String? estimatedTimeLeft,
    String? customerName,
    String? phoneNumber,
    String? address,
    String? gateAccessCode,
    String? correctOtp,
    bool? isDelivered,
  }) {
    return ActiveTourModel(
      title: title ?? this.title,
      statusText: statusText ?? this.statusText,
      orderId: orderId ?? this.orderId,
      estimatedTimeLeft: estimatedTimeLeft ?? this.estimatedTimeLeft,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      gateAccessCode: gateAccessCode ?? this.gateAccessCode,
      correctOtp: correctOtp ?? this.correctOtp,
      isDelivered: isDelivered ?? this.isDelivered,
    );
  }

  static const ActiveTourModel defaultTour = ActiveTourModel(
    title: 'Active Delivery Tour',
    statusText: 'Out for Delivery • Order #EG-7840',
    orderId: '#EG-7840',
    estimatedTimeLeft: '10 Mins Left',
    customerName: 'Rohan Malhotra',
    phoneNumber: '+91 98765 43210',
    address:
        'Penthouse A, Skyline Manor Residences,\nDefense Colony',
    gateAccessCode:
        'Ring bell at gate first. Lobby access card provided by security desk.',
    correctOtp: '4821',
    isDelivered: false,
  );

  @override
  List<Object?> get props => [
        title,
        statusText,
        orderId,
        estimatedTimeLeft,
        customerName,
        phoneNumber,
        address,
        gateAccessCode,
        correctOtp,
        isDelivered,
      ];
}
