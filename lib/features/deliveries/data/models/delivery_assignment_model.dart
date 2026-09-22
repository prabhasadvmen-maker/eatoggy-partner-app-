import 'package:equatable/equatable.dart';

enum AssignmentStatus {
  pending,
  readyToPickup,
  outForDelivery,
  delivered,
}

class DeliveryAssignmentModel extends Equatable {
  final String orderId;
  final String customerName;
  final String address;
  final String timeSlot;
  final String tiffinsCountText;
  final AssignmentStatus status;
  final String statusText;

  const DeliveryAssignmentModel({
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.timeSlot,
    required this.tiffinsCountText,
    required this.status,
    required this.statusText,
  });

  static const List<DeliveryAssignmentModel> sampleAssignments = [
    DeliveryAssignmentModel(
      orderId: '#EG-7840',
      customerName: 'Rohan Malhotra',
      address: 'Defense Colony, Penthouse A',
      timeSlot: 'Slot: 1:00 PM - 2:00 PM',
      tiffinsCountText: '3 Gourmet Tiffins',
      status: AssignmentStatus.pending,
      statusText: 'PENDING',
    ),
    DeliveryAssignmentModel(
      orderId: '#EG-7841',
      customerName: 'Karan Sharma',
      address: 'Indiranagar, 12th Main',
      timeSlot: 'Slot: 1:00 PM - 2:00 PM',
      tiffinsCountText: '2 Gourmet Tiffins',
      status: AssignmentStatus.pending,
      statusText: 'PENDING',
    ),
    DeliveryAssignmentModel(
      orderId: '#EG-7839',
      customerName: 'Priyanka Sen',
      address: 'Indiranagar, 4th Cross',
      timeSlot: 'Slot: 1:00 PM - 2:00 PM',
      tiffinsCountText: '1 Gourmet Tiffins',
      status: AssignmentStatus.readyToPickup,
      statusText: 'READY TO PICKUP',
    ),
    DeliveryAssignmentModel(
      orderId: '#EG-7842',
      customerName: 'Rohan Malhotra',
      address: 'Defense Colony, Penthouse A',
      timeSlot: 'Slot: 1:00 PM - 2:00 PM',
      tiffinsCountText: '3 Gourmet Tiffins',
      status: AssignmentStatus.outForDelivery,
      statusText: 'OUT FOR DELIVERY',
    ),
    DeliveryAssignmentModel(
      orderId: '#EG-7835',
      customerName: 'Aditya Roy',
      address: 'Koramangala, 80ft Road',
      timeSlot: 'Slot: 1:00 PM - 2:00 PM',
      tiffinsCountText: '2 Gourmet Tiffins',
      status: AssignmentStatus.delivered,
      statusText: 'DELIVERED',
    ),
  ];

  @override
  List<Object?> get props => [
        orderId,
        customerName,
        address,
        timeSlot,
        tiffinsCountText,
        status,
        statusText,
      ];
}
