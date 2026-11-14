class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String documentVerification = '/document-verification';
  static const String bankDetails = '/bank-details';
  static const String onboardingFee = '/onboarding-fee';
  static const String home = '/home';

  // Deliveries flow routes
  static const String incomingOrder = '/incoming-order';
  static const String deliveryDetails = '/delivery-details';
  static const String activeNavigation = '/active-navigation';
  static const String activeTour = '/active-tour';
  static const String customerCall = '/customer-call';
  static const String customerChat = '/customer-chat';
  static const String verificationProtocol = '/verification-protocol';
  static const String deliveryCompletion = '/delivery-completion';
  static const String reportIssue = '/report-issue';
  static const String deliveryHistory = '/delivery-history';
  static const String codPayment = '/cod-payment';
  static const String upiQrPayment = '/upi-qr-payment';

  // Tiffin Ecosystem routes
  static const String tiffinZone = '/tiffin-zone';
  static const String tiffinSubscribers = '/tiffin-subscribers';
  static const String tiffinDeliveryDetail = '/tiffin-delivery-detail';

  // Offline, Notifications & Secondary Hubs
  static const String offline = '/offline';
  static const String notifications = '/notifications';
  static const String support = '/support';
  static const String settings = '/settings';
  static const String profile = '/profile';

  // Advanced Operations, Safety & Earnings
  static const String incentiveQuests = '/incentive-quests';
  static const String cashInHand = '/cash-in-hand';
  static const String performanceScorecard = '/performance-scorecard';
  static const String sosEmergency = '/sos-emergency';
  static const String batteryGuide = '/battery-guide';
  static const String payoutStatement = '/payout-statement';
}
