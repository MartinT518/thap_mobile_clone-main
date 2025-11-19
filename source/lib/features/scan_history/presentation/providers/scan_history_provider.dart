import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/scan_history/domain/entities/scan_history_item.dart';
import 'package:thap/features/scan_history/domain/repositories/scan_history_repository.dart';
import 'package:thap/features/scan_history/data/repositories/scan_history_repository_impl.dart';
import 'package:thap/features/scan_history/data/datasources/scan_history_remote_datasource.dart';
import 'package:thap/shared/providers/dio_provider.dart';
import 'package:thap/shared/providers/storage_providers.dart';

/// Provider for scan history repository
final scanHistoryRepositoryProvider = FutureProvider<ScanHistoryRepository>((ref) async {
  final dio = ref.watch(dioProvider);
  final datasource = ScanHistoryRemoteDataSource(dio);
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return ScanHistoryRepositoryImpl(datasource, prefs);
});

/// Provider for scan history state - returns AsyncValue wrapped list
final scanHistoryProvider = FutureProvider<List<ScanHistoryItem>>((ref) async {
  final repository = await ref.watch(scanHistoryRepositoryProvider.future);
  return await repository.getScanHistory();
});
