import 'package:equatable/equatable.dart';

class DocumentVerificationState extends Equatable {
  final String? aadhaarImagePath;
  final bool isAadhaarUploaded;
  final String? panImagePath;
  final bool isPanUploaded;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const DocumentVerificationState({
    this.aadhaarImagePath,
    this.isAadhaarUploaded = false,
    this.panImagePath,
    this.isPanUploaded = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  DocumentVerificationState copyWith({
    String? aadhaarImagePath,
    bool? isAadhaarUploaded,
    String? panImagePath,
    bool? isPanUploaded,
    bool? isSubmitting,
    bool? isSuccess,
    Object? errorMessage = _undefined,
  }) {
    return DocumentVerificationState(
      aadhaarImagePath: aadhaarImagePath ?? this.aadhaarImagePath,
      isAadhaarUploaded: isAadhaarUploaded ?? this.isAadhaarUploaded,
      panImagePath: panImagePath ?? this.panImagePath,
      isPanUploaded: isPanUploaded ?? this.isPanUploaded,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
        aadhaarImagePath,
        isAadhaarUploaded,
        panImagePath,
        isPanUploaded,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}

const _undefined = Object();
