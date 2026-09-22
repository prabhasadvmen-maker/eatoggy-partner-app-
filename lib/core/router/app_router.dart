import 'package:go_router/go_router.dart';

import '../../features/splash/pages/splash_screen.dart';
import '../../features/authentication/pages/register_screen.dart';
import '../../features/authentication/pages/login_screen.dart';
import '../../features/authentication/pages/otp_screen.dart';
import '../../features/authentication/pages/document_verification_screen.dart';
import '../../features/authentication/pages/bank_details_screen.dart';
import '../../features/authentication/pages/onboarding_fee_screen.dart';
import '../../features/dashboard/view/main_shell_screen.dart';
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
      // GoRoute(
      //   path: AppRoutes.restaurantDetails,
      //   builder: (context, state) {
      //     final restaurant = state.extra as Restaurant;
      //     return RestaurantDetailsScreen(
      //       restaurant: restaurant,
      //       onBackPressed: () => context.pop(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: AppRoutes.checkout,
      //   builder: (context, state) => CheckoutScreen(
      //     onOrderPlaced: () => context.go(AppRoutes.orderSuccess),
      //   ),
      // ),
      // GoRoute(
      //   path: AppRoutes.orderSuccess,
      //   builder: (context, state) => OrderSuccessScreen(
      //     onViewOrder: () => context.go(AppRoutes.home),
      //   ),
      // ),
    ],
  );
}
