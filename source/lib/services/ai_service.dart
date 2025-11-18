import 'package:dio/dio.dart';
import 'package:thap/models/ai_provider.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/service_locator.dart';

class AIService {
  final AISettingsService _settingsService = locator<AISettingsService>();
  final Dio _dio = Dio();

  Future<bool> validateApiKey(AIProvider provider, String apiKey) async {
    try {
      switch (provider) {
        case AIProvider.openai:
          return await _validateOpenAI(apiKey);
        case AIProvider.gemini:
          return await _validateGemini(apiKey);
        case AIProvider.perplexity:
          return await _validatePerplexity(apiKey);
        case AIProvider.deepseek:
          return await _validateDeepseek(apiKey);
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _validateOpenAI(String apiKey) async {
    try {
      final response = await _dio.get(
        '${AIProvider.openai.apiBaseUrl}/models',
        options: Options(
          headers: {'Authorization': 'Bearer $apiKey'},
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _validateGemini(String apiKey) async {
    try {
      final response = await _dio.get(
        '${AIProvider.gemini.apiBaseUrl}/models?key=$apiKey',
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _validatePerplexity(String apiKey) async {
    return apiKey.isNotEmpty;
  }

  Future<bool> _validateDeepseek(String apiKey) async {
    return apiKey.isNotEmpty;
  }

  Future<Stream<String>> askQuestion(
    String question,
    String productInfo,
  ) async {
    final provider = await _settingsService.getSelectedProvider();
    final apiKey = provider != null
        ? await _settingsService.getApiKey(provider)
        : null;

    if (provider == null || apiKey == null) {
      throw Exception('AI provider not configured');
    }

    final fullPrompt = '$question\n\nProduct: $productInfo';

    switch (provider) {
      case AIProvider.openai:
        return _askOpenAI(apiKey, fullPrompt);
      case AIProvider.gemini:
        return _askGemini(apiKey, fullPrompt);
      case AIProvider.perplexity:
        return _askPerplexity(apiKey, fullPrompt);
      case AIProvider.deepseek:
        return _askDeepseek(apiKey, fullPrompt);
    }
  }

  Stream<String> _askOpenAI(String apiKey, String prompt) async* {
    try {
      final response = await _dio.post(
        '${AIProvider.openai.apiBaseUrl}/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'stream': false,
        },
      );

      final content = response.data['choices'][0]['message']['content'];
      yield content;
    } catch (e) {
      yield 'Error: Unable to get response from OpenAI';
    }
  }

  Stream<String> _askGemini(String apiKey, String prompt) async* {
    try {
      final response = await _dio.post(
        '${AIProvider.gemini.apiBaseUrl}/models/gemini-pro:generateContent?key=$apiKey',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        },
      );

      final content = response.data['candidates'][0]['content']['parts'][0]
          ['text'];
      yield content;
    } catch (e) {
      yield 'Error: Unable to get response from Gemini';
    }
  }

  Stream<String> _askPerplexity(String apiKey, String prompt) async* {
    try {
      final response = await _dio.post(
        '${AIProvider.perplexity.apiBaseUrl}/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'llama-3.1-sonar-small-128k-online',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        },
      );

      final content = response.data['choices'][0]['message']['content'];
      yield content;
    } catch (e) {
      yield 'Error: Unable to get response from Perplexity';
    }
  }

  Stream<String> _askDeepseek(String apiKey, String prompt) async* {
    try {
      final response = await _dio.post(
        '${AIProvider.deepseek.apiBaseUrl}/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        },
      );

      final content = response.data['choices'][0]['message']['content'];
      yield content;
    } catch (e) {
      yield 'Error: Unable to get response from Deepseek';
    }
  }
}
