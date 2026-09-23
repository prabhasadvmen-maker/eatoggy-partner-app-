import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/notification_model.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc
    extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
  }

  void _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) {
    const list = NotificationItemModel.sampleNotifications;
    final unread = list.where((item) => !item.isRead).length;

    emit(state.copyWith(
      status: NotificationsStateStatus.loaded,
      notifications: list,
      unreadCount: unread,
    ));
  }

  void _onMarkAllAsRead(
    MarkAllAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) {
    final updated = state.notifications.map((item) {
      return item.copyWith(isRead: true);
    }).toList();

    emit(state.copyWith(
      notifications: updated,
      unreadCount: 0,
    ));
  }

  void _onMarkNotificationAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationsState> emit,
  ) {
    final updated = state.notifications.map((item) {
      if (item.id == event.notificationId) {
        return item.copyWith(isRead: true);
      }
      return item;
    }).toList();

    final unread = updated.where((item) => !item.isRead).length;

    emit(state.copyWith(
      notifications: updated,
      unreadCount: unread,
    ));
  }
}
