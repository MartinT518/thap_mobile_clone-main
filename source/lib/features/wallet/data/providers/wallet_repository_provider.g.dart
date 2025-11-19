// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletRemoteDataSourceHash() =>
    r'7a5eb38ae3a7fa3e6b5a75f455e7234bb771ac59';

/// Wallet remote data source provider
///
/// Copied from [walletRemoteDataSource].
@ProviderFor(walletRemoteDataSource)
final walletRemoteDataSourceProvider =
    AutoDisposeProvider<WalletRemoteDataSource>.internal(
      walletRemoteDataSource,
      name: r'walletRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$walletRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRemoteDataSourceRef =
    AutoDisposeProviderRef<WalletRemoteDataSource>;
String _$walletRepositoryHash() => r'9a0dde371e06d9f464431820db2a6f0c1565c3bd';

/// Wallet repository provider
///
/// Copied from [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = AutoDisposeProvider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = AutoDisposeProviderRef<WalletRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
