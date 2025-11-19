import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';

class DemoMyTingsRepository extends MyTingsRepository {
  DemoMyTingsRepository() : super(locator());

  @override
  Future<List<ProductItem>> list() async {
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
