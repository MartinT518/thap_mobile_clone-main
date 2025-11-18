import 'package:flutter_test/flutter_test.dart';
import 'package:thap/services/ai_service.dart';
import 'package:thap/models/ai_provider.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/service_locator.dart' as sl;
import 'package:shared_preferences/shared_preferences.dart';
import 'test_helper.dart';

void main() {
  group('AIService - Demo Response Generation', () {
    late AIService aiService;
    late AISettingsService settingsService;

    setUpAll(() {
      // Initialize service locator for tests
      TestHelper.setupServiceLocatorForTests();
    });

    setUp(() async {
      // Use in-memory SharedPreferences for testing
      SharedPreferences.setMockInitialValues({});
      
      // Get settings service from locator and configure
      settingsService = sl.locator<AISettingsService>();
      await settingsService.setSelectedProvider(AIProvider.openai);
      await settingsService.setApiKey(AIProvider.openai, 'demo');
      
      // Get AI service from locator (it uses settings service internally)
      aiService = sl.locator<AIService>();
    });

    test('demo mode recognizes demo keys', () async {
      expect(await aiService.validateApiKey(AIProvider.openai, 'demo'), isTrue);
      expect(await aiService.validateApiKey(AIProvider.openai, 'test'), isTrue);
      expect(await aiService.validateApiKey(AIProvider.openai, 'demo-key-123'), isTrue);
    });

    test('Reet Aus T-shirt sustainability response contains expected content', () async {
      final stream = await aiService.askQuestion(
        'What is the sustainability score of this product?',
        'Reet Aus T-shirt, EAN: 12345',
      );
      
      final response = await stream.join('');
      
      expect(response, contains('Reet Aus T-shirt'));
      expect(response, contains('upcycling'));
      expect(response, contains('Circularity (A+)'));
      expect(response, contains('Carbon Footprint (A)'));
      expect(response, contains('Water Usage (A+)'));
      expect(response, contains('best-in-class circular product'));
    });

    test('Sony WH-1000XM5 battery optimization response contains expected content', () async {
      final stream = await aiService.askQuestion(
        'How to optimize the life of this battery?',
        'Sony WH-1000XM5 headphones, EAN: 67890',
      );
      
      final response = await stream.join('');
      
      expect(response, contains('Sony WH-1000XM5'));
      expect(response, contains('Sony Headphones Connect App'));
      expect(response, contains('Battery Care'));
      expect(response, contains('90-95%'));
      expect(response, contains('DSEE Extreme'));
      expect(response, contains('Speak-to-Chat'));
    });

    test('generic sustainability response for non-specific products', () async {
      final stream = await aiService.askQuestion(
        'What is the sustainability score of this product?',
        'Generic Product, EAN: 11111',
      );
      
      final response = await stream.join('');
      
      // Should not contain Reet Aus specific content
      expect(response, isNot(contains('Reet Aus')));
      expect(response, contains('Sustainability'));
    });

    test('generic battery optimization for non-specific products', () async {
      final stream = await aiService.askQuestion(
        'How to optimize the life of this battery?',
        'Generic Headphones, EAN: 22222',
      );
      
      final response = await stream.join('');
      
      // Should not contain Sony specific content
      expect(response, isNot(contains('Sony Headphones Connect App')));
      expect(response.toLowerCase(), contains('battery'));
    });

    test('streaming response yields words incrementally', () async {
      final stream = await aiService.askQuestion(
        'Test question',
        'Test Product',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      
      // Should have multiple chunks (word-by-word streaming)
      expect(chunks.length, greaterThan(1));
      // All chunks combined should form a complete response
      final fullResponse = chunks.join('');
      expect(fullResponse, isNotEmpty);
    });
  });
}

