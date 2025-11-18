class UserDataResult {
  String countryCode;
  String languageCode;

  UserDataResult({required this.countryCode, required this.languageCode});

  factory UserDataResult.fromJson(Map<String, dynamic> json) {
    return UserDataResult(
        countryCode: json['countryCode'], languageCode: json['languageCode']);
  }
}
