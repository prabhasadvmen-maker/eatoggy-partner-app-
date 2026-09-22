class DeliveryCompletionModel {
  final String orderId;
  final String timestamp;
  final String customerName;
  final String earningsCredited;
  final String title;
  final String subtitle;

  const DeliveryCompletionModel({
    required this.orderId,
    required this.timestamp,
    required this.customerName,
    required this.earningsCredited,
    this.title = 'Delivery Completed!',
    this.subtitle = 'Luxurious service successfully rendered to client',
  });

  DeliveryCompletionModel copyWith({
    String? orderId,
    String? timestamp,
    String? customerName,
    String? earningsCredited,
    String? title,
    String? subtitle,
  }) {
    return DeliveryCompletionModel(
      orderId: orderId ?? this.orderId,
      timestamp: timestamp ?? this.timestamp,
      customerName: customerName ?? this.customerName,
      earningsCredited: earningsCredited ?? this.earningsCredited,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  static DeliveryCompletionModel getDummyData(String orderId) {
    return DeliveryCompletionModel(
      orderId: orderId,
      timestamp: 'Today, 1:24 PM',
      customerName: 'Rohan Malhotra',
      earningsCredited: '₹120.00',
    );
  }
}
