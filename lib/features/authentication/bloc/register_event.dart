import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  final String name;
  const RegisterNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;
  const RegisterPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class RegisterCityChanged extends RegisterEvent {
  final String city;
  const RegisterCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class RegisterVehicleChanged extends RegisterEvent {
  final String vehicle;
  const RegisterVehicleChanged(this.vehicle);

  @override
  List<Object?> get props => [vehicle];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterTogglePasswordVisibility extends RegisterEvent {
  const RegisterTogglePasswordVisibility();
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
