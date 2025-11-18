import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/ai_assistant/data/repositories/ai_repository_impl.dart';
import 'package:thap/features/ai_assistant/domain/entities/ai_provider.dart';
import 'package:dio/dio.dart';

void main() {
  group('AIRepositoryImpl - Demo Response Generation', () {
    late AIRepositoryImpl repository;
    late Dio dio;

    setUp(() {
      dio = Dio();
      repository = AIRepositoryImpl(dio);
    });

    tearDown(() {
      // Clean up if needed
    });

    test('Reet Aus T-shirt sustainability response matches script', () async {
      final stream = repository.askQuestion(
        question: 'What is the sustainability score of this product?',
        productInfo: 'Reet Aus T-shirt, EAN: 12345',
        provider: AIProvider.openai,
        apiKey: 'demo',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      final response = chunks.join('');
      
      expect(response, contains('Reet Aus T-shirt'));
      expect(response, contains('upcycling'));
      expect(response, contains('post-industrial textile waste'));
      expect(response, contains('Circularity (A+)'));
      expect(response, contains('Carbon Footprint (A)'));
      expect(response, contains('Water Usage (A+)'));
      expect(response, contains('best-in-class circular product'));
    });

    test('Sony WH-1000XM5 battery optimization response matches script', () async {
      final stream = repository.askQuestion(
        question: 'How to optimize the life of this battery?',
        productInfo: 'Sony WH-1000XM5 headphones, EAN: 67890',
        provider: AIProvider.openai,
        apiKey: 'demo',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      final response = chunks.join('');
      
      expect(response, contains('Sony WH-1000XM5'));
      expect(response, contains('Sony Headphones Connect App'));
      expect(response, contains('Battery Care'));
      expect(response, contains('90-95%'));
      expect(response.toLowerCase(), contains('extreme heat'));
      expect(response, contains('DSEE Extreme'));
      expect(response, contains('Speak-to-Chat'));
      expect(response, contains('multi-point connection'));
    });

    test('demo mode validation accepts demo keys', () async {
      expect(
        await repository.validateApiKey(AIProvider.openai, 'demo'),
        isTrue,
      );
      expect(
        await repository.validateApiKey(AIProvider.openai, 'test'),
        isTrue,
      );
      expect(
        await repository.validateApiKey(AIProvider.openai, 'demo-key-123'),
        isTrue,
      );
    });

    test('streaming response yields incrementally', () async {
      final stream = repository.askQuestion(
        question: 'Test question',
        productInfo: 'Test Product',
        provider: AIProvider.openai,
        apiKey: 'demo',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      
      expect(chunks.length, greaterThan(1));
      final fullResponse = chunks.join('');
      expect(fullResponse, isNotEmpty);
    });

    test('warranty question returns warranty information', () async {
      final stream = repository.askQuestion(
        question: 'Check warranty status.',
        productInfo: 'Test Product',
        provider: AIProvider.openai,
        apiKey: 'demo',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      final response = chunks.join('');
      
      expect(response.toLowerCase(), contains('warranty'));
      expect(response, contains('2 years'));
    });

    test('care instructions question returns care information', () async {
      final stream = repository.askQuestion(
        question: 'How to properly care for this material?',
        productInfo: 'Test Product',
        provider: AIProvider.openai,
        apiKey: 'demo',
      );
      
      final chunks = <String>[];
      await for (final chunk in stream) {
        chunks.add(chunk);
      }
      final response = chunks.join('');
      
      expect(response.toLowerCase(), contains('care'));
      expect(response.toLowerCase(), contains('cleaning'));
    });
  });
}

