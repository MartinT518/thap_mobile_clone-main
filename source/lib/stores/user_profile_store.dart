import 'package:mobx/mobx.dart';
import 'package:thap/models/user_profile.dart';

part 'user_profile_store.g.dart';

class UserProfileStore = _UserProfileStore with _$UserProfileStore;

abstract class _UserProfileStore with Store {
  @observable
  UserProfileModel? userProfile;

  @observable
  String? token;

  @action
  void set(UserProfileModel userProfile) {
    this.userProfile = userProfile;
  }

  @action
  void setToken(String token) {
    this.token = token;
  }

  @action
  void remove() {
    userProfile = null;
    token = null;
  }
}
