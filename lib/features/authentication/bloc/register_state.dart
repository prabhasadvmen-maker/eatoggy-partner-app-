import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String name;
  final String? nameError;
  final String email;
  final String? emailError;
  final String phone;
  final String? phoneError;
  final String? selectedCity;
  final String? cityError;
  final String? selectedVehicle;
  final String? vehicleError;
  final String password;
  final String? passwordError;
  final bool obscurePassword;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.name = '',
    this.nameError,
    this.email = '',
    this.emailError,
    this.phone = '',
    this.phoneError,
    this.selectedCity,
    this.cityError,
    this.selectedVehicle,
    this.vehicleError,
    this.password = '',
    this.passwordError,
    this.obscurePassword = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? name,
    Object? nameError = _undefined,
    String? email,
    Object? emailError = _undefined,
    String? phone,
    Object? phoneError = _undefined,
    String? selectedCity,
    Object? cityError = _undefined,
    String? selectedVehicle,
    Object? vehicleError = _undefined,
    String? password,
    Object? passwordError = _undefined,
    bool? obscurePassword,
    bool? isSubmitting,
    bool? isSuccess,
    Object? errorMessage = _undefined,
  }) {
    return RegisterState(
      name: name ?? this.name,
      nameError: nameError == _undefined ? this.nameError : nameError as String?,
      email: email ?? this.email,
      emailError: emailError == _undefined ? this.emailError : emailError as String?,
      phone: phone ?? this.phone,
      phoneError: phoneError == _undefined ? this.phoneError : phoneError as String?,
      selectedCity: selectedCity ?? this.selectedCity,
      cityError: cityError == _undefined ? this.cityError : cityError as String?,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      vehicleError: vehicleError == _undefined ? this.vehicleError : vehicleError as String?,
      password: password ?? this.password,
      passwordError: passwordError == _undefined ? this.passwordError : passwordError as String?,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
        name,
        nameError,
        email,
        emailError,
        phone,
        phoneError,
        selectedCity,
        cityError,
        selectedVehicle,
        vehicleError,
        password,
        passwordError,
        obscurePassword,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}

const _undefined = Object();
