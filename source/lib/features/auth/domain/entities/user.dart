/// User entity (domain layer)
class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final String? token;
  final AuthMethod authMethod;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    this.token,
    required this.authMethod,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    String? token,
    AuthMethod? authMethod,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
      authMethod: authMethod ?? this.authMethod,
    );
  }
}

/// Authentication method enum
enum AuthMethod {
  google,
  facebook,
}

