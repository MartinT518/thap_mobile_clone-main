import 'package:thap/core/config/env.dart';

/// Application constants
class AppConstants {
  AppConstants._();

  // API Configuration
  static const String apiBaseUrl = Env.apiBaseUrl;
  static const Duration apiTimeout = Env.apiTimeout;

  // Scan History
  static const int maxScanHistoryItems = 100;

  // AI Assistant
  static const int maxConversationMessages = 20;
  static const List<String> demoApiKeys = ['demo', 'test', 'demo-key-123'];

  // AI Providers
  static const String openaiBaseUrl = 'https://api.openai.com/v1';
  static const String geminiBaseUrl =
      'https://generativelanguage.googleapis.com/v1';
  static const String perplexityBaseUrl = 'https://api.perplexity.ai';
  static const String deepseekBaseUrl = 'https://api.deepseek.com/v1';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String languageKey = 'language';
  static const String countryKey = 'country';
  static const String aiProviderKey = 'ai_provider';
  static const String aiApiKeyPrefix = 'ai_key_';

  // Supported Languages
  static const List<String> supportedLanguageCodes = [
    'en',
    'et',
    'sv',
    'lt',
    'lv',
    'de',
    'fi',
    'fr',
    'es',
    'it',
    'da',
    'nl',
    'pt',
    'pl',
    'ru',
  ];
}

