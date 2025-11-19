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
    String productInfo, {
    String? userCountry,
  }) async {
    final provider = await _settingsService.getSelectedProvider();
    final apiKey = provider != null
        ? await _settingsService.getApiKey(provider)
        : null;

    if (provider == null || apiKey == null) {
      throw Exception('AI provider not configured');
    }

    // Enhanced context: Add current date and user location for better AI responses
    final currentDate = DateTime.now().toIso8601String().split('T')[0];
    final contextInfo = StringBuffer();
    contextInfo.writeln('Product: $productInfo');
    contextInfo.writeln('Current Date: $currentDate');
    if (userCountry != null && userCountry.isNotEmpty) {
      contextInfo.writeln('User Location: $userCountry');
    }

    final fullPrompt = '$question\n\n$contextInfo';

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
    // Simulate streaming with 50ms delay per word (as per script)
    final response = _generateDemoResponse(prompt);
    final words = response.split(' ');
    
    for (var i = 0; i < words.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (i == 0) {
        yield words[i];
      } else {
        yield ' ${words[i]}';
      }
    }
  }

  String _generateDemoResponse(String prompt) {
    final lowerPrompt = prompt.toLowerCase();
    
    // Battery optimization (owned product) - Matching script example
    if (lowerPrompt.contains('battery') || lowerPrompt.contains('optimize')) {
      // Check if product name contains "Sony WH-1000XM5" or "headphones" for specific example
      if (prompt.contains('Sony WH-1000XM5') || prompt.contains('WH-1000XM5') || 
          (lowerPrompt.contains('sony') && lowerPrompt.contains('headphone'))) {
        return 'Here are the best practices to optimize the battery life for your Sony WH-1000XM5 headphones:\n\n'
            'Use the Sony Headphones Connect App: The most important step. Activate the "Battery Care" feature in the app. This limits the maximum charge to 90-95%, which significantly extends the battery\'s long-term health.\n\n'
            'Avoid Extreme Heat: Do not leave your headphones in a hot car or in direct sunlight, as high heat permanently degrades the battery.\n\n'
            'Disable Unused Features: When not needed, turn off features like DSEE Extreme, Speak-to-Chat, and the multi-point connection, as they consume extra power.';
      }
      
      // Generic battery optimization response
      return 'To optimize the battery life of this product:\n\n'
          '1. Avoid deep discharges - keep battery between 20-80% when possible\n'
          '2. Use original charger and avoid fast charging when not needed\n'
          '3. Keep device at moderate temperatures (15-25°C)\n'
          '4. Enable power-saving modes when appropriate\n'
          '5. Update firmware regularly for battery optimizations\n\n'
          'Following these practices can extend battery lifespan by 20-30%.';
    }
    
    // Sustainability score (pre-purchase) - Matching script example
    if (lowerPrompt.contains('sustainability') || lowerPrompt.contains('eco')) {
      // Check if product name contains "Reet Aus" or "T-shirt" for specific example
      if (prompt.contains('Reet Aus') || prompt.contains('T-shirt') || 
          lowerPrompt.contains('reet') || lowerPrompt.contains('t-shirt')) {
        return 'Based on the product info for the Reet Aus T-shirt, here is its sustainability analysis:\n\n'
            'This product is a prime example of upcycling. It is manufactured from post-industrial textile waste, meaning it avoids the carbon-intensive and water-heavy processes of growing virgin cotton and dyeing new fabric.\n\n'
            'While there is no single universal "score," its key metrics are:\n'
            'Circularity (A+): Made entirely from leftover materials.\n'
            'Carbon Footprint (A): Reduces CO2 emissions by an average of 70-80%.\n'
            'Water Usage (A+): Saves thousands of liters of water per garment.\n\n'
            'Summary: This T-shirt is a best-in-class circular product, drastically reducing waste and environmental impact.';
      }
      
      // Generic sustainability response
      return 'Sustainability Score Analysis:\n\n'
          'This product\'s sustainability factors:\n\n'
          'Environmental Impact:\n'
          '• Material sourcing and production methods\n'
          '• Energy efficiency during use\n'
          '• Packaging and shipping footprint\n'
          '• End-of-life recyclability\n\n'
          'Social Responsibility:\n'
          '• Fair labor practices\n'
          '• Supply chain transparency\n'
          '• Community impact\n\n'
          'To get a detailed sustainability score, check:\n'
          '• Manufacturer\'s sustainability reports\n'
          '• Third-party certifications (Energy Star, EPEAT, etc.)\n'
          '• Environmental rating websites\n\n'
          'Look for products with certifications and transparent supply chains.';
    }
    
    // Care instructions (pre-purchase)
    if (lowerPrompt.contains('care') || lowerPrompt.contains('material') || 
        lowerPrompt.contains('maintain')) {
      return 'Material Care Instructions:\n\n'
          'Proper care for this product material:\n\n'
          'Cleaning:\n'
          '• Use appropriate cleaning products for the material type\n'
          '• Follow manufacturer\'s cleaning guidelines\n'
          '• Avoid harsh chemicals that may damage the material\n'
          '• Test cleaning products on a small area first\n\n'
          'Storage:\n'
          '• Store in appropriate conditions (temperature, humidity)\n'
          '• Protect from direct sunlight and extreme temperatures\n'
          '• Use proper storage containers or covers\n\n'
          'Maintenance:\n'
          '• Regular inspection for wear and damage\n'
          '• Address issues promptly to prevent further damage\n'
          '• Follow recommended maintenance schedule\n\n'
          'Proper care extends product lifespan and maintains appearance.';
    }
    
    // Alternatives (pre-purchase)
    if (lowerPrompt.contains('alternative') || lowerPrompt.contains('similar')) {
      return 'Similar Product Alternatives:\n\n'
          'When considering alternatives, compare:\n\n'
          '1. Features and specifications\n'
          '2. Price and value proposition\n'
          '3. Brand reputation and reliability\n'
          '4. Customer reviews and ratings\n'
          '5. Warranty and support options\n'
          '6. Sustainability credentials\n\n'
          'Research methods:\n'
          '• Use comparison websites\n'
          '• Read professional reviews\n'
          '• Check user forums and communities\n'
          '• Visit retail stores for hands-on comparison\n\n'
          'Consider your specific needs and priorities when choosing between alternatives.';
    }
    
    // Warranty check (owned product)
    if (lowerPrompt.contains('warranty')) {
      return 'Warranty Status Check:\n\n'
          'Standard warranty: 2 years from purchase date\n'
          'Coverage: Manufacturing defects, material issues, component failures\n'
          'Not covered: Normal wear, accidental damage, unauthorized repairs\n\n'
          'To check your specific warranty status, contact customer service with:\n'
          '• Proof of purchase (receipt)\n'
          '• Product serial number\n'
          '• Date of purchase\n\n'
          'Most manufacturers offer online warranty lookup tools on their website.';
    }
    
    // Default response
    return 'Thank you for your question about this product.\n\n'
        'I can help you with:\n'
        '• Product specifications and features\n'
        '• Care and maintenance guidance\n'
        '• Warranty and support information\n'
        '• Sustainability and environmental impact\n'
        '• Alternative product recommendations\n\n'
        'Please feel free to ask any specific questions about this product.';
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
