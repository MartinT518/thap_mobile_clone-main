import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/products/data/datasources/products_remote_datasource.dart';
import 'package:thap/features/products/data/repositories/products_repository_demo.dart';
import 'package:thap/features/products/data/repositories/products_repository_impl.dart';
import 'package:thap/features/products/domain/repositories/products_repository.dart';
import 'package:thap/shared/providers/dio_provider.dart';

part 'products_repository_provider.g.dart';

/// Products remote data source provider
@riverpod
ProductsRemoteDataSource productsRemoteDataSource(
    ProductsRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return ProductsRemoteDataSource(dio);
}

/// Products repository provider
@riverpod
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  if (Env.isDemoMode) {
    return ProductsRepositoryDemo();
  }
  final remoteDataSource = ref.watch(productsRemoteDataSourceProvider);
  return ProductsRepositoryImpl(remoteDataSource);
}

