import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/settings/domain/entities/settings.dart';

void main() {
  group('Settings Entity', () {
    test('Settings entity creation with all fields', () {
      final settings = Settings(
        language: 'en',
        country: 'US',
        marketingConsent: true,
        analyticsConsent: false,
      );
      expect(settings.language, 'en');
      expect(settings.country, 'US');
      expect(settings.marketingConsent, isTrue);
      expect(settings.analyticsConsent, isFalse);
    });

    test('Settings copyWith creates new instance', () {
      final original = Settings(
        language: 'en',
        country: 'US',
        marketingConsent: true,
        analyticsConsent: false,
      );
      final updated = original.copyWith(language: 'et');
      expect(updated.language, 'et');
      expect(updated.country, 'US');
      expect(updated.marketingConsent, isTrue);
    });
  });
}

