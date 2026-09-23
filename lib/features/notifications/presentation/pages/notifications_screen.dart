import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../bloc/notifications_bloc.dart';
import '../../bloc/notifications_event.dart';
import '../../bloc/notifications_state.dart';
import '../widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const NotificationsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationsBloc()..add(const LoadNotificationsEvent()),
      child: NotificationsView(onBack: onBack),
    );
  }
}

class NotificationsView extends StatelessWidget {
  final VoidCallback? onBack;

  const NotificationsView({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (onBack != null) {
          onBack!();
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Back Arrow + Title + "Mark all as read"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (onBack != null) ...[
                          GestureDetector(
                            onTap: onBack,
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: 38,
                              height: 38,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B1B1D),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF2C2C2E),
                                  width: 0.8,
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
                        Expanded(
                          child: Text(
                            'Notifications',
                            style: AppTextStyles.displayLarge.copyWith(
                              color: AppColors.creamText,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<NotificationsBloc>()
                                .add(const MarkAllAsReadEvent());
                          },
                          child: Text(
                            'Mark all as read',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.cardGoldAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.cardGoldAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Notifications List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return NotificationCard(
                          notification: notification,
                          onTap: () {
                            context.read<NotificationsBloc>().add(
                                  MarkNotificationAsReadEvent(notification.id),
                                );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
