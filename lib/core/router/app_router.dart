import 'package:go_router/go_router.dart';

import '../../features/splash/pages/splash_screen.dart';
import '../../features/authentication/pages/register_screen.dart';
import '../../features/authentication/pages/login_screen.dart';
import '../../features/authentication/pages/otp_screen.dart';
import '../../features/authentication/pages/document_verification_screen.dart';
import '../../features/authentication/pages/bank_details_screen.dart';
import '../../features/authentication/pages/onboarding_fee_screen.dart';
import '../../features/dashboard/view/main_shell_screen.dart';

import '../../features/deliveries/presentation/pages/incoming_order_modal_screen.dart';
import '../../features/deliveries/presentation/pages/delivery_details_screen.dart';
import '../../features/deliveries/presentation/pages/active_navigation_screen.dart';
import '../../features/deliveries/presentation/pages/active_tour_screen.dart';
import '../../features/deliveries/presentation/pages/customer_call_screen.dart';
import '../../features/deliveries/presentation/pages/customer_chat_screen.dart';
import '../../features/deliveries/presentation/pages/verification_protocol_screen.dart';
import '../../features/deliveries/presentation/pages/delivery_completion_screen.dart';
import '../../features/deliveries/presentation/pages/report_delivery_issue_screen.dart';
import '../../features/deliveries/presentation/pages/delivery_history_screen.dart';
import '../../features/deliveries/presentation/pages/cod_payment_screen.dart';
import '../../features/deliveries/presentation/pages/upi_qr_payment_screen.dart';

import '../../features/deliveries/presentation/pages/tiffin_zone_screen.dart';
import '../../features/deliveries/presentation/pages/tiffin_subscribers_screen.dart';
import '../../features/deliveries/presentation/pages/tiffin_delivery_detail_screen.dart';

import '../../features/home/presentation/pages/offline_state_screen.dart';
import '../../features/notifications/presentation/pages/notifications_screen.dart';
import '../../features/support/presentation/pages/support_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';

import '../../features/earnings/presentation/pages/incentive_quests_screen.dart';
import '../../features/earnings/presentation/pages/cash_in_hand_management_screen.dart';
import '../../features/earnings/presentation/pages/payout_statement_pdf_viewer_screen.dart';
import '../../features/profile/presentation/pages/partner_performance_scorecard_screen.dart';
import '../../features/support/presentation/pages/sos_emergency_screen.dart';
import '../../features/settings/presentation/pages/battery_optimization_guide_screen.dart';

import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => SplashScreen(
          onFinish: () => context.go(AppRoutes.register),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterScreen(
          onRegisterSuccess: () => context.push(AppRoutes.documentVerification),
          onLoginTap: () => context.push(AppRoutes.login),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(
          onLoginSuccess: () => context.go(AppRoutes.home),
          onRequestOtp: (phone) => context.push(AppRoutes.otp, extra: phone),
        ),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final phone = state.extra as String? ?? '+91 98765 43210';
          return OtpScreen(
            phone: phone,
            onVerifySuccess: () => context.go(AppRoutes.home),
            onChangePhoneTap: () => context.pop(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.documentVerification,
        builder: (context, state) => DocumentVerificationScreen(
          onContinueToBanking: () => context.push(AppRoutes.bankDetails),
        ),
      ),
      GoRoute(
        path: AppRoutes.bankDetails,
        builder: (context, state) => BankDetailsScreen(
          onVerifySuccess: () => context.push(AppRoutes.onboardingFee),
        ),
      ),
      GoRoute(
        path: AppRoutes.onboardingFee,
        builder: (context, state) => OnboardingFeeScreen(
          onPaymentSuccess: () => context.go(AppRoutes.home),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => MainShellScreen(
          onLogout: () => context.go(AppRoutes.register),
        ),
      ),

      // Deliveries Flow
      GoRoute(
        path: AppRoutes.incomingOrder,
        builder: (context, state) => const IncomingOrderModalScreen(),
      ),
      GoRoute(
        path: AppRoutes.deliveryDetails,
        builder: (context, state) => const DeliveryDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.activeNavigation,
        builder: (context, state) => const ActiveNavigationScreen(),
      ),
      GoRoute(
        path: AppRoutes.activeTour,
        builder: (context, state) => const ActiveTourScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerCall,
        builder: (context, state) => const CustomerCallScreen(),
      ),
      GoRoute(
        path: AppRoutes.customerChat,
        builder: (context, state) => const CustomerChatScreen(),
      ),
      GoRoute(
        path: AppRoutes.verificationProtocol,
        builder: (context, state) => const VerificationProtocolScreen(),
      ),
      GoRoute(
        path: AppRoutes.deliveryCompletion,
        builder: (context, state) => const DeliveryCompletionScreen(),
      ),
      GoRoute(
        path: AppRoutes.reportIssue,
        builder: (context, state) => const ReportDeliveryIssueScreen(),
      ),
      GoRoute(
        path: AppRoutes.deliveryHistory,
        builder: (context, state) => const DeliveryHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.codPayment,
        builder: (context, state) => const CodPaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.upiQrPayment,
        builder: (context, state) => const UpiQrPaymentScreen(),
      ),

      // Tiffin Flow
      GoRoute(
        path: AppRoutes.tiffinZone,
        builder: (context, state) => const TiffinZoneScreen(),
      ),
      GoRoute(
        path: AppRoutes.tiffinSubscribers,
        builder: (context, state) => const TiffinSubscribersScreen(),
      ),
      GoRoute(
        path: AppRoutes.tiffinDeliveryDetail,
        builder: (context, state) => const TiffinDeliveryDetailScreen(),
      ),

      // Secondary Screens
      GoRoute(
        path: AppRoutes.offline,
        builder: (context, state) => const OfflineStateScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.support,
        builder: (context, state) => SupportScreen(
          onBack: () => context.pop(),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => SettingsScreen(
          onBack: () => context.pop(),
          onLogout: () => context.go(AppRoutes.register),
        ),
      ),

      // Operational, Safety & Earnings Screens
      GoRoute(
        path: AppRoutes.incentiveQuests,
        builder: (context, state) => const IncentiveQuestsScreen(),
      ),
      GoRoute(
        path: AppRoutes.cashInHand,
        builder: (context, state) => const CashInHandManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.performanceScorecard,
        builder: (context, state) => const PartnerPerformanceScorecardScreen(),
      ),
      GoRoute(
        path: AppRoutes.sosEmergency,
        builder: (context, state) => const SosEmergencyScreen(),
      ),
      GoRoute(
        path: AppRoutes.batteryGuide,
        builder: (context, state) => const BatteryOptimizationGuideScreen(),
      ),
      GoRoute(
        path: AppRoutes.payoutStatement,
        builder: (context, state) => const PayoutStatementPdfViewerScreen(),
      ),
    ],
  );
}
