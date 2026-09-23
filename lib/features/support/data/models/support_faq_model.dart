import 'package:equatable/equatable.dart';

class SupportFaqItemModel extends Equatable {
  final String id;
  final String title;
  final String answer;

  const SupportFaqItemModel({
    required this.id,
    required this.title,
    required this.answer,
  });

  @override
  List<Object?> get props => [id, title, answer];

  static const List<SupportFaqItemModel> sampleFaqs = [
    SupportFaqItemModel(
      id: 'delivery_issues',
      title: 'Delivery Issues',
      answer:
          '"Please contact kitchen support immediately via chat if food is spilled, missing payload, or if the client changes location mid-journey."',
    ),
    SupportFaqItemModel(
      id: 'payment_settlements',
      title: 'Payment & Settlements',
      answer:
          '"Payouts are automatically settled to your registered bank account every Tuesday and Friday by 6:00 PM. Instant withdrawals can also be requested from your Earnings dashboard."',
    ),
    SupportFaqItemModel(
      id: 'account_verification',
      title: 'Account & Verification',
      answer:
          '"Your partner badge is verified after standard KYC checks including Driving License, RC, and Bank details verification within 24-48 hours of onboarding."',
    ),
    SupportFaqItemModel(
      id: 'app_navigation_issues',
      title: 'App & Navigation Issues',
      answer:
          '"If GPS calibration deviates or map turns freeze, tap Re-center on the active order screen or toggle your GPS off and on from your device quick settings."',
    ),
  ];
}
