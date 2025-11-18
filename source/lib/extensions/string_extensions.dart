bool _isBlank(String? s) => s == null || s.trim().isEmpty;
bool _isNotBlank(String? s) => s != null && s.trim().isNotEmpty;

extension StringNullableExtensions on String? {
  bool get isNotBlank => _isNotBlank(this);
  bool get isBlank => _isBlank(this);
}

extension StringExtensions on String {
  bool get isNotBlank => _isNotBlank(this);
  bool get isBlank => _isBlank(this);
}
