import 'package:dio/dio.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/data/repository/tags_repository.dart';
import 'package:thap/data/network/api/api_client.dart';
import 'package:thap/data/network/api/app_api.dart';
import 'package:thap/data/network/api/user_api.dart';
import 'package:thap/data/network/api/products_api.dart';
import 'package:thap/data/network/api/my_tings_api.dart';
import 'package:thap/data/network/api/tags_api.dart';
import 'package:thap/models/app_data.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/user_feed_message_model.dart';
import 'package:thap/models/tag_result.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/models/product_form.dart';
import 'package:thap/models/search_product_result.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_note.dart';

/// Mock AppRepository for testing
/// Returns test data immediately without network delays
class MockAppRepository extends AppRepository {
  MockAppRepository() : super(_MockAppApi());

  @override
  Future<AppDataModel> getData() async {
    // Return immediately without delay for faster tests
    return AppDataModel(
      languages: [
        LanguageModel(code: 'en', displayName: 'English'),
        LanguageModel(code: 'et', displayName: 'Estonian'),
        LanguageModel(code: 'sv', displayName: 'Swedish'),
      ],
      countries: [
        CountryModel(code: 'US', displayName: 'United States'),
        CountryModel(code: 'EE', displayName: 'Estonia'),
        CountryModel(code: 'SE', displayName: 'Sweden'),
      ],
    );
  }
}

/// Mock UserRepository for testing
/// Returns test data immediately without network delays
class MockUserRepository extends UserRepository {
  MockUserRepository() : super(_MockUserApi());

  @override
  Future<UserDataResult> getProfileData() async {
    // Return immediately without delay for faster tests
    return UserDataResult(
      languageCode: 'en',
      countryCode: 'US',
      allowFeedback: true,
      consentMarketing: false,
    );
  }

  @override
  Future<void> updateProfileData({
    String? countryCode,
    String? languageCode,
    bool? allowFeedback,
    bool? consentMarketing,
  }) async {
    // Mock implementation - no actual API call
    return;
  }

  @override
  Future<List<ProductItem>> getScanHistory() async {
    return [];
  }

  @override
  Future<void> deleteScanHistory(String productId) async {
    return;
  }

  @override
  Future<bool> deleteAllData() async {
    return true;
  }

  @override
  Future<List<UserFeedMessageModel>?> getUserFeed(String language) async {
    return [];
  }

  @override
  Future<String?> authenticate(String accessToken, String provider) async {
    return 'mock-token';
  }

  @override
  Future<bool> isRegistered(String email) async {
    return false;
  }

  @override
  Future<String?> register(
      String email, String name, String language, String country) async {
    return 'mock-token';
  }
}

/// Mock ProductsRepository for testing
class MockProductsRepository extends ProductsRepository {
  MockProductsRepository() : super(_MockProductsApi());

  @override
  Future<ProductItem?> getProduct(String productId) async {
    return null;
  }

  @override
  Future<ProductItem?> findByQrUrl(Uri qrUrl) async {
    return null;
  }

  @override
  Future<ProductPagesModel?> pages(String productId, String language) async {
    return null;
  }

  @override
  Future<ProductItem?> scan(String codeData, String codeType) async {
    return null;
  }

  @override
  Future<List<SearchProductResult>?> search(String keyword) async {
    return [];
  }

  @override
  Future<ProductItem?> findByEan(String ean) async {
    return null;
  }

  @override
  Future<ProductFormModel?> registrationForm(String productId) async {
    return null;
  }

  @override
  Future feedback(String productId, String feedback, String? name, String? email) async {
    return;
  }
}

/// Mock MyTingsRepository for testing
class MockMyTingsRepository extends MyTingsRepository {
  MockMyTingsRepository() : super(_MockMyTingsApi());

  @override
  Future<List<ProductItem>> list() async {
    return [];
  }

  @override
  Future<String?> add(String productId) async {
    return null;
  }

  @override
  Future<bool> delete(String productInstanceId) async {
    return true;
  }

  @override
  Future<String?> addReceipt(String productInstanceId, String filePath, String fileName) async {
    return null;
  }

  @override
  Future<CdnImage?> addProductImage(
    String productInstanceId,
    String filePath,
    String fileName,
  ) async {
    return null;
  }

  @override
  Future<void> removeProductImage(String productInstanceId, CdnImage image) async {
    return;
  }

  @override
  Future<void> deleteReceipt(String productInstanceId) async {
    return;
  }

  @override
  Future<void> setNickname(String productInstanceId, String? title) async {
    return;
  }

  @override
  Future<ProductNoteModel?> getNote(String productInstanceId) async {
    return null;
  }

  @override
  Future<void> saveNote(String productInstanceId, String? content) async {
    return;
  }

  @override
  Future<String?> addNoteAttachment(
    String productInstanceId,
    String filePath,
    String fileName,
  ) async {
    return null;
  }

  @override
  Future<void> removeNoteAttachment(String productInstanceId, String attachmentUrl) async {
    return;
  }

  @override
  Future<List<CdnImage>> getImages(String productInstanceId) async {
    return [];
  }

  @override
  Future<void> saveExternalData(String productInstanceId, String? title, String? imageUrl) async {
    return;
  }

  @override
  Future<void> addTag(String productInstanceId, String tagId) async {
    return;
  }

  @override
  Future<void> deleteTag(String productInstanceId, String tagId) async {
    return;
  }

  @override
  Future<void> register(String productInstanceId, dynamic data) async {
    return;
  }

  @override
  Future<void> setIsOwner(String productInstanceId, bool isOwner) async {
    return;
  }

  @override
  Future<List<ProductItem>> sharedList() async {
    return [];
  }
}

/// Mock TagsRepository for testing
class MockTagsRepository extends TagsRepository {
  MockTagsRepository() : super(_MockTagsApi());

  @override
  Future<List<TagResult>> getTags() async {
    return [];
  }

  @override
  Future<String> add(String name) async {
    return 'mock-tag-id';
  }

  @override
  Future<void> rename(String tagId, String name) async {
    return;
  }

  @override
  Future<void> reorder(List<String> tagIds) async {
    return;
  }

  @override
  Future<void> delete(String tagId) async {
    return;
  }
}

// Internal mock API classes to satisfy constructor requirements
// These are never actually used since we override all repository methods
// We use a simple approach: create minimal API instances that won't be called

// Lazy creation of ApiClient to avoid issues with service locator not being initialized
// This is created when repositories are instantiated, after services are registered
ApiClient _createMockApiClient() {
  try {
    // Create a simple Dio instance
    final dio = Dio();
    dio.options.baseUrl = 'http://localhost'; // Dummy URL, never used
    // ApiClient will set up interceptors that reference services, but those
    // services should already be registered by the time this is called
    return ApiClient(dio: dio, userProfileStore: null);
  } catch (e) {
    // If ApiClient creation fails, create a minimal mock
    // This should not happen if services are properly registered
    throw Exception('Failed to create mock ApiClient. Ensure services are registered first: $e');
  }
}

class _MockAppApi extends AppApi {
  _MockAppApi() : super(_createMockApiClient());
}

class _MockUserApi extends UserApi {
  _MockUserApi() : super(_createMockApiClient());
}

class _MockProductsApi extends ProductsApi {
  _MockProductsApi() : super(_createMockApiClient());
}

class _MockMyTingsApi extends MyTingsApi {
  _MockMyTingsApi() : super(_createMockApiClient());
}

class _MockTagsApi extends TagsApi {
  _MockTagsApi() : super(_createMockApiClient());
}

