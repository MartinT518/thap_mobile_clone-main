import 'package:thap/models/auth_method.dart';

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
