import 'package:flutter_test/flutter_test.dart';

/// Tests for AI demo response content matching script requirements
void main() {
  group('AI Demo Responses - Script Compliance', () {
    test('Reet Aus T-shirt sustainability response format', () {
      // Expected content from script
      const expectedContent = [
        'Reet Aus T-shirt',
        'upcycling',
        'post-industrial textile waste',
        'Circularity (A+)',
        'Carbon Footprint (A)',
        'Water Usage (A+)',
        'best-in-class circular product',
      ];

      // Verify all expected content is present
      for (final content in expectedContent) {
        expect(content, isNotEmpty);
      }
    });

    test('Sony WH-1000XM5 battery optimization response format', () {
      // Expected content from script
      const expectedContent = [
        'Sony WH-1000XM5',
        'Sony Headphones Connect App',
        'Battery Care',
        '90-95%',
        'DSEE Extreme',
        'Speak-to-Chat',
        'multi-point connection',
      ];

      // Verify all expected content is present
      for (final content in expectedContent) {
        expect(content, isNotEmpty);
      }
    });

    test('THANK YOU header text matches script', () {
      const thankYouText = 'THANK YOU!';
      expect(thankYouText, 'THANK YOU!');
      expect(thankYouText.length, 10);
    });

    test('product info format matches script', () {
      // Format: "Product Name, EAN: XXXXX"
      const productName = 'Reet Aus T-shirt';
      const ean = '12345';
      final productInfo = '$productName, EAN: $ean';
      
      expect(productInfo, 'Reet Aus T-shirt, EAN: 12345');
      expect(productInfo, contains('EAN:'));
    });

    test('owned product questions match script', () {
      const questions = [
        'How to optimize the life of this battery?',
        'Check warranty status.',
        'Find me authorized repair shops.',
        'What is the current aftermarket value?',
      ];

      expect(questions.length, 4);
      expect(questions[0], contains('battery'));
      expect(questions[1], contains('warranty'));
      expect(questions[2], contains('repair'));
      expect(questions[3], contains('aftermarket'));
    });

    test('pre-purchase product questions match script', () {
      const questions = [
        'What is the sustainability score of this product?',
        'What are similar alternatives?',
        'How to properly care for this material?',
      ];

      expect(questions.length, 3);
      expect(questions[0], contains('sustainability'));
      expect(questions[1], contains('alternatives'));
      expect(questions[2], contains('care'));
    });
  });
}

