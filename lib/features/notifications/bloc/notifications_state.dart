import 'package:equatable/equatable.dart';
import '../data/models/notification_model.dart';

enum NotificationsStateStatus { initial, loading, loaded, error }

class NotificationsState extends Equatable {
  final NotificationsStateStatus status;
  final List<NotificationItemModel> notifications;
  final int unreadCount;

  const NotificationsState({
    this.status = NotificationsStateStatus.initial,
    this.notifications = const [],
    this.unreadCount = 2,
  });

  NotificationsState copyWith({
    NotificationsStateStatus? status,
    List<NotificationItemModel>? notifications,
    int? unreadCount,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notifications,
        unreadCount,
      ];
}
