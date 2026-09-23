import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/active_navigation/active_navigation_bloc.dart';
import '../../bloc/active_navigation/active_navigation_event.dart';
import '../../bloc/active_navigation/active_navigation_state.dart';
import '../widgets/luxury_map_painter.dart';
import '../widgets/navigation_eta_card.dart';
import '../widgets/navigation_destination_sheet.dart';
import 'active_tour_screen.dart';

class ActiveNavigationScreen extends StatelessWidget {
  final String orderId;

  const ActiveNavigationScreen({
    super.key,
    this.orderId = '#EG-7840',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ActiveNavigationBloc()..add(LoadActiveNavigationEvent(orderId)),
      child: const ActiveNavigationView(),
    );
  }
}

class ActiveNavigationView extends StatelessWidget {
  const ActiveNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0E),
        body: BlocConsumer<ActiveNavigationBloc, ActiveNavigationState>(
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
            final nav = state.navigationData;

            return Stack(
              children: [
                // 1. Luxury Dark-Gold Geometric Map Background
                Positioned.fill(
                  child: CustomPaint(
                    painter: LuxuryMapPainter(),
                  ),
                ),

                // 2. Watermark overlay text at bottom center matching screenshot
                Positioned(
                  bottom: 145,
                  left: 18,
                  child: Row(
                    children: [
                      Text(
                        'CITY XPLORER',
                        style: TextStyle(
                          color: const Color(0xFF5A4A28).withValues(alpha: 0.4),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.search_rounded,
                        color: const Color(0xFF5A4A28).withValues(alpha: 0.4),
                        size: 20,
                      ),
                    ],
                  ),
                ),

                // 3. Top Floating ETA & Direction Card
                Positioned(
                  top: 0,
                  left: 16,
                  right: 16,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: NavigationEtaCard(
                        etaMinutes: nav.etaMinutes,
                        distanceKm: nav.distanceKm,
                        turnDirection: nav.turnDirection,
                        onBack: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),

                // 4. Bottom Delivery Destination Sheet
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: NavigationDestinationSheet(
                    destinationTitle: nav.destinationTitle,
                    destinationDetails: nav.destinationDetails,
                    isArrived: nav.isArrived,
                    onOpenMaps: () {
                      context
                          .read<ActiveNavigationBloc>()
                          .add(const OpenGoogleMapsEvent());
                    },
                    onMarkArrived: () {
                      context
                          .read<ActiveNavigationBloc>()
                          .add(const MarkArrivedEvent());
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActiveTourScreen(
                            orderId: nav.orderId,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
