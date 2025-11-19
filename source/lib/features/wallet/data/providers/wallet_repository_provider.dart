import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:thap/features/wallet/data/repositories/wallet_repository_demo.dart';
import 'package:thap/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:thap/shared/providers/dio_provider.dart';
import 'package:thap/shared/providers/storage_providers.dart';

part 'wallet_repository_provider.g.dart';

/// Wallet remote data source provider
@riverpod
WalletRemoteDataSource walletRemoteDataSource(WalletRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return WalletRemoteDataSource(dio);
}

/// Wallet repository provider
@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) async {
  if (Env.isDemoMode) {
    return WalletRepositoryDemo();
  }
  final remoteDataSource = ref.watch(walletRemoteDataSourceProvider);
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return WalletRepositoryImpl(remoteDataSource, prefs);
}

