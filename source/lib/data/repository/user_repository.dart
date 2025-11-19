import 'package:thap/data/network/api/user_api.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/user_data_result.dart';
import 'package:thap/models/user_feed_message_model.dart';

class UserRepository {
  final UserApi _api;

  UserRepository(this._api);

  Future<List<ProductItem>> getScanHistory() async {
    final response = await _api.getScanHistory();

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((ting) => ProductItem.fromJson(ting))
          .toList();
    } else {
      throw Exception('Could not load scan history');
    }
  }

  Future<void> deleteScanHistory(String productId) async {
    final response = await _api.deleteScanHistory(productId);

    if (response.statusCode != 200) {
      throw Exception('Could not load delete scan history');
    }
  }

  Future<bool> deleteAllData() async {
    final response = await _api.deleteAllData();

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw Exception('Failed to delete all user data');
    }
  }

  Future<List<UserFeedMessageModel>?> getUserFeed(String language) async {
    final response = await _api.getUserFeed(language);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((ting) => UserFeedMessageModel.fromJson(ting))
          .toList();
    } else {
      return null;
    }
  }

  Future<void> updateProfileData({
    String? countryCode,
    String? languageCode,
    bool? allowFeedback,
    bool? consentMarketing,
  }) async {
    final response = await _api.updateProfileData(
      countryCode,
      languageCode,
      allowFeedback,
      consentMarketing,
    );

    if (response.statusCode != 200) {
      throw Exception('Could not update user profile data');
    }
  }

  Future<UserDataResult> getProfileData() async {
    final response = await _api.getProfileData();

    if (response.statusCode == 200) {
      return UserDataResult.fromJson(response.data);
    } else {
      throw Exception('Could get user profile data');
    }
  }

  Future<String?> authenticate(String accessToken, String provider) async {
    final response = await _api.authenticate(accessToken, provider);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<bool> isRegistered(String email) async {
    final response = await _api.isRegistered(email);

    return response.statusCode == 200;
  }

  Future<String?> register(
      String email, String name, String language, String country) async {
    final response = await _api.register(email, name, language, country);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
