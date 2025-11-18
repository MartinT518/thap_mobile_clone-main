import 'package:thap/data/network/api/app_api.dart';
import 'package:thap/models/app_data.dart';

class AppRepository {
  final AppApi _api;

  AppRepository(this._api);

  Future<AppDataModel> getData() async {
    final response = await _api.getData();

    if (response.statusCode == 200) {
      return AppDataModel.fromJson(response.data);
    } else {
      throw Exception('Could not load app data');
    }
  }
}
