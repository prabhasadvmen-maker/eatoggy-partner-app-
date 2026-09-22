import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

export 'splash_event.dart';
export 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashInitial()) {
    on<SplashStarted>((event, emit) async {
      // Increased splash screen duration from 5 seconds to 8 seconds
      await Future.delayed(const Duration(seconds: 3));
      emit(const SplashCompleted());
    });
  }
}
