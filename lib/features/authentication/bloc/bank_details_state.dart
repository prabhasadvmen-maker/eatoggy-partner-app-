import 'package:equatable/equatable.dart';

class BankDetailsState extends Equatable {
  final String accountHolderName;
  final String? nameError;
  final String accountNumber;
  final String? accountNumberError;
  final String confirmAccountNumber;
  final String? confirmAccountNumberError;
  final String ifscCode;
  final String? ifscError;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const BankDetailsState({
    this.accountHolderName = 'Ravi Kumar',
    this.nameError,
    this.accountNumber = '',
    this.accountNumberError,
    this.confirmAccountNumber = '',
    this.confirmAccountNumberError,
    this.ifscCode = 'HDFC0001234',
    this.ifscError,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  BankDetailsState copyWith({
    String? accountHolderName,
    Object? nameError = _undefined,
    String? accountNumber,
    Object? accountNumberError = _undefined,
    String? confirmAccountNumber,
    Object? confirmAccountNumberError = _undefined,
    String? ifscCode,
    Object? ifscError = _undefined,
    bool? isSubmitting,
    bool? isSuccess,
    Object? errorMessage = _undefined,
  }) {
    return BankDetailsState(
      accountHolderName: accountHolderName ?? this.accountHolderName,
      nameError: nameError == _undefined ? this.nameError : nameError as String?,
      accountNumber: accountNumber ?? this.accountNumber,
      accountNumberError: accountNumberError == _undefined ? this.accountNumberError : accountNumberError as String?,
      confirmAccountNumber: confirmAccountNumber ?? this.confirmAccountNumber,
      confirmAccountNumberError: confirmAccountNumberError == _undefined ? this.confirmAccountNumberError : confirmAccountNumberError as String?,
      ifscCode: ifscCode ?? this.ifscCode,
      ifscError: ifscError == _undefined ? this.ifscError : ifscError as String?,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
        accountHolderName,
        nameError,
        accountNumber,
        accountNumberError,
        confirmAccountNumber,
        confirmAccountNumberError,
        ifscCode,
        ifscError,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}

const _undefined = Object();
