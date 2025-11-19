// Legacy stub - migrating to Riverpod
import 'package:flutter/material.dart';
import 'package:thap/data/repository/my_tings_repository.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/services/service_locator.dart';

class MyTingsStore extends ChangeNotifier {
  List<ProductItem> _myTings = [];
  bool _isLoading = false;
  String _filterTagId = '';
  bool _displayGrid = false;

  List<ProductItem> get myTings => _myTings;
  List<ProductItem> get myTingsFiltered => _myTings; // Implement filter if needed
  List<ProductItem> get sharedTingsFiltered => [];
  bool get hasAny => _myTings.isNotEmpty;
  bool get isLoading => _isLoading;
  bool get displayGrid => _displayGrid;
  String get filterTagId => _filterTagId;
  
  ProductItem? getTing(String productId) {
    try {
      return _myTings.firstWhere((t) => t.id == productId);
    } catch (e) {
      return null;
    }
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final repo = locator<MyTingsRepository>();
      _myTings = await repo.list();
    } catch (e) {
      print('Error loading My Tings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<void> remove(ProductItem product) async {}
  
  void setFilterTagId(String tagId) {
    _filterTagId = tagId;
    notifyListeners();
  }
  
  void setFilterTag(String? tagId) {
    _filterTagId = tagId ?? '';
    notifyListeners();
  }
  
  void toggleDisplayGrid() {
    _displayGrid = !_displayGrid;
    notifyListeners();
  }
  
  Future<void> setDisplayMode({bool? displayGrid}) async {
    if (displayGrid != null) {
      _displayGrid = displayGrid;
      notifyListeners();
    }
  }
  
  Future<void> update(dynamic ting) async {}
  Future<dynamic> add(dynamic ting) async => ting;
}
