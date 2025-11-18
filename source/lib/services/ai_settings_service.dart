import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/models/ai_provider.dart';

class AISettingsService {
  static const String _selectedProviderKey = 'selected_ai_provider';
  static const String _apiKeyPrefix = 'ai_api_key_';

  Future<AIProvider?> getSelectedProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final providerName = prefs.getString(_selectedProviderKey);
    
    if (providerName == null) return null;
    
    try {
      return AIProvider.values.firstWhere(
        (p) => p.name == providerName,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> setSelectedProvider(AIProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedProviderKey, provider.name);
  }

  Future<String?> getApiKey(AIProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_apiKeyPrefix${provider.name}');
  }

  Future<void> setApiKey(AIProvider provider, String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_apiKeyPrefix${provider.name}', apiKey);
  }

  Future<void> clearApiKey(AIProvider provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_apiKeyPrefix${provider.name}');
  }

  Future<bool> isProviderConfigured(AIProvider provider) async {
    final apiKey = await getApiKey(provider);
    return apiKey != null && apiKey.isNotEmpty;
  }

  Future<bool> hasActiveProvider() async {
    final provider = await getSelectedProvider();
    if (provider == null) return false;
    return await isProviderConfigured(provider);
  }
}
