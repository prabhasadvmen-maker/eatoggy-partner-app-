import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpDigitChanged extends OtpEvent {
  final int index;
  final String digit;
  const OtpDigitChanged(this.index, this.digit);

  @override
  List<Object?> get props => [index, digit];
}

class OtpTick extends OtpEvent {
  const OtpTick();
}

class OtpResendRequested extends OtpEvent {
  const OtpResendRequested();
}

class OtpSubmitted extends OtpEvent {
  const OtpSubmitted();
}
