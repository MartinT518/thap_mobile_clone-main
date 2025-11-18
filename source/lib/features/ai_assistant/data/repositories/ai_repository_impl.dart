import 'package:dio/dio.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/ai_assistant/domain/entities/ai_provider.dart';
import 'package:thap/features/ai_assistant/domain/repositories/ai_repository.dart';

/// AI repository implementation
class AIRepositoryImpl implements AIRepository {
  final Dio _dio;

  AIRepositoryImpl(this._dio);

  static const String _demoApiKey = 'demo-key-123';

  bool _isDemoMode(String apiKey) {
    return apiKey == _demoApiKey ||
        apiKey.toLowerCase() == 'demo' ||
        apiKey.toLowerCase() == 'test';
  }

  @override
  Stream<String> askQuestion({
    required String question,
    required String productInfo,
    required AIProvider provider,
    required String apiKey,
  }) async* {
    if (_isDemoMode(apiKey) || Env.isDemoMode) {
      // Pass full prompt including product info for product-specific responses
      final fullPrompt = '$question\n\nProduct: $productInfo';
      yield* _getDemoResponse(fullPrompt);
      return;
    }

    final fullPrompt = '$question\n\nProduct: $productInfo';

    switch (provider) {
      case AIProvider.openai:
        yield* _askOpenAI(apiKey, fullPrompt);
        break;
      case AIProvider.gemini:
        yield* _askGemini(apiKey, fullPrompt);
        break;
      case AIProvider.perplexity:
        yield* _askPerplexity(apiKey, fullPrompt);
        break;
      case AIProvider.deepseek:
        yield* _askDeepseek(apiKey, fullPrompt);
        break;
    }
  }

  @override
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
        case AIProvider.deepseek:
          return apiKey.isNotEmpty;
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
          lowerPrompt.contains('sony') && lowerPrompt.contains('headphone')) {
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
    
    // Repair shops (owned product)
    if (lowerPrompt.contains('repair') || lowerPrompt.contains('shop')) {
      return 'Authorized Repair Shops:\n\n'
          'To find authorized repair centers for this product:\n\n'
          '1. Visit the manufacturer\'s official website\n'
          '2. Use their "Find a Service Center" tool\n'
          '3. Enter your location or postal code\n'
          '4. Filter by service type (warranty, out-of-warranty)\n\n'
          'Authorized centers ensure:\n'
          '• Genuine replacement parts\n'
          '• Trained technicians\n'
          '• Warranty preservation\n\n'
          'You can also contact customer support for recommendations in your area.';
    }
    
    // Aftermarket value (owned product)
    if (lowerPrompt.contains('aftermarket') || lowerPrompt.contains('value') || lowerPrompt.contains('resale')) {
      return 'Current Aftermarket Value:\n\n'
          'Factors affecting resale value:\n'
          '• Product condition (excellent, good, fair)\n'
          '• Age and usage\n'
          '• Original packaging and accessories\n'
          '• Market demand and availability\n'
          '• Brand reputation and reliability\n\n'
          'To get an accurate estimate:\n'
          '1. Check online marketplaces (eBay, Facebook Marketplace)\n'
          '2. Use trade-in calculators on manufacturer websites\n'
          '3. Consult with local electronics stores\n'
          '4. Consider refurbished product prices as reference\n\n'
          'Well-maintained products typically retain 40-60% of original value after 2 years.';
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
    
    // Care instructions (pre-purchase)
    if (lowerPrompt.contains('care') || lowerPrompt.contains('material')) {
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
    // Implementation for OpenAI streaming
    yield 'OpenAI response would stream here...';
  }

  Stream<String> _askGemini(String apiKey, String prompt) async* {
    // Implementation for Gemini streaming
    yield 'Gemini response would stream here...';
  }

  Stream<String> _askPerplexity(String apiKey, String prompt) async* {
    // Implementation for Perplexity streaming
    yield 'Perplexity response would stream here...';
  }

  Stream<String> _askDeepseek(String apiKey, String prompt) async* {
    // Implementation for Deepseek streaming
    yield 'Deepseek response would stream here...';
  }
}

extension AIProviderExtension on AIProvider {
  String get apiBaseUrl {
    switch (this) {
      case AIProvider.openai:
        return 'https://api.openai.com/v1';
      case AIProvider.gemini:
        return 'https://generativelanguage.googleapis.com/v1beta';
      case AIProvider.perplexity:
        return 'https://api.perplexity.ai';
      case AIProvider.deepseek:
        return 'https://api.deepseek.com/v1';
    }
  }
}

