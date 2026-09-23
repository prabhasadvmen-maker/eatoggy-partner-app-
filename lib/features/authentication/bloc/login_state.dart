import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String phone;
  final String? phoneError;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    this.phone = '',
    this.phoneError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? phone,
    Object? phoneError = _undefined,
    bool? isSubmitting,
    bool? isSuccess,
    Object? errorMessage = _undefined,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      phoneError: phoneError == _undefined ? this.phoneError : phoneError as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [phone, phoneError, isSubmitting, isSuccess, errorMessage];
}

const _undefined = Object();

