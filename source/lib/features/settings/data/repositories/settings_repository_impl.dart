import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:thap/features/settings/domain/entities/settings.dart';
import 'package:thap/features/settings/domain/repositories/settings_repository.dart';

/// Settings repository implementation
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  SettingsRepositoryImpl(this._remoteDataSource, this._prefs);

  static const String _languageKey = 'user_language';
  static const String _countryKey = 'user_country';
  static const String _marketingConsentKey = 'marketing_consent';
  static const String _analyticsConsentKey = 'analytics_consent';

  @override
  Future<Settings> getSettings() async {
    if (Env.isDemoMode) {
      return Settings(
        language: _prefs.getString(_languageKey),
        country: _prefs.getString(_countryKey),
        marketingConsent: _prefs.getBool(_marketingConsentKey) ?? false,
        analyticsConsent: _prefs.getBool(_analyticsConsentKey) ?? false,
      );
    }

    try {
      final data = await _remoteDataSource.getSettings();
      return Settings(
        language: data['language'],
        country: data['country'],
        marketingConsent: data['marketingConsent'] ?? false,
        analyticsConsent: data['analyticsConsent'] ?? false,
      );
    } catch (e) {
      // Fallback to local storage
      return Settings(
        language: _prefs.getString(_languageKey),
        country: _prefs.getString(_countryKey),
        marketingConsent: _prefs.getBool(_marketingConsentKey) ?? false,
        analyticsConsent: _prefs.getBool(_analyticsConsentKey) ?? false,
      );
    }
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    // Save locally first
    if (settings.language != null) {
      await _prefs.setString(_languageKey, settings.language!);
    }
    if (settings.country != null) {
      await _prefs.setString(_countryKey, settings.country!);
    }
    await _prefs.setBool(_marketingConsentKey, settings.marketingConsent);
    await _prefs.setBool(_analyticsConsentKey, settings.analyticsConsent);

    // Sync to backend if not in demo mode
    if (!Env.isDemoMode) {
      try {
        await _remoteDataSource.updateSettings({
          'language': settings.language,
          'country': settings.country,
          'marketingConsent': settings.marketingConsent,
          'analyticsConsent': settings.analyticsConsent,
        });
      } catch (e) {
        // Settings saved locally, sync will retry later
      }
    }
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
    if (!Env.isDemoMode) {
      try {
        await _remoteDataSource.updateSettings({'language': languageCode});
      } catch (e) {
        // Saved locally
      }
    }
  }

  @override
  Future<void> updateCountry(String countryCode) async {
    await _prefs.setString(_countryKey, countryCode);
    if (!Env.isDemoMode) {
      try {
        await _remoteDataSource.updateSettings({'country': countryCode});
      } catch (e) {
        // Saved locally
      }
    }
  }
}

