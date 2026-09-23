import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'active_navigation_event.dart';
import 'active_navigation_state.dart';
import '../../data/models/active_navigation_model.dart';

class ActiveNavigationBloc
    extends Bloc<ActiveNavigationEvent, ActiveNavigationState> {
  ActiveNavigationBloc() : super(const ActiveNavigationState()) {
    on<LoadActiveNavigationEvent>(_onLoadActiveNavigation);
    on<OpenGoogleMapsEvent>(_onOpenGoogleMaps);
    on<MarkArrivedEvent>(_onMarkArrived);
  }

  void _onLoadActiveNavigation(
      LoadActiveNavigationEvent event, Emitter<ActiveNavigationState> emit) {
    emit(state.copyWith(
      status: NavigationStatus.navigating,
      navigationData:
          ActiveNavigationModel.defaultNavigation.copyWith(orderId: event.orderId),
    ));
  }

  Future<void> _onOpenGoogleMaps(
      OpenGoogleMapsEvent event, Emitter<ActiveNavigationState> emit) async {
    final lat = state.navigationData.latitude;
    final lng = state.navigationData.longitude;
    final address = state.navigationData.destinationAddress;

    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        final fallbackUri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
        );
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      emit(state.copyWith(
        message: 'Could not open Google Maps navigation.',
      ));
    }
  }

  void _onMarkArrived(
      MarkArrivedEvent event, Emitter<ActiveNavigationState> emit) {
    emit(state.copyWith(
      status: NavigationStatus.arrived,
      navigationData: state.navigationData.copyWith(isArrived: true),
      message: 'You have arrived at ${state.navigationData.destinationTitle}!',
    ));
  }
}
