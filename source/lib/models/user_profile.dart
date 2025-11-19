import 'package:thap/features/auth/domain/entities/user.dart'; // AuthMethod

class UserProfileModel {
  final String name;
  final String email;
  final String? photoUrl;
  final AuthMethod authMethod;

  UserProfileModel(
      {required this.name,
      required this.email,
      this.photoUrl,
      required this.authMethod});
}
