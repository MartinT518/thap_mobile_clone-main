import 'package:thap/features/settings/domain/entities/settings.dart';

/// Settings repository interface
abstract class SettingsRepository {
  /// Get user settings
  Future<Settings> getSettings();

  /// Update settings
  Future<void> updateSettings(Settings settings);

  /// Update language
  Future<void> updateLanguage(String languageCode);

  /// Update country
  Future<void> updateCountry(String countryCode);
}

