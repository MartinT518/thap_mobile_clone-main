class UserDataResult {
  String countryCode;
  String languageCode;
  bool allowFeedback;
  bool consentMarketing;

  UserDataResult({
    required this.countryCode,
    required this.languageCode,
    this.allowFeedback = false,
    this.consentMarketing = false,
  });

  factory UserDataResult.fromJson(Map<String, dynamic> json) {
    return UserDataResult(
      countryCode: json['countryCode'] ?? '',
      languageCode: json['languageCode'] ?? '',
      allowFeedback: json['allowFeedback'] ?? false,
      consentMarketing: json['consentMarketing'] ?? false,
    );
  }
}
