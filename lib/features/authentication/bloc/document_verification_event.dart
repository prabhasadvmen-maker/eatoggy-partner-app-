import 'package:equatable/equatable.dart';

abstract class DocumentVerificationEvent extends Equatable {
  const DocumentVerificationEvent();

  @override
  List<Object?> get props => [];
}

class UploadAadhaarFromCamera extends DocumentVerificationEvent {
  const UploadAadhaarFromCamera();
}

class UploadPanFromCamera extends DocumentVerificationEvent {
  const UploadPanFromCamera();
}

class DocumentVerificationSubmitted extends DocumentVerificationEvent {
  const DocumentVerificationSubmitted();
}
