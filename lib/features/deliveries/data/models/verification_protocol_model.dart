class VerificationProtocolModel {
  final String orderId;
  final String title;
  final String subtitle;
  final String customerName;
  final String validOtp;
  final String infoText;
  final bool isVerified;

  const VerificationProtocolModel({
    required this.orderId,
    this.title = 'Verification Protocol',
    this.subtitle = 'Enter the secure code shared by the customer',
    this.customerName = 'Rohan Malhotra',
    this.validOtp = '2048',
    this.infoText = "OTP was sent to customer's registered smartphone app.",
    this.isVerified = false,
  });

  VerificationProtocolModel copyWith({
    String? orderId,
    String? title,
    String? subtitle,
    String? customerName,
    String? validOtp,
    String? infoText,
    bool? isVerified,
  }) {
    return VerificationProtocolModel(
      orderId: orderId ?? this.orderId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      customerName: customerName ?? this.customerName,
      validOtp: validOtp ?? this.validOtp,
      infoText: infoText ?? this.infoText,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  static VerificationProtocolModel getDummyData(String orderId) {
    return VerificationProtocolModel(
      orderId: orderId,
      customerName: 'Rohan Malhotra',
      validOtp: '2048', // Matching the '2', '0' shown in the screenshot
    );
  }
}
