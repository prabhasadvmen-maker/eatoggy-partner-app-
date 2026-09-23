import 'package:equatable/equatable.dart';

class OrderItemModel extends Equatable {
  final String name;
  final int quantity;

  const OrderItemModel({
    required this.name,
    required this.quantity,
  });

  @override
  List<Object?> get props => [name, quantity];
}

class DeliveryDetailsModel extends Equatable {
  final String orderId;
  final String customerName;
  final String subscriptionType;
  final String phoneNumber;
  final String deliveryLocation;
  final String payloadTitle;
  final String packagesCount;
  final String timeSlot;
  final List<OrderItemModel> items;
  final int totalItems;
  final String deliveryNotes;
  final bool isPickupConfirmed;

  const DeliveryDetailsModel({
    required this.orderId,
    required this.customerName,
    required this.subscriptionType,
    required this.phoneNumber,
    required this.deliveryLocation,
    required this.payloadTitle,
    required this.packagesCount,
    required this.timeSlot,
    required this.items,
    required this.totalItems,
    required this.deliveryNotes,
    this.isPickupConfirmed = false,
  });

  DeliveryDetailsModel copyWith({
    String? orderId,
    String? customerName,
    String? subscriptionType,
    String? phoneNumber,
    String? deliveryLocation,
    String? payloadTitle,
    String? packagesCount,
    String? timeSlot,
    List<OrderItemModel>? items,
    int? totalItems,
    String? deliveryNotes,
    bool? isPickupConfirmed,
  }) {
    return DeliveryDetailsModel(
      orderId: orderId ?? this.orderId,
      customerName: customerName ?? this.customerName,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      payloadTitle: payloadTitle ?? this.payloadTitle,
      packagesCount: packagesCount ?? this.packagesCount,
      timeSlot: timeSlot ?? this.timeSlot,
      items: items ?? this.items,
      totalItems: totalItems ?? this.totalItems,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      isPickupConfirmed: isPickupConfirmed ?? this.isPickupConfirmed,
    );
  }

  static const DeliveryDetailsModel sampleOrder = DeliveryDetailsModel(
    orderId: '#EG-7840',
    customerName: 'Rohan Malhotra',
    subscriptionType: 'Prime Subscriber',
    phoneNumber: '+91 98765 43210',
    deliveryLocation:
        'Penthouse A, Building 4B, Skyline Manor Residences, Defense Colony, New Delhi',
    payloadTitle: 'Gourmet Tiffin Boxes',
    packagesCount: '3 Packages',
    timeSlot: '1:00 PM - 2:00 PM',
    items: [
      OrderItemModel(name: 'Paneer Butter Masala', quantity: 2),
      OrderItemModel(name: 'Butter Naan', quantity: 4),
      OrderItemModel(name: 'Dal Tadka', quantity: 1),
      OrderItemModel(name: 'Jeera Rice', quantity: 2),
      OrderItemModel(name: 'Gulab Jamun', quantity: 2),
    ],
    totalItems: 11,
    deliveryNotes:
        '“Leave at the penthouse reception lobby if resident is not immediately answering doorbell.”',
    isPickupConfirmed: false,
  );

  @override
  List<Object?> get props => [
        orderId,
        customerName,
        subscriptionType,
        phoneNumber,
        deliveryLocation,
        payloadTitle,
        packagesCount,
        timeSlot,
        items,
        totalItems,
        deliveryNotes,
        isPickupConfirmed,
      ];
}
