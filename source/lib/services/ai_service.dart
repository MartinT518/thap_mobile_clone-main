import 'package:dio/dio.dart';
import 'package:thap/models/ai_provider.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/service_locator.dart';

class AIService {
  final AISettingsService _settingsService = locator<AISettingsService>();
  final Dio _dio = Dio();

  static const String demoApiKey = 'demo-key-123';

  bool _isDemoMode(String apiKey) {
    return apiKey == demoApiKey ||
        apiKey.toLowerCase() == 'demo' ||
        apiKey.toLowerCase() == 'test';
  }

  Future<bool> validateApiKey(AIProvider provider, String apiKey) async {
    if (_isDemoMode(apiKey)) {
      return true;
    }

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

  Stream<String> _getDemoResponse(String prompt) async* {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (prompt.toLowerCase().contains('care') || 
        prompt.toLowerCase().contains('maintain')) {
      yield 'To properly care for this product:\n\n'
          '1. Clean regularly with a soft, dry cloth\n'
          '2. Avoid exposure to extreme temperatures\n'
          '3. Store in a cool, dry place when not in use\n'
          '4. Check manufacturer guidelines for specific care instructions\n\n'
          'This will help extend the product lifespan and maintain optimal performance.';
    } else if (prompt.toLowerCase().contains('worth buying') || 
               prompt.toLowerCase().contains('pros and cons')) {
      yield 'Based on reviews and specifications:\n\n'
          'Pros:\n'
          '✓ High quality materials and construction\n'
          '✓ Good value for the price point\n'
          '✓ Reliable brand with strong warranty support\n'
          '✓ Positive user reviews (4.5/5 average)\n\n'
          'Cons:\n'
          '✗ May be expensive for some budgets\n'
          '✗ Limited color options\n\n'
          'Overall: Recommended for users prioritizing quality and durability.';
    } else if (prompt.toLowerCase().contains('alternative')) {
      yield 'Similar alternatives to consider:\n\n'
          '1. Brand X Model Y - More affordable option with similar features\n'
          '2. Brand Z Premium - Higher-end option with additional features\n'
          '3. Generic Brand - Budget-friendly alternative\n\n'
          'Each has its own trade-offs in terms of price, features, and quality.';
    } else if (prompt.toLowerCase().contains('warranty')) {
      yield 'Warranty Information:\n\n'
          'Standard warranty: 2 years from date of purchase\n'
          'Coverage includes: Manufacturing defects and material issues\n'
          'Not covered: Normal wear and tear, accidental damage\n\n'
          'Contact customer service with your proof of purchase to file a warranty claim.';
    } else {
      yield 'This is a demo response simulating AI assistance.\n\n'
          'In production, I would provide detailed, context-aware answers about:\n'
          '• Product specifications and features\n'
          '• Care and maintenance tips\n'
          '• Buying recommendations\n'
          '• Troubleshooting guidance\n'
          '• And much more!\n\n'
          'The AI learns from the product information to give you personalized advice.';
    }
  }

  Stream<String> _askOpenAI(String apiKey, String prompt) async* {
    if (_isDemoMode(apiKey)) {
      yield* _getDemoResponse(prompt);
      return;
    }

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
  }

  Stream<String> _askGemini(String apiKey, String prompt) async* {
    if (_isDemoMode(apiKey)) {
      yield* _getDemoResponse(prompt);
      return;
    }

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
  }

  Stream<String> _askPerplexity(String apiKey, String prompt) async* {
    if (_isDemoMode(apiKey)) {
      yield* _getDemoResponse(prompt);
      return;
    }

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
  }

  Stream<String> _askDeepseek(String apiKey, String prompt) async* {
    if (_isDemoMode(apiKey)) {
      yield* _getDemoResponse(prompt);
      return;
    }

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
  }
}
