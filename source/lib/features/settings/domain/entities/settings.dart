/// User settings entity
class Settings {
  final String? language;
  final String? country;
  final bool marketingConsent;
  final bool analyticsConsent;

  const Settings({
    this.language,
    this.country,
    this.marketingConsent = false,
    this.analyticsConsent = false,
  });

  Settings copyWith({
    String? language,
    String? country,
    bool? marketingConsent,
    bool? analyticsConsent,
  }) {
    return Settings(
      language: language ?? this.language,
      country: country ?? this.country,
      marketingConsent: marketingConsent ?? this.marketingConsent,
      analyticsConsent: analyticsConsent ?? this.analyticsConsent,
    );
  }
}

