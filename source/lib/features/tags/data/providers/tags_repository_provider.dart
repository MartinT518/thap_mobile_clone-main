import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/tags/data/datasources/tags_remote_datasource.dart';
import 'package:thap/features/tags/data/repositories/tags_repository_demo.dart';
import 'package:thap/features/tags/data/repositories/tags_repository_impl.dart';
import 'package:thap/features/tags/domain/repositories/tags_repository.dart';
import 'package:thap/shared/providers/dio_provider.dart';

/// Provider for TagsRemoteDataSource
final tagsRemoteDataSourceProvider = Provider<TagsRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return TagsRemoteDataSource(dio);
});

/// Provider for TagsRepository
/// Selects between demo and real implementation based on Env.isDemoMode
final tagsRepositoryProvider = Provider<TagsRepository>((ref) {
  if (Env.isDemoMode) {
    return TagsRepositoryDemo();
  } else {
    final remoteDataSource = ref.watch(tagsRemoteDataSourceProvider);
    return TagsRepositoryImpl(remoteDataSource);
  }
});

