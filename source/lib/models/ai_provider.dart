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
