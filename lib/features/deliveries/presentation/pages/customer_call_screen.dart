import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../bloc/customer_call/customer_call_bloc.dart';
import '../../bloc/customer_call/customer_call_event.dart';
import '../../bloc/customer_call/customer_call_state.dart';
import '../widgets/call_action_buttons.dart';
import '../widgets/customer_history_card.dart';
import '../widgets/secured_contact_card.dart';
import 'customer_chat_screen.dart';

class CustomerCallScreen extends StatelessWidget {
  final String orderId;

  const CustomerCallScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCallBloc(orderId: orderId)
        ..add(LoadCustomerCallEvent(orderId)),
      child: const CustomerCallView(),
    );
  }
}

class CustomerCallView extends StatelessWidget {
  const CustomerCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCallBloc, CustomerCallState>(
      listener: (context, state) {
        if (state.feedbackMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.surface,
              content: Text(
                state.feedbackMessage!,
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 13.5,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.borderMd,
                side: const BorderSide(color: AppColors.border),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final customer = state.data;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              children: [
                // Top Navigation row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                            boxShadow: AppShadows.card,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),

                        // Circular Customer Avatar
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: 2.0,
                              ),
                              boxShadow: AppShadows.card,
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                customer.avatarAsset,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.surfaceSubtle,
                                  child: const Icon(
                                    Icons.person,
                                    size: 52,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Customer Name: "Rohan Malhotra"
                        Text(
                          customer.customerName,
                          style: GoogleFonts.fraunces(
                            color: AppColors.textPrimary,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Subtitle: "Active Order #EG-7840"
                        Text(
                          'Active Order ${customer.orderId}',
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Card 1: Secured Contact Line
                        SecuredContactCard(
                          maskedPhone: customer.maskedPhone,
                          proxyNotice: customer.proxyNotice,
                        ),
                        const SizedBox(height: 16),

                        // Action Buttons: Voice Call & Secure Chat
                        CallActionButtons(
                          onVoiceCallTap: () {
                            context
                                .read<CustomerCallBloc>()
                                .add(const TriggerVoiceCallEvent());
                          },
                          onSecureChatTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerChatScreen(
                                  customerName: customer.customerName,
                                  orderId: customer.orderId,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Card 2: Customer History
                        CustomerHistoryCard(
                          totalOrdersPlaced: customer.totalOrdersPlaced,
                          memberSince: customer.memberSince,
                        ),
                        const SizedBox(height: 22),

                        // Bottom Button: "Go Back to Delivery Details"
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(color: AppColors.border),
                              shape: const RoundedRectangleBorder(
                                borderRadius: AppRadius.borderLg,
                              ),
                            ),
                            child: Text(
                              'Go Back to Delivery Details',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
