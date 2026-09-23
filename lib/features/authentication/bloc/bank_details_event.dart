import 'package:equatable/equatable.dart';

abstract class BankDetailsEvent extends Equatable {
  const BankDetailsEvent();

  @override
  List<Object?> get props => [];
}

class AccountHolderNameChanged extends BankDetailsEvent {
  final String name;
  const AccountHolderNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class AccountNumberChanged extends BankDetailsEvent {
  final String number;
  const AccountNumberChanged(this.number);

  @override
  List<Object?> get props => [number];
}

class ConfirmAccountNumberChanged extends BankDetailsEvent {
  final String confirmNumber;
  const ConfirmAccountNumberChanged(this.confirmNumber);

  @override
  List<Object?> get props => [confirmNumber];
}

class IfscCodeChanged extends BankDetailsEvent {
  final String ifsc;
  const IfscCodeChanged(this.ifsc);

  @override
  List<Object?> get props => [ifsc];
}

class BankDetailsSubmitted extends BankDetailsEvent {
  const BankDetailsSubmitted();
}
