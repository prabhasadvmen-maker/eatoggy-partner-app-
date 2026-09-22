class CustomerCallModel {
  final String customerName;
  final String orderId;
  final String maskedPhone;
  final String dialPhone;
  final String avatarAsset;
  final String proxyNotice;
  final int totalOrdersPlaced;
  final String memberSince;

  const CustomerCallModel({
    required this.customerName,
    required this.orderId,
    required this.maskedPhone,
    required this.dialPhone,
    required this.avatarAsset,
    this.proxyNotice =
        'Numbers are hidden for privacy. Calls are placed via secured proxy routing.',
    this.totalOrdersPlaced = 47,
    this.memberSince = 'Jan 2024',
  });

  CustomerCallModel copyWith({
    String? customerName,
    String? orderId,
    String? maskedPhone,
    String? dialPhone,
    String? avatarAsset,
    String? proxyNotice,
    int? totalOrdersPlaced,
    String? memberSince,
  }) {
    return CustomerCallModel(
      customerName: customerName ?? this.customerName,
      orderId: orderId ?? this.orderId,
      maskedPhone: maskedPhone ?? this.maskedPhone,
      dialPhone: dialPhone ?? this.dialPhone,
      avatarAsset: avatarAsset ?? this.avatarAsset,
      proxyNotice: proxyNotice ?? this.proxyNotice,
      totalOrdersPlaced: totalOrdersPlaced ?? this.totalOrdersPlaced,
      memberSince: memberSince ?? this.memberSince,
    );
  }

  static CustomerCallModel getDummyData(String orderId) {
    return CustomerCallModel(
      customerName: 'Rohan Malhotra',
      orderId: orderId,
      maskedPhone: '+91 ****** 9091',
      dialPhone: '+919876549091',
      avatarAsset: 'assets/images/rohan_avatar.jpg',
      totalOrdersPlaced: 47,
      memberSince: 'Jan 2024',
    );
  }
}
