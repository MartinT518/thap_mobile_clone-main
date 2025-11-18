import 'package:thap/features/ai_assistant/domain/entities/ai_provider.dart';

/// AI repository interface
abstract class AIRepository {
  /// Ask AI a question with product context
  Stream<String> askQuestion({
    required String question,
    required String productInfo,
    required AIProvider provider,
    required String apiKey,
  });

  /// Validate API key for a provider
  Future<bool> validateApiKey(AIProvider provider, String apiKey);
}

