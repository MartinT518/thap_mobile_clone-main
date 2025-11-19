import 'package:thap/data/repository/products_repository.dart';
import 'package:thap/models/product_form.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_page.dart';
import 'package:thap/models/search_product_result.dart';
import 'package:thap/services/service_locator.dart';

class DemoProductsRepository extends ProductsRepository {
  DemoProductsRepository() : super(locator());

  @override
  Future<ProductItem?> getProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Return demo product based on ID
    return _getDemoProduct(productId);
  }

  @override
  Future<ProductItem?> findByQrUrl(Uri qrUrl) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }

  @override
  Future<ProductPagesModel?> pages(String productId, String language) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return ProductPagesModel(
      productId: productId,
      userImages: [],
      pages: [
        ProductPageModel(
          pageId: 'root',
          title: 'Product Passport',
          components: [
            ProductPageComponentModel(
              type: ProductPageComponentType.imageCarusel,
              cdnImages: [],
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.title,
              title: _getProductName(productId),
              subTitle: 'Digital Product Passport',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.buyButton,
              title: 'Ask AI',
            ),
            // Product Identity
            ProductPageComponentModel(
              type: ProductPageComponentType.sectionTitle,
              title: 'Product Identity',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.keyValueTable,
              tableContents: _getProductIdentity(productId),
            ),
            // Sustainability Score
            ProductPageComponentModel(
              type: ProductPageComponentType.sectionTitle,
              title: 'Sustainability Score',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.keyValueTable,
              tableContents: _getSustainabilityScore(productId),
            ),
            // Materials
            ProductPageComponentModel(
              type: ProductPageComponentType.sectionTitle,
              title: 'Materials & Composition',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.keyValueTable,
              tableContents: _getMaterials(productId),
            ),
            // Supply Chain
            ProductPageComponentModel(
              type: ProductPageComponentType.sectionTitle,
              title: 'Supply Chain Transparency',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.keyValueTable,
              tableContents: _getSupplyChain(productId),
            ),
             // End of Life
            ProductPageComponentModel(
              type: ProductPageComponentType.sectionTitle,
              title: 'End of Life',
            ),
            ProductPageComponentModel(
              type: ProductPageComponentType.keyValueTable,
              tableContents: _getEndOfLife(productId),
            ),
          ],
        ),
      ],
    );
  }

  ProductItem _getDemoProduct(String id) {
     switch (id) {
      case '1':
        return ProductItem(
          id: '1',
          barcode: '1234567890123',
          name: 'Mountain Bike',
          brand: 'Trek',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=Mountain+Bike',
          isOwner: true,
        );
      case '2':
        return ProductItem(
          id: '2',
          barcode: '8712581549114',
          name: 'Smart TV 65"',
          brand: 'Philips',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=Philips+Smart+TV',
          isOwner: true,
        );
      case '3':
         return ProductItem(
          id: '3',
          barcode: '0194252707050',
          name: 'MacBook Pro 14"',
          brand: 'Apple',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=MacBook+Pro',
          isOwner: true,
        );
      case '4':
         return ProductItem(
          id: '4',
          barcode: '0195949142710',
          name: 'iPhone 16 Pro',
          brand: 'Apple',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=iPhone+16+Pro',
          isOwner: true,
        );
      case '5':
         return ProductItem(
          id: '5',
          barcode: '5901234567890',
          name: 'Black T-Shirt',
          brand: 'H&M',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=Black+T-Shirt',
          isOwner: true,
        );
      default:
        return ProductItem(
          id: id,
          barcode: id,
          name: 'Demo Product',
          brand: 'Demo Brand',
          imageUrl: 'https://via.placeholder.com/300x300.png?text=Demo+Product',
          isOwner: false,
        );
    }
  }

  String _getProductName(String id) {
    return _getDemoProduct(id).name;
  }

  List<Map<String, String>> _getProductIdentity(String id) {
    final product = _getDemoProduct(id);
    return [
      {'key': 'GTIN/EAN', 'value': product.barcode ?? 'Unknown'},
      {'key': 'Brand', 'value': product.brand},
      {'key': 'Model', 'value': '2024 Edition'},
      {'key': 'Serial Number', 'value': 'SN-${id}987654321'},
      {'key': 'Manufacturing Date', 'value': '2024-01-15'},
    ];
  }

  List<Map<String, String>> _getSustainabilityScore(String id) {
    if (id == '5') { // T-Shirt (Reet Aus equivalent)
       return [
        {'key': 'Overall Score', 'value': 'A+'},
        {'key': 'Circularity', 'value': 'A+ (100% Upcycled)'},
        {'key': 'Carbon Footprint', 'value': 'Low (2.5 kg CO2e)'},
        {'key': 'Water Usage', 'value': 'Minimal (Saved 2000L)'},
      ];
    } else if (id == '3' || id == '4') { // Electronics
      return [
        {'key': 'Overall Score', 'value': 'B'},
        {'key': 'Energy Efficiency', 'value': 'A'},
        {'key': 'Repairability', 'value': '7/10'},
        {'key': 'Recycled Content', 'value': '20% Aluminum'},
      ];
    }
     return [
        {'key': 'Overall Score', 'value': 'B+'},
        {'key': 'Durability', 'value': 'High'},
        {'key': 'Repairability', 'value': 'High'},
        {'key': 'Recycled Content', 'value': 'Unknown'},
      ];
  }

  List<Map<String, String>> _getMaterials(String id) {
    if (id == '5') {
       return [
        {'key': 'Composition', 'value': '100% Cotton (Post-industrial waste)'},
        {'key': 'Origin', 'value': 'Upcycled'},
        {'key': 'Chemicals', 'value': 'REACH Compliant'},
      ];
    }
     return [
        {'key': 'Primary Material', 'value': 'Aluminum'},
        {'key': 'Secondary Material', 'value': 'Plastic (PCR)'},
        {'key': 'Packaging', 'value': '100% Recyclable Fiber'},
      ];
  }

  List<Map<String, String>> _getSupplyChain(String id) {
    if (id == '5') {
       return [
        {'key': 'Country of Origin', 'value': 'Estonia'},
        {'key': 'Factory', 'value': 'Green Factory Ltd.'},
        {'key': 'Labor Standards', 'value': 'Fair Trade Certified'},
      ];
    }
     return [
        {'key': 'Country of Origin', 'value': 'China'},
        {'key': 'Assembly', 'value': 'Foxconn'},
        {'key': 'Conflict Minerals', 'value': 'Conflict-Free Sourced'},
      ];
  }

  List<Map<String, String>> _getEndOfLife(String id) {
     return [
        {'key': 'Recyclability', 'value': '95%'},
        {'key': 'Disposal', 'value': 'E-Waste / Textile Recycling'},
        {'key': 'Take-back Program', 'value': 'Available'},
      ];
  }

  @override
  Future<ProductItem?> scan(String codeData, String codeType) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _getDemoProduct(codeData);
  }

  @override
  Future<List<SearchProductResult>?> search(String keyword) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      SearchProductResult(
        productName: 'Mountain Bike',
        producerName: 'Trek',
        barcode: '1234567890123',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Mountain+Bike',
      ),
      SearchProductResult(
        productName: 'Smart TV 65"',
        producerName: 'Philips',
        barcode: '8712581549114',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Philips+Smart+TV',
      ),
      SearchProductResult(
        productName: 'MacBook Pro 14"',
        producerName: 'Apple',
        barcode: '0194252707050',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=MacBook+Pro',
      ),
      SearchProductResult(
        productName: 'iPhone 16 Pro',
        producerName: 'Apple',
        barcode: '0195949142710',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=iPhone+16+Pro',
      ),
      SearchProductResult(
        productName: 'Black T-Shirt',
        producerName: 'H&M',
        barcode: '5901234567890',
        imageUrl: 'https://via.placeholder.com/300x300.png?text=Black+T-Shirt',
      ),
    ];
  }

  @override
  Future<ProductItem?> findByEan(String ean) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _getDemoProduct(ean);
  }

  @override
  Future<ProductFormModel?> registrationForm(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return null;
  }

  @override
  Future feedback(String productId, String feedback, String? name, String? email) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
