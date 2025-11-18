/// Environment configuration
/// Set demo mode at compile time: flutter run --dart-define=DEMO_MODE=true
class Env {
  Env._();

  /// Demo mode flag - set at compile time
  static const bool isDemoMode = bool.fromEnvironment(
    'DEMO_MODE',
    defaultValue: false,
  );

  /// API base URL
  static const String apiBaseUrl = isDemoMode
      ? 'http://localhost:3000' // Not used in demo mode
      : 'https://tingsapi.test.mindworks.ee/api';

  /// API timeout duration
  static const Duration apiTimeout = Duration(seconds: 60);

  /// Enable pretty API logging
  static const bool apiPrettyLog = true;

  /// OpenGraph App ID
  static const String openGraphAppId = 'e5d65371-eaa9-4eca-b527-0e15b9edbff3';
}

