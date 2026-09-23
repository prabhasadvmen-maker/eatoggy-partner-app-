import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

export 'register_event.dart';
export 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterNameChanged>((event, emit) {
      final name = event.name.trim();
      String? error;
      if (name.isNotEmpty && name.length < 2) {
        error = 'Name must be at least 2 characters';
      }
      emit(state.copyWith(name: event.name, nameError: error));
    });

    on<RegisterEmailChanged>((event, emit) {
      final email = event.email.trim();
      String? error;
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (email.isNotEmpty && !emailRegex.hasMatch(email)) {
        error = 'Enter a valid email address';
      }
      emit(state.copyWith(email: event.email, emailError: error));
    });

    on<RegisterPhoneChanged>((event, emit) {
      final phone = event.phone.trim();
      String? error;
      if (phone.isNotEmpty && !RegExp(r'^[0-9]{10}$').hasMatch(phone.replaceAll(' ', ''))) {
        error = 'Enter a valid 10-digit mobile number';
      }
      emit(state.copyWith(phone: event.phone, phoneError: error));
    });

    on<RegisterCityChanged>((event, emit) {
      emit(state.copyWith(selectedCity: event.city, cityError: null));
    });

    on<RegisterVehicleChanged>((event, emit) {
      emit(state.copyWith(selectedVehicle: event.vehicle, vehicleError: null));
    });

    on<RegisterPasswordChanged>((event, emit) {
      final password = event.password;
      String? error;
      if (password.isNotEmpty && password.length < 6) {
        error = 'Password must be at least 6 characters';
      }
      emit(state.copyWith(password: event.password, passwordError: error));
    });

    on<RegisterTogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(obscurePassword: !state.obscurePassword));
    });

    on<RegisterSubmitted>((event, emit) async {
      final name = state.name.trim();
      final email = state.email.trim();
      final phoneDigits = state.phone.replaceAll(' ', '').trim();
      final city = state.selectedCity;
      final vehicle = state.selectedVehicle;
      final password = state.password;

      String? nameErr;
      String? emailErr;
      String? phoneErr;
      String? cityErr;
      String? vehicleErr;
      String? passwordErr;

      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (name.isEmpty) {
        nameErr = 'Full name is required';
      } else if (name.length < 2) {
        nameErr = 'Name must be at least 2 characters';
      }

      if (email.isEmpty) {
        emailErr = 'Email address is required';
      } else if (!emailRegex.hasMatch(email)) {
        emailErr = 'Enter a valid email address';
      }

      if (phoneDigits.isEmpty) {
        phoneErr = 'Mobile number is required';
      } else if (phoneDigits.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phoneDigits)) {
        phoneErr = 'Enter a valid 10-digit mobile number';
      }

      if (city == null || city.isEmpty) {
        cityErr = 'Please select operational city';
      }

      if (vehicle == null || vehicle.isEmpty) {
        vehicleErr = 'Please select vehicle type';
      }

      if (password.isEmpty) {
        passwordErr = 'Password is required';
      } else if (password.length < 6) {
        passwordErr = 'Password must be at least 6 characters';
      }

      final hasErrors = nameErr != null ||
          emailErr != null ||
          phoneErr != null ||
          cityErr != null ||
          vehicleErr != null ||
          passwordErr != null;

      if (hasErrors) {
        emit(state.copyWith(
          nameError: nameErr,
          emailError: emailErr,
          phoneError: phoneErr,
          cityError: cityErr,
          vehicleError: vehicleErr,
          passwordError: passwordErr,
        ));
        return;
      }

      emit(state.copyWith(
        nameError: null,
        emailError: null,
        phoneError: null,
        cityError: null,
        vehicleError: null,
        passwordError: null,
        isSubmitting: true,
      ));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}

