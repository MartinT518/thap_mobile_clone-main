import 'package:dio/dio.dart';
import 'package:thap/configuration_demo.dart';
import 'package:thap/data/network/api/api_client.dart';
import 'package:thap/data/network/api/app_api.dart';
import 'package:thap/data/network/api/my_tings_api.dart';
import 'package:thap/data/network/api/products_api.dart';
import 'package:thap/data/network/api/tags_api.dart';
import 'package:thap/data/network/api/user_api.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/demo_app_repository.dart';
import 'package:thap/data/repository/demo_my_tings_repository.dart';
import 'package:thap/data/repository/demo_user_repository.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/data/repository/tags_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/services/ai_service.dart';
import 'package:thap/services/ai_settings_service.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/data_service.dart';
import 'package:thap/services/demo_auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/services/permissions_service.dart';
import 'package:thap/services/share_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/stores/user_profile_store.dart';

/// ⚠️ DEPRECATED: Service Locator pattern is deprecated and will be removed in v3.0
/// 
/// Please migrate to Riverpod providers for new code:
/// ```dart
/// // Old way (deprecated):
/// final myService = locator<MyService>();
/// 
/// // New way (recommended):
/// final myService = ref.watch(myServiceProvider);
/// ```
/// 
/// See MIGRATION_GUIDE.md for detailed migration instructions.

/// Simple service locator replacement (temporary stub for migration)
class _ServiceLocator {
  final Map<Type, dynamic> _services = {};
  
  T call<T extends Object>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service $T not registered. Please use Riverpod providers instead.');
    }
    return service as T;
  }
  
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _services[T] = factory();
  }
  
  void registerSingleton<T extends Object>(T instance) {
    _services[T] = instance;
  }
}

@Deprecated('Use Riverpod providers instead. See MIGRATION_GUIDE.md for details.')
final locator = _ServiceLocator();

void setupServiceLocator() {
  // Legacy Stub Stores (backward compatibility only - use Riverpod providers for new code)
  locator.registerLazySingleton<MyTingsStore>(() => MyTingsStore());
  locator.registerLazySingleton<UserProfileStore>(() => UserProfileStore());
  locator.registerLazySingleton<ScanHistoryStore>(() => ScanHistoryStore());
  locator.registerLazySingleton<ProductPagesStore>(() => ProductPagesStore());
  locator.registerLazySingleton<ProductTagsStore>(() => ProductTagsStore());

  // Services
  locator.registerLazySingleton<ShareService>(() => ShareService());
  locator.registerLazySingleton<OpenerService>(() => OpenerService());
  locator.registerLazySingleton<DataService>(() => DataService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<ToastService>(() => ToastService());
  locator.registerLazySingleton<PermissionsService>(() => PermissionsService());
  
  if (kDemoMode) {
    final demoAuth = DemoAuthService();
    locator.registerLazySingleton(() => demoAuth);
    locator.registerLazySingleton<AuthService>(() => demoAuth as dynamic);
  } else {
    locator.registerLazySingleton<AuthService>(() => AuthService());
  }
  
  locator.registerLazySingleton<AISettingsService>(() => AISettingsService());
  locator.registerLazySingleton<AIService>(() => AIService());

  // Apis
  locator.registerSingleton(Dio());
  // NOTE: ApiClient temporarily uses null for userProfileStore since it's commented out
  // The new architecture uses Riverpod's authProvider for user state
  locator.registerSingleton(ApiClient(
      dio: locator<Dio>(), userProfileStore: null));
  locator.registerLazySingleton<MyTingsApi>(
      () => MyTingsApi(locator<ApiClient>()));
  locator.registerLazySingleton<UserApi>(() => UserApi(locator<ApiClient>()));
  locator.registerLazySingleton<AppApi>(() => AppApi(locator<ApiClient>()));
  locator.registerLazySingleton<TagsApi>(() => TagsApi(locator<ApiClient>()));
  locator.registerLazySingleton<ProductsApi>(
      () => ProductsApi(locator<ApiClient>()));

  // Repositories
  locator.registerLazySingleton<TagsRepository>(
      () => TagsRepository(locator<TagsApi>()));
  locator.registerLazySingleton<ProductsRepository>(
      () => ProductsRepository(locator<ProductsApi>()));
  
  if (kDemoMode) {
    locator.registerLazySingleton<MyTingsRepository>(() => DemoMyTingsRepository());
    locator.registerLazySingleton<UserRepository>(() => DemoUserRepository());
    locator.registerLazySingleton<AppRepository>(() => DemoAppRepository());
  } else {
    locator.registerLazySingleton<MyTingsRepository>(
        () => MyTingsRepository(locator<MyTingsApi>()));
    locator.registerLazySingleton<UserRepository>(
        () => UserRepository(locator<UserApi>()));
    locator.registerLazySingleton<AppRepository>(
        () => AppRepository(locator<AppApi>()));
  }
}
