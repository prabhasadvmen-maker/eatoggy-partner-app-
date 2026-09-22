import 'package:equatable/equatable.dart';

class PartnerDeliveryAction extends Equatable {
  final String orderId;
  final String status;
  final String paymentType; // 'COD' or 'PREPAID'
  final String pickupAddress;
  final String dropAddress;

  const PartnerDeliveryAction({
    required this.orderId,
    required this.status,
    required this.paymentType,
    required this.pickupAddress,
    required this.dropAddress,
  });

  @override
  List<Object?> get props => [orderId, status, paymentType, pickupAddress, dropAddress];
}

class HomeState extends Equatable {
  final bool isOnline;
  final String partnerName;
  final String partnerId;
  final String totalEarnings;
  final int completedDeliveries;
  final int totalTargetDeliveries;
  final int breakdownCompleted;
  final int breakdownPending;
  final int breakdownRejected;
  final List<PartnerDeliveryAction> nextDeliveries;
  final bool showNotifications;

  const HomeState({
    this.isOnline = true,
    this.partnerName = 'Kabir Singh',
    this.partnerId = '#EG-992',
    this.totalEarnings = '₹1,450.00',
    this.completedDeliveries = 12,
    this.totalTargetDeliveries = 15,
    this.breakdownCompleted = 12,
    this.breakdownPending = 2,
    this.breakdownRejected = 1,
    this.showNotifications = false,
    this.nextDeliveries = const [
      PartnerDeliveryAction(
        orderId: 'EG-7840',
        status: 'PICKUP PENDING',
        paymentType: 'COD',
        pickupAddress: 'Eatoggy Central Gourmet Kitchen, Indiranagar',
        dropAddress: 'Penthouse A, Skyline Manor, Defense Colony',
      ),
      PartnerDeliveryAction(
        orderId: 'EG-7840',
        status: 'PICKUP PENDING',
        paymentType: 'PREPAID',
        pickupAddress: 'Eatoggy Central Gourmet Kitchen, Indiranagar',
        dropAddress: 'Penthouse A, Skyline Manor, Defense Colony',
      ),
    ],
  });

  HomeState copyWith({
    bool? isOnline,
    String? partnerName,
    String? partnerId,
    String? totalEarnings,
    int? completedDeliveries,
    int? totalTargetDeliveries,
    int? breakdownCompleted,
    int? breakdownPending,
    int? breakdownRejected,
    List<PartnerDeliveryAction>? nextDeliveries,
    bool? showNotifications,
  }) {
    return HomeState(
      isOnline: isOnline ?? this.isOnline,
      partnerName: partnerName ?? this.partnerName,
      partnerId: partnerId ?? this.partnerId,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      completedDeliveries: completedDeliveries ?? this.completedDeliveries,
      totalTargetDeliveries: totalTargetDeliveries ?? this.totalTargetDeliveries,
      breakdownCompleted: breakdownCompleted ?? this.breakdownCompleted,
      breakdownPending: breakdownPending ?? this.breakdownPending,
      breakdownRejected: breakdownRejected ?? this.breakdownRejected,
      nextDeliveries: nextDeliveries ?? this.nextDeliveries,
      showNotifications: showNotifications ?? this.showNotifications,
    );
  }

  @override
  List<Object?> get props => [
        isOnline,
        partnerName,
        partnerId,
        totalEarnings,
        completedDeliveries,
        totalTargetDeliveries,
        breakdownCompleted,
        breakdownPending,
        breakdownRejected,
        nextDeliveries,
        showNotifications,
      ];
}
