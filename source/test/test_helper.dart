import 'package:thap/services/service_locator.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/data/repository/tags_repository.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/demo_auth_service.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/services/opener_service.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/stores/my_tings_store.dart';
import 'package:thap/stores/scan_history_store.dart';
import 'package:thap/stores/product_pages_store.dart';
import 'package:thap/stores/product_tags_store.dart';
import 'test_helpers/mock_repositories.dart';

/// Test helper utilities
class TestHelper {
  /// Reset service locator for clean test state
  static void resetServiceLocator() {
    // Service locator is now a simple map-based implementation
    // No reset needed as each test should call setupServiceLocator()
  }

  /// Setup service locator for tests with mock repositories
  static void setupServiceLocatorForTests({
    bool useMockRepositories = true,
    AppRepository? appRepository,
    UserRepository? userRepository,
    ProductsRepository? productsRepository,
    MyTingsRepository? myTingsRepository,
    TagsRepository? tagsRepository,
  }) {
    // Setup basic stores first
    locator.registerLazySingleton<MyTingsStore>(() => MyTingsStore());
    locator.registerLazySingleton<UserProfileStore>(() => UserProfileStore());
    locator.registerLazySingleton<ScanHistoryStore>(() => ScanHistoryStore());
    locator.registerLazySingleton<ProductPagesStore>(() => ProductPagesStore());
    locator.registerLazySingleton<ProductTagsStore>(() => ProductTagsStore());

    // Setup OpenerService FIRST (required by NavigationService)
    // Must be registered before NavigationService to avoid "service not found" errors
    // The service locator calls the factory immediately, so OpenerService will be created here
    locator.registerLazySingleton<OpenerService>(() => OpenerService());

    // Setup NavigationService (needed for many pages and ApiClient interceptors)
    // NavigationService constructor accesses OpenerService, which is now registered above
    // Note: NavigationService also requires ProductPagesStore (already registered)
    locator.registerLazySingleton<NavigationService>(() => NavigationService());

    // Setup ToastService (needed by ApiClient interceptors)
    locator.registerSingleton<ToastService>(ToastService());

    // Setup repositories FIRST (AuthService constructor requires UserRepository)
    // IMPORTANT: Repositories must be registered AND created before AuthService
    // The service locator calls factories immediately, so these are created now
    if (useMockRepositories) {
      // Register all repositories
      locator.registerLazySingleton<AppRepository>(
        () => appRepository ?? MockAppRepository(),
      );
      // UserRepository MUST be registered and created before AuthService
      locator.registerLazySingleton<UserRepository>(
        () => userRepository ?? MockUserRepository(),
      );
      // Explicitly trigger UserRepository creation to ensure it's available
      // This is necessary because AuthService constructor accesses it immediately
      final _ = locator<UserRepository>();
      
      locator.registerLazySingleton<ProductsRepository>(
        () => productsRepository ?? MockProductsRepository(),
      );
      locator.registerLazySingleton<MyTingsRepository>(
        () => myTingsRepository ?? MockMyTingsRepository(),
      );
      locator.registerLazySingleton<TagsRepository>(
        () => tagsRepository ?? MockTagsRepository(),
      );
    } else {
      // Use real setupServiceLocator if not using mocks
      setupServiceLocator();
      return; // Early return since setupServiceLocator handles everything
    }

    // Setup AuthService AFTER UserRepository is registered and created
    // AuthService constructor accesses UserRepository immediately, so it must exist
    locator.registerLazySingleton<AuthService>(() => DemoAuthService());
  }
}

