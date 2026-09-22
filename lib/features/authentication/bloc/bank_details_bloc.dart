import 'package:flutter_bloc/flutter_bloc.dart';
import 'bank_details_event.dart';
import 'bank_details_state.dart';

export 'bank_details_event.dart';
export 'bank_details_state.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  BankDetailsBloc() : super(const BankDetailsState()) {
    on<AccountHolderNameChanged>((event, emit) {
      final name = event.name.trim();
      String? error;
      if (name.isNotEmpty && name.length < 3) {
        error = 'Name must be at least 3 characters';
      }
      emit(state.copyWith(accountHolderName: event.name, nameError: error));
    });

    on<AccountNumberChanged>((event, emit) {
      final num = event.number.trim();
      String? error;
      if (num.isNotEmpty && (num.length < 9 || num.length > 18)) {
        error = 'Account number must be 9-18 digits';
      }
      String? confirmError = state.confirmAccountNumberError;
      if (state.confirmAccountNumber.isNotEmpty && state.confirmAccountNumber != num) {
        confirmError = 'Account numbers do not match';
      } else if (state.confirmAccountNumber == num) {
        confirmError = null;
      }
      emit(state.copyWith(
        accountNumber: event.number,
        accountNumberError: error,
        confirmAccountNumberError: confirmError,
      ));
    });

    on<ConfirmAccountNumberChanged>((event, emit) {
      final confirm = event.confirmNumber.trim();
      String? error;
      if (confirm.isNotEmpty && confirm != state.accountNumber.trim()) {
        error = 'Account numbers do not match';
      }
      emit(state.copyWith(confirmAccountNumber: event.confirmNumber, confirmAccountNumberError: error));
    });

    on<IfscCodeChanged>((event, emit) {
      final ifsc = event.ifsc.trim().toUpperCase();
      String? error;
      final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
      if (ifsc.isNotEmpty && !ifscRegex.hasMatch(ifsc)) {
        error = 'Enter a valid 11-character IFSC code (e.g. HDFC0001234)';
      }
      emit(state.copyWith(ifscCode: ifsc, ifscError: error));
    });

    on<BankDetailsSubmitted>((event, emit) async {
      final name = state.accountHolderName.trim();
      final accNum = state.accountNumber.trim();
      final confirmNum = state.confirmAccountNumber.trim();
      final ifsc = state.ifscCode.trim().toUpperCase();

      String? nameErr;
      String? accErr;
      String? confirmErr;
      String? ifscErr;

      final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

      if (name.isEmpty) {
        nameErr = 'Account holder name is required';
      } else if (name.length < 3) {
        nameErr = 'Name must be at least 3 characters';
      }

      if (accNum.isEmpty) {
        accErr = 'Account number is required';
      } else if (accNum.length < 9 || accNum.length > 18) {
        accErr = 'Account number must be 9-18 digits';
      }

      if (confirmNum.isEmpty) {
        confirmErr = 'Please confirm account number';
      } else if (confirmNum != accNum) {
        confirmErr = 'Account numbers do not match';
      }

      if (ifsc.isEmpty) {
        ifscErr = 'IFSC code is required';
      } else if (!ifscRegex.hasMatch(ifsc)) {
        ifscErr = 'Enter a valid 11-character IFSC code (e.g. HDFC0001234)';
      }

      final hasErrors = nameErr != null || accErr != null || confirmErr != null || ifscErr != null;

      if (hasErrors) {
        emit(state.copyWith(
          nameError: nameErr,
          accountNumberError: accErr,
          confirmAccountNumberError: confirmErr,
          ifscError: ifscErr,
        ));
        return;
      }

      emit(state.copyWith(
        nameError: null,
        accountNumberError: null,
        confirmAccountNumberError: null,
        ifscError: null,
        isSubmitting: true,
      ));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
