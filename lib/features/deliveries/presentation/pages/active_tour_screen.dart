import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/active_tour/active_tour_bloc.dart';
import '../../bloc/active_tour/active_tour_event.dart';
import '../../bloc/active_tour/active_tour_state.dart';
import '../widgets/tour_estimated_time_card.dart';
import '../widgets/tour_delivery_for_card.dart';
import 'verification_protocol_screen.dart';
import 'customer_call_screen.dart';

class ActiveTourScreen extends StatelessWidget {
  final String orderId;

  const ActiveTourScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActiveTourBloc()..add(LoadActiveTourEvent(orderId)),
      child: const ActiveTourView(),
    );
  }
}

class ActiveTourView extends StatelessWidget {
  const ActiveTourView({super.key});

  static const Color _screenBg = Color(0xFF111111);
  static const Color _goldColor = AppColors.cardGoldAccent;

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF262628)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFF0F2C1A),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF00E676),
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Delivery Completed!',
              style: GoogleFonts.fraunces(
                color: AppColors.creamText,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Order #EG-7840 has been handed over and confirmed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF8E8E93),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _goldColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                Navigator.pop(dialogContext); // close dialog
                Navigator.of(context).popUntil((route) => route.isFirst); // back to home
              },
              child: Text(
                'Back to Dashboard',
                style: GoogleFonts.inter(
                  color: const Color(0xFF141416),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: _screenBg,
        body: BlocConsumer<ActiveTourBloc, ActiveTourState>(
          listener: (context, state) {
            if (state.status == ActiveTourStatus.otpVerified) {
              _showCompletionDialog(context);
            } else if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            final tour = state.tourData;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow & Header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1C),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF262628),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: _goldColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Title: Active Delivery Tour (Fraunces Warm Cream Serif)
                    Text(
                      tour.title,
                      style: GoogleFonts.fraunces(
                        color: AppColors.creamText,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle: Out for Delivery • Order #EG-7840
                    Text(
                      tour.statusText,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF8E8E93),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Estimated Time Card
                    TourEstimatedTimeCard(
                      estimatedTimeLeft: tour.estimatedTimeLeft,
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Delivery For Card
                    TourDeliveryForCard(
                      customerName: tour.customerName,
                      address: tour.address,
                      gateAccessCode: tour.gateAccessCode,
                    ),

                    const Spacer(),

                    // Button 1: Enter Delivery OTP (Gold CTA)
                    InkWell(
                      onTap: tour.isDelivered
                          ? null
                          : () async {
                              final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerificationProtocolScreen(
                                    orderId: tour.orderId,
                                  ),
                                ),
                              );
                              if (result == true && context.mounted) {
                                context
                                    .read<ActiveTourBloc>()
                                    .add(VerifyOtpEvent(tour.correctOtp));
                              }
                            },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          color: tour.isDelivered
                              ? const Color(0xFF00E676)
                              : _goldColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: (tour.isDelivered
                                      ? const Color(0xFF00E676)
                                      : _goldColor)
                                  .withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            tour.isDelivered
                                ? 'Delivery Completed ✓'
                                : 'Enter Delivery OTP',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF141416),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Button 2: Initiate Customer Call (Dark outlined secondary button)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerCallScreen(
                              orderId: tour.orderId,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF18181A),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF2E2E32),
                            width: 1.2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Initiate Customer Call',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
