class Configuration {
  Configuration._();
  static const String apiUrl = 'https://tingsapi.test.mindworks.ee/api';
  // static const String apiUrl = 'https://192.168.10.103:7256/api';
  static Duration apiTimeout = const Duration(seconds: 60);
  static const bool apiPrettyLog = true;

  static const String openGraphAppId = 'e5d65371-eaa9-4eca-b527-0e15b9edbff3';
}
