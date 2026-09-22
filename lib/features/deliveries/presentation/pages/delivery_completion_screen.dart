import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/delivery_completion/delivery_completion_bloc.dart';
import '../../bloc/delivery_completion/delivery_completion_event.dart';
import '../../bloc/delivery_completion/delivery_completion_state.dart';
import '../widgets/delivery_completion_card.dart';
import '../widgets/delivery_success_badge.dart';

class DeliveryCompletionScreen extends StatelessWidget {
  final String orderId;

  const DeliveryCompletionScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryCompletionBloc(orderId: orderId)
        ..add(LoadDeliveryCompletionEvent(orderId)),
      child: const DeliveryCompletionView(),
    );
  }
}

class DeliveryCompletionView extends StatelessWidget {
  const DeliveryCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryCompletionBloc, DeliveryCompletionState>(
      listener: (context, state) {
        if (state.status == DeliveryCompletionStatus.backToDashboard) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (state.status == DeliveryCompletionStatus.nextDelivery) {
          // Return to root and notify next delivery
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      builder: (context, state) {
        final data = state.data;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Top Centered Success Badge
                  const Center(
                    child: DeliverySuccessBadge(),
                  ),
                  const SizedBox(height: 28),

                  // Title: "Delivery Completed!"
                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fraunces(
                      color: const Color(0xFFE5B563),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle: "Luxurious service successfully rendered to client"
                  Text(
                    data.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF8E8E93),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Summary Card
                  DeliveryCompletionCard(model: data),

                  const Spacer(),

                  // Button 1: "Next Delivery" (Gold Button)
                  InkWell(
                    onTap: () {
                      context
                          .read<DeliveryCompletionBloc>()
                          .add(const NextDeliveryTappedEvent());
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE8B669),
                            Color(0xFFD69C45),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD69C45).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Next Delivery',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF11110F),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Button 2: "Back to Dashboard" (Underlined link)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<DeliveryCompletionBloc>()
                            .add(const BackToDashboardTappedEvent());
                      },
                      child: Text(
                        'Back to Dashboard',
                        style: GoogleFonts.inter(
                          color: AppColors.creamText,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.creamText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
