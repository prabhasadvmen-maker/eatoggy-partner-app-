import 'package:equatable/equatable.dart';

enum NotificationType {
  assignment,
  support,
  alert,
  payout,
}

class NotificationItemModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String timeAgo;
  final bool isRead;
  final NotificationType type;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.isRead,
    required this.type,
  });

  NotificationItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? timeAgo,
    bool? isRead,
    NotificationType? type,
  }) {
    return NotificationItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeAgo: timeAgo ?? this.timeAgo,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }

  static const List<NotificationItemModel> sampleNotifications = [
    NotificationItemModel(
      id: 'notif_1',
      title: 'New Assignment',
      description: 'Order #EG-7841 assigned. Pickup within 15 mins.',
      timeAgo: '2 mins ago',
      isRead: false,
      type: NotificationType.assignment,
    ),
    NotificationItemModel(
      id: 'notif_2',
      title: 'Support Ticket Resolved',
      description: 'Your support ticket #TK-301 has been marked resolved.',
      timeAgo: '1 hour ago',
      isRead: false,
      type: NotificationType.support,
    ),
    NotificationItemModel(
      id: 'notif_3',
      title: 'Potential Delay Warning',
      description: 'Heavy traffic detected near Indiranagar. Drive safely.',
      timeAgo: '3 hours ago',
      isRead: true,
      type: NotificationType.alert,
    ),
    NotificationItemModel(
      id: 'notif_4',
      title: 'Payout Processed',
      description: 'Payout of ₹3,450.00 processed to your linked bank account.',
      timeAgo: 'Yesterday',
      isRead: true,
      type: NotificationType.payout,
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timeAgo,
        isRead,
        type,
      ];
}
