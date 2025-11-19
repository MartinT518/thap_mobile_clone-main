import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/models/user_feed_message_model.dart';
import 'package:thap/services/service_locator.dart';

class DemoUserRepository extends UserRepository {
  DemoUserRepository() : super(locator());
  @override
  Future<List<ProductItem>> getScanHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      ProductItem(
        id: '1',
        barcode: '4743047003706',
        name: 'Reet Aus T-shirt',
        brand: 'Reet Aus',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Reet+Aus+T-shirt',
        isOwner: false,
      ),
    ];
  }

  @override
  Future<List<ProductItem>> getProductsList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      ProductItem(
        id: '1',
        barcode: '1234567890123',
        name: 'Mountain Bike',
        brand: 'Trek',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Mountain+Bike',
        isOwner: true,
      ),
      ProductItem(
        id: '2',
        barcode: '8712581549114',
        name: 'Smart TV 65"',
        brand: 'Philips',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Philips+Smart+TV',
        isOwner: true,
      ),
      ProductItem(
        id: '3',
        barcode: '0194252707050',
        name: 'MacBook Pro 14"',
        brand: 'Apple',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=MacBook+Pro',
        isOwner: true,
      ),
      ProductItem(
        id: '4',
        barcode: '0195949142710',
        name: 'iPhone 16 Pro',
        brand: 'Apple',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=iPhone+16+Pro',
        isOwner: true,
      ),
      ProductItem(
        id: '5',
        barcode: '5901234567890',
        name: 'Black T-Shirt',
        brand: 'H&M',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Black+T-Shirt',
        isOwner: true,
      ),
    ];
  }

  @override
  Future<void> deleteScanHistory(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<bool> deleteAllData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }

  @override
  Future<List<UserFeedMessageModel>?> getUserFeed(String language) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  @override
  Future<void> updateProfileData({
    String? countryCode,
    String? languageCode,
    bool? allowFeedback,
    bool? consentMarketing,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<UserDataResult> getProfileData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return UserDataResult(
      languageCode: 'en',
      countryCode: 'US',
    );
  }

  @override
  Future<String?> authenticate(String accessToken, String provider) async {
    return 'demo-token-123';
  }

  @override
  Future<String?> register(String email, String name, String language, String country) async {
    return 'demo-token-123';
  }
}
