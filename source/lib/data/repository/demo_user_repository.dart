import 'package:thap/data/network/api/user_api.dart';
import 'package:thap/data/repository/user_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/models/user_feed_message_model.dart';

class DemoUserRepository extends UserRepository {
  DemoUserRepository() : super(null as UserApi);
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
        id: '2',
        barcode: '4548736110281',
        name: 'Sony WH-1000XM5 Headphones',
        brand: 'Sony',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Sony+Headphones',
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
  Future<void> updateProfileData({String? countryCode, String? languageCode}) async {
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
