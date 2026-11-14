import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
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
        backgroundColor: AppColors.scaffoldBackground,
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
                // 1. Luxury Light Map Background
                Positioned.fill(
                  child: CustomPaint(
                    painter: LuxuryMapPainter(),
                  ),
                ),

                // 2. Top Floating ETA & Direction Card
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

                // 3. Bottom Delivery Destination Sheet
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
