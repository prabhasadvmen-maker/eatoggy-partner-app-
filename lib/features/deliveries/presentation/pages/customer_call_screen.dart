import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/customer_call/customer_call_bloc.dart';
import '../../bloc/customer_call/customer_call_event.dart';
import '../../bloc/customer_call/customer_call_state.dart';
import '../widgets/call_action_buttons.dart';
import '../widgets/customer_history_card.dart';
import '../widgets/secured_contact_card.dart';

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

  void _showQuickChatSheet(BuildContext context, String customerName) {
    final textController = TextEditingController();
    final quickReplies = [
      'I have arrived at the gate/lobby.',
      'Please share gate entry instructions.',
      'I am waiting near the elevator.',
      'Your order has been handed over to reception.',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF181816),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: Color(0xFF2E2E2A), width: 1.2)),
        ),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 18,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.cardGoldAccent,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Secure Chat with $customerName',
                  style: GoogleFonts.fraunces(
                    color: AppColors.creamText,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Quick proxy messages sent via encrypted partner channel.',
              style: GoogleFonts.inter(
                color: const Color(0xFF8E8E93),
                fontSize: 12.5,
              ),
            ),
            const SizedBox(height: 16),

            // Quick templates
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: quickReplies.map((template) {
                return InkWell(
                  onTap: () {
                    textController.text = template;
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF222220),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF333330)),
                    ),
                    child: Text(
                      template,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFD4D4D8),
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Input field and send button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Type secure message...',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xFF71717A),
                        fontSize: 13.5,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF141413),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF2E2E2A)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0xFF2E2E2A)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: AppColors.cardGoldAccent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    final msg = textController.text.trim();
                    if (msg.isNotEmpty) {
                      Navigator.pop(sheetContext);
                      context
                          .read<CustomerCallBloc>()
                          .add(SendQuickMessageEvent(msg));
                    }
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.cardGoldAccent,
                    foregroundColor: const Color(0xFF11110F),
                    padding: const EdgeInsets.all(12),
                  ),
                  icon: const Icon(Icons.send_rounded, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCallBloc, CustomerCallState>(
      listener: (context, state) {
        if (state.feedbackMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF222220),
              content: Text(
                state.feedbackMessage!,
                style: GoogleFonts.inter(color: AppColors.creamText, fontSize: 13.5),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      },
      builder: (context, state) {
        final customer = state.data;

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: Column(
              children: [
                // Top Navigation row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1C),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF2E2E2A),
                              width: 1.0,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.creamText,
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
                            width: 104,
                            height: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF333330),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                customer.avatarAsset,
                                width: 104,
                                height: 104,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: const Color(0xFF2E2E2A),
                                  child: const Icon(
                                    Icons.person,
                                    size: 54,
                                    color: AppColors.cardGoldAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Customer Name: "Rohan Malhotra"
                        Text(
                          customer.customerName,
                          style: GoogleFonts.fraunces(
                            color: AppColors.creamText,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle: "Active Order #EG-7840"
                        Text(
                          'Active Order ${customer.orderId}',
                          style: GoogleFonts.inter(
                            color: AppColors.cardGoldAccent,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 24),

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
                            _showQuickChatSheet(context, customer.customerName);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Card 2: Customer History
                        CustomerHistoryCard(
                          totalOrdersPlaced: customer.totalOrdersPlaced,
                          memberSince: customer.memberSince,
                        ),
                        const SizedBox(height: 24),

                        // Bottom Button: "Go Back to Delivery Details"
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color(0xFF161615),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF2E2E2A),
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Go Back to Delivery Details',
                                style: GoogleFonts.inter(
                                  color: AppColors.creamText,
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w700,
                                ),
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
