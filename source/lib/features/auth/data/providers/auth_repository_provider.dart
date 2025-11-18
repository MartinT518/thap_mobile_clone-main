import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:thap/features/auth/data/repositories/auth_repository_demo.dart';
import 'package:thap/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thap/features/auth/domain/repositories/auth_repository.dart' as domain;
import 'package:thap/shared/providers/dio_provider.dart';
import 'package:thap/shared/providers/storage_providers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Google Sign-In provider
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
});

/// Auth remote data source provider
final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteDataSource(dio);
});

/// Auth repository provider (switches between demo and real based on env)
final authRepositoryProvider = Provider<domain.AuthRepository>((ref) {
  if (Env.isDemoMode) {
    return AuthRepositoryDemo();
  } else {
    final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
    final googleSignIn = ref.watch(googleSignInProvider);
    final secureStorage = ref.watch(secureStorageProvider);
    
    return AuthRepositoryImpl(
      remoteDataSource,
      googleSignIn,
      secureStorage,
    );
  }
});

