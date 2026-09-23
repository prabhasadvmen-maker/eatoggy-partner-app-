import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;
  const LoginPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
