import 'package:thap/data/network/api/my_tings_api.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/product_item.dart';

class DemoMyTingsRepository extends MyTingsRepository {
  DemoMyTingsRepository() : super(null as MyTingsApi);

  @override
  Future<List<ProductItem>> list() async {
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
  Future<List<ProductItem>> sharedList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  @override
  Future<String?> add(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 'demo-instance-id';
  }

  @override
  Future<bool> delete(String productInstanceId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}
