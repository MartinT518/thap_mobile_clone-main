import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:thap/features/wallet/data/repositories/wallet_repository_demo.dart';
import 'package:thap/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:thap/shared/providers/dio_provider.dart';
import 'package:thap/shared/providers/storage_providers.dart';

// TODO: Generate with build_runner
// part 'wallet_repository_provider.g.dart';

/// Wallet remote data source provider - stubbed
WalletRemoteDataSource walletRemoteDataSource(dynamic ref) {
  final dio = (ref as dynamic).watch(dioProvider);
  return WalletRemoteDataSource(dio);
}

/// Wallet repository provider - stubbed
Future<WalletRepository> walletRepository(dynamic ref) async {
  if (Env.isDemoMode) {
    return WalletRepositoryDemo();
  }
  final remoteDataSource = walletRemoteDataSource(ref);
  final prefs = await (ref as dynamic).watch(sharedPreferencesProvider.future);
  return WalletRepositoryImpl(remoteDataSource, prefs);
}

