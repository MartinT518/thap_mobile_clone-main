/// AI Provider enum
enum AIProvider {
  openai,
  gemini,
  perplexity,
  deepseek;

  String get displayName {
    switch (this) {
      case AIProvider.openai:
        return 'OpenAI';
      case AIProvider.gemini:
        return 'Gemini';
      case AIProvider.perplexity:
        return 'Perplexity';
      case AIProvider.deepseek:
        return 'Deepseek';
    }
  }
}

/// Chat message entity
class ChatMessage {
  final String id;
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });
}

