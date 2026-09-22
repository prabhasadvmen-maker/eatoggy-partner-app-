import 'package:equatable/equatable.dart';

enum SubscriberStatus {
  active,
  paused,
}

class TiffinSubscriberModel extends Equatable {
  final String id;
  final String name;
  final String plan;
  final String address;
  final String subscriptionSince;
  final SubscriberStatus status;
  final bool isNew;
  final String avatarUrl;

  const TiffinSubscriberModel({
    required this.id,
    required this.name,
    required this.plan,
    required this.address,
    required this.subscriptionSince,
    required this.status,
    this.isNew = false,
    this.avatarUrl = '',
  });

  static const List<TiffinSubscriberModel> sampleSubscribers = [
    TiffinSubscriberModel(
      id: 'sub_1',
      name: 'Meera Krishnan',
      plan: 'Lunch + Dinner',
      address: 'Penthouse A, Skyline Manor Residences',
      subscriptionSince: '12 Oct 2025',
      status: SubscriberStatus.active,
      isNew: true,
      avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80',
    ),
    TiffinSubscriberModel(
      id: 'sub_2',
      name: 'Rahul Deshmukh',
      plan: 'Lunch Only',
      address: '42, Residency Road, Indiranagar',
      subscriptionSince: '01 Nov 2025',
      status: SubscriberStatus.active,
      isNew: false,
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
    ),
    TiffinSubscriberModel(
      id: 'sub_3',
      name: 'Ananya Iyer',
      plan: 'Lunch + Dinner',
      address: 'Block B, Prestige Heights, Koramangala',
      subscriptionSince: '20 Sep 2025',
      status: SubscriberStatus.paused,
      isNew: false,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
    ),
    TiffinSubscriberModel(
      id: 'sub_4',
      name: 'Vikram Singhania',
      plan: 'Dinner Only',
      address: 'Flat 402, Palm Grove, HSR Layout',
      subscriptionSince: '05 Nov 2025',
      status: SubscriberStatus.active,
      isNew: true,
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
    ),
    TiffinSubscriberModel(
      id: 'sub_5',
      name: "Sarah D'Souza",
      plan: 'Lunch + Dinner',
      address: 'Villa 12, Ferns Meadows',
      subscriptionSince: '15 Aug 2025',
      status: SubscriberStatus.active,
      isNew: false,
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&auto=format&fit=crop&q=80',
    ),
  ];

  @override
  List<Object?> get props => [
        id,
        name,
        plan,
        address,
        subscriptionSince,
        status,
        isNew,
        avatarUrl,
      ];
}
