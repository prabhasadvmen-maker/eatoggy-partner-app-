import 'package:equatable/equatable.dart';

enum HistoryStatus {
  delivered,
  failed,
}

class DeliveryHistoryModel extends Equatable {
  final String orderId;
  final String customerName;
  final String timestamp;
  final HistoryStatus status;
  final String statusText;
  final String earningsText;
  final String timeFilter; // 'Today', 'This Week', 'This Month', 'Custom'

  const DeliveryHistoryModel({
    required this.orderId,
    required this.customerName,
    required this.timestamp,
    required this.status,
    required this.statusText,
    required this.earningsText,
    required this.timeFilter,
  });

  static const List<DeliveryHistoryModel> sampleHistory = [
    DeliveryHistoryModel(
      orderId: '#EG-7840',
      customerName: 'Rohan Malhotra',
      timestamp: 'Today, 1:24 PM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹120.00',
      timeFilter: 'Today',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7839',
      customerName: 'Priyanka Sen',
      timestamp: 'Today, 11:15 AM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹95.00',
      timeFilter: 'Today',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7835',
      customerName: 'Aditya Roy',
      timestamp: 'Yesterday, 8:40 PM',
      status: HistoryStatus.failed,
      statusText: 'FAILED',
      earningsText: '₹0.00',
      timeFilter: 'Today',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7830',
      customerName: 'Meera Nair',
      timestamp: 'Yesterday, 1:10 PM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹150.00',
      timeFilter: 'Today',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7824',
      customerName: 'Karan Sharma',
      timestamp: '3 days ago, 2:30 PM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹110.00',
      timeFilter: 'This Week',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7820',
      customerName: 'Sneha Kapoor',
      timestamp: '5 days ago, 1:15 PM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹140.00',
      timeFilter: 'This Week',
    ),
    DeliveryHistoryModel(
      orderId: '#EG-7815',
      customerName: 'Ananya Iyer',
      timestamp: '12 Sep, 1:45 PM',
      status: HistoryStatus.delivered,
      statusText: 'DELIVERED',
      earningsText: '₹135.00',
      timeFilter: 'This Month',
    ),
  ];

  @override
  List<Object?> get props => [
        orderId,
        customerName,
        timestamp,
        status,
        statusText,
        earningsText,
        timeFilter,
      ];
}
