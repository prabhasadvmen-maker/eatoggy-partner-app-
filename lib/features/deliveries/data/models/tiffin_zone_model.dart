import 'package:equatable/equatable.dart';

class TiffinRouteStop extends Equatable {
  final String id;
  final String timeSlot;
  final String tiffinsCount;
  final String customerName;
  final String address;

  const TiffinRouteStop({
    required this.id,
    required this.timeSlot,
    required this.tiffinsCount,
    required this.customerName,
    required this.address,
  });

  @override
  List<Object?> get props => [id, timeSlot, tiffinsCount, customerName, address];
}

class TiffinZoneModel extends Equatable {
  final String title;
  final String subtitle;
  final String radiusBadge;
  final String zoneName;
  final String zoneSubtitle;
  final String subscribersCount;
  final String todayRuns;
  final String completedRuns;
  final List<TiffinRouteStop> routeStops;

  const TiffinZoneModel({
    required this.title,
    required this.subtitle,
    required this.radiusBadge,
    required this.zoneName,
    required this.zoneSubtitle,
    required this.subscribersCount,
    required this.todayRuns,
    required this.completedRuns,
    required this.routeStops,
  });

  static const sampleZone = TiffinZoneModel(
    title: 'My Tiffin Zone',
    subtitle: 'Exclusive Assigned Territory',
    radiusBadge: '10 KM RADIUS',
    zoneName: 'Indiranagar – Koramangala Zone',
    zoneSubtitle: 'High-density tiffin delivery sector • 18 active runs today',
    subscribersCount: '24 Active',
    todayRuns: '18',
    completedRuns: '7 / 18',
    routeStops: [
      TiffinRouteStop(
        id: 'stop_1',
        timeSlot: '12:00 PM – 1:00 PM LUNCH',
        tiffinsCount: '2 TIFFINS',
        customerName: 'Meera Krishnan',
        address: 'Penthouse A, Skyline Manor Residences',
      ),
      TiffinRouteStop(
        id: 'stop_2',
        timeSlot: '7:00 PM – 8:00 PM DINNER',
        tiffinsCount: '3 TIFFINS',
        customerName: "Sarah D'Souza",
        address: 'Villa 12, Ferns Meadows',
      ),
      TiffinRouteStop(
        id: 'stop_3',
        timeSlot: '7:30 PM – 8:30 PM DINNER',
        tiffinsCount: '1 TIFFINS',
        customerName: 'Aarav Mehta',
        address: 'Tower B, Sobha Silicon Oasis',
      ),
    ],
  );

  @override
  List<Object?> get props => [
        title,
        subtitle,
        radiusBadge,
        zoneName,
        zoneSubtitle,
        subscribersCount,
        todayRuns,
        completedRuns,
        routeStops,
      ];
}
