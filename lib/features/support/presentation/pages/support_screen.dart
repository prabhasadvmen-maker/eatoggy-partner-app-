import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/support_bloc.dart';
import '../../bloc/support_event.dart';
import '../../bloc/support_state.dart';
import '../widgets/faq_accordion_card.dart';
import '../widgets/direct_lines_card.dart';

class SupportScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SupportScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupportBloc()..add(const LoadSupportFaqsEvent()),
      child: SupportView(onBack: onBack),
    );
  }
}

class SupportView extends StatelessWidget {
  final VoidCallback onBack;

  const SupportView({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onBack();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: BlocConsumer<SupportBloc, SupportState>(
            listener: (context, state) {
              if (state.message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),

                    // Top Header Row with Circular Back Arrow Button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onBack,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: AppColors.textPrimary,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Screen Title (Fraunces Warm Serif)
                    Text(
                      'Support',
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtitle
                    Text(
                      'We are at your disposal for any operational assistance',
                      style: GoogleFonts.geist(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Category Header: FAQ SECTIONS
                    Text(
                      'FAQ SECTIONS',
                      style: GoogleFonts.geist(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Accordion FAQ Cards List
                    ...state.faqs.map(
                      (faq) => FaqAccordionCard(
                        faq: faq,
                        isExpanded: state.expandedFaqId == faq.id,
                        onTap: () {
                          context
                              .read<SupportBloc>()
                              .add(ToggleFaqExpansionEvent(faq.id));
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Direct Lines Card (Call Support & Chat Support)
                    DirectLinesCard(
                      onCallSupport: () {
                        context
                            .read<SupportBloc>()
                            .add(const CallSupportEvent());
                      },
                      onChatSupport: () {
                        context
                            .read<SupportBloc>()
                            .add(const ChatSupportEvent());
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
