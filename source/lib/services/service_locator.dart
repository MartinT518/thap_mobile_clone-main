import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:thap/data/network/api/api_client.dart';
import 'package:thap/data/network/api/app_api.dart';
import 'package:thap/data/network/api/my_tings_api.dart';
import 'package:thap/data/network/api/products_api.dart';
import 'package:thap/data/network/api/tags_api.dart';
import 'package:thap/data/network/api/user_api.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/data/repository/tags_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/data_service.dart';
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

final locator = GetIt.instance;

void setupServiceLocator() {
  // Stores
  locator.registerLazySingleton<MyTingsStore>(() => MyTingsStore());
  locator.registerLazySingleton<ScanHistoryStore>(() => ScanHistoryStore());
  locator.registerLazySingleton<ProductPagesStore>(() => ProductPagesStore());
  locator.registerLazySingleton<UserProfileStore>(() => UserProfileStore());
  locator.registerLazySingleton<ProductTagsStore>(() => ProductTagsStore());

  // Services
  locator.registerLazySingleton<ShareService>(() => ShareService());
  locator.registerLazySingleton<OpenerService>(() => OpenerService());
  locator.registerLazySingleton<DataService>(() => DataService());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<ToastService>(() => ToastService());
  locator.registerLazySingleton<PermissionsService>(() => PermissionsService());
  locator.registerLazySingleton<AuthService>(() => AuthService());

  // Apis
  locator.registerSingleton(Dio());
  locator.registerSingleton(ApiClient(
      dio: locator<Dio>(), userProfileStore: locator<UserProfileStore>()));
  locator.registerLazySingleton<MyTingsApi>(
      () => MyTingsApi(locator<ApiClient>()));
  locator.registerLazySingleton<UserApi>(() => UserApi(locator<ApiClient>()));
  locator.registerLazySingleton<AppApi>(() => AppApi(locator<ApiClient>()));
  locator.registerLazySingleton<TagsApi>(() => TagsApi(locator<ApiClient>()));
  locator.registerLazySingleton<ProductsApi>(
      () => ProductsApi(locator<ApiClient>()));

  // Repositories
  locator.registerLazySingleton<MyTingsRepository>(
      () => MyTingsRepository(locator<MyTingsApi>()));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepository(locator<UserApi>()));
  locator.registerLazySingleton<AppRepository>(
      () => AppRepository(locator<AppApi>()));
  locator.registerLazySingleton<TagsRepository>(
      () => TagsRepository(locator<TagsApi>()));
  locator.registerLazySingleton<ProductsRepository>(
      () => ProductsRepository(locator<ProductsApi>()));
}
