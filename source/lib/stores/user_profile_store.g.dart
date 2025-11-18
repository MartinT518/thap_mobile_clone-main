// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileStore on _UserProfileStore, Store {
  late final _$userProfileAtom = Atom(
    name: '_UserProfileStore.userProfile',
    context: context,
  );

  @override
  UserProfileModel? get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(UserProfileModel? value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  late final _$tokenAtom = Atom(
    name: '_UserProfileStore.token',
    context: context,
  );

  @override
  String? get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String? value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$_UserProfileStoreActionController = ActionController(
    name: '_UserProfileStore',
    context: context,
  );

  @override
  void set(UserProfileModel userProfile) {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction(
      name: '_UserProfileStore.set',
    );
    try {
      return super.set(userProfile);
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToken(String token) {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction(
      name: '_UserProfileStore.setToken',
    );
    try {
      return super.setToken(token);
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove() {
    final _$actionInfo = _$_UserProfileStoreActionController.startAction(
      name: '_UserProfileStore.remove',
    );
    try {
      return super.remove();
    } finally {
      _$_UserProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
token: ${token}
    ''';
  }
}
