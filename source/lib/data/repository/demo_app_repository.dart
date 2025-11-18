import 'package:thap/data/network/api/app_api.dart';
import 'package:thap/data/repository/app_repository.dart';
import 'package:thap/models/app_data.dart';

class DemoAppRepository extends AppRepository {
  DemoAppRepository() : super(null as AppApi);
  @override
  Future<AppDataModel> getData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
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
