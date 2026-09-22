class DeliveryIssueReportModel {
  final String orderId;
  final String selectedReason;
  final List<String> availableReasons;
  final String additionalNotes;
  final String? photoEvidencePath;
  final bool isSubmitted;

  const DeliveryIssueReportModel({
    required this.orderId,
    this.selectedReason = 'Customer unavailable',
    this.availableReasons = const [
      'Customer unavailable',
      'Wrong address provided',
      'Customer refused package',
      'Other issue',
    ],
    this.additionalNotes = '',
    this.photoEvidencePath,
    this.isSubmitted = false,
  });

  DeliveryIssueReportModel copyWith({
    String? orderId,
    String? selectedReason,
    List<String>? availableReasons,
    String? additionalNotes,
    String? photoEvidencePath,
    bool clearPhotoEvidence = false,
    bool? isSubmitted,
  }) {
    return DeliveryIssueReportModel(
      orderId: orderId ?? this.orderId,
      selectedReason: selectedReason ?? this.selectedReason,
      availableReasons: availableReasons ?? this.availableReasons,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      photoEvidencePath: clearPhotoEvidence
          ? null
          : (photoEvidencePath ?? this.photoEvidencePath),
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  static DeliveryIssueReportModel getDummyData(String orderId) {
    return DeliveryIssueReportModel(
      orderId: orderId,
      selectedReason: 'Customer unavailable',
      availableReasons: const [
        'Customer unavailable',
        'Wrong address provided',
        'Customer refused package',
        'Other issue',
      ],
      additionalNotes: '',
    );
  }
}
