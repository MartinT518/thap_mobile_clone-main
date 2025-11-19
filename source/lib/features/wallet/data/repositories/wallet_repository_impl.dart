import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thap/core/config/env.dart';
import 'package:thap/features/products/data/models/product_model.dart';
import 'package:thap/features/products/domain/entities/product.dart';
import 'package:thap/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:thap/features/wallet/domain/entities/wallet_product.dart';
import 'package:thap/features/wallet/domain/repositories/wallet_repository.dart';

/// Wallet repository implementation with cache-first strategy for offline support
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  WalletRepositoryImpl(this._remoteDataSource, this._prefs);

  static const String _cacheKey = 'wallet_products_cache';
  static const String _cacheTimestampKey = 'wallet_products_cache_timestamp';
  static const Duration _cacheMaxAge = Duration(hours: 24);

  /// Get wallet products with cache-first strategy
  /// Returns cached data immediately if available, then fetches fresh data in background
  @override
  Future<List<WalletProduct>> getWalletProducts() async {
    // Try to load from cache first
    final cachedProducts = _loadFromCache();
    
    // Fetch fresh data in background (don't await - return cached immediately)
    _refreshCacheInBackground();
    
    // Return cached data if available, otherwise fetch fresh
    if (cachedProducts.isNotEmpty) {
      return cachedProducts;
    }
    
    // If no cache, fetch fresh data
    return await _fetchAndCache();
  }

  /// Load products from local cache
  List<WalletProduct> _loadFromCache() {
    try {
      final cachedJson = _prefs.getString(_cacheKey);
      if (cachedJson == null) return [];
      
      final timestamp = _prefs.getInt(_cacheTimestampKey);
      if (timestamp == null) return [];
      
      final cacheAge = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(timestamp),
      );
      
      // Return cached data if still fresh
      if (cacheAge < _cacheMaxAge) {
        final List<dynamic> data = jsonDecode(cachedJson);
        return data.map((json) {
          final productModel = ProductModel.fromJson(json);
          final product = productModel.toEntity();
          
          return WalletProduct(
            instanceId: json['instanceId'] ?? '',
            product: product.copyWith(isOwner: true),
            nickname: json['nickname'],
            tags: (json['tags'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                [],
          );
        }).toList();
      }
    } catch (e) {
      // Cache corrupted or invalid, ignore
    }
    return [];
  }

  /// Fetch fresh data and update cache
  Future<List<WalletProduct>> _fetchAndCache() async {
    try {
      final data = await _remoteDataSource.getWalletProducts();
      final products = data.map((json) {
        final productModel = ProductModel.fromJson(json);
        final product = productModel.toEntity();

        return WalletProduct(
          instanceId: json['instanceId'] ?? '',
          product: product.copyWith(isOwner: true),
          nickname: json['nickname'],
          tags: (json['tags'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        );
      }).toList();
      
      // Update cache
      await _saveToCache(data);
      
      return products;
    } catch (e) {
      // If fetch fails, return cached data if available
      final cached = _loadFromCache();
      if (cached.isNotEmpty) {
        return cached;
      }
      rethrow;
    }
  }

  /// Refresh cache in background without blocking
  void _refreshCacheInBackground() {
    _fetchAndCache().catchError((e) {
      // Silently fail - cache will be used
    });
  }

  /// Save products to cache
  Future<void> _saveToCache(List<Map<String, dynamic>> data) async {
    try {
      await _prefs.setString(_cacheKey, jsonEncode(data));
      await _prefs.setInt(_cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Cache save failed, ignore
    }
  }

  @override
  Future<String> addProductToWallet(String productId) async {
    return await _remoteDataSource.addProductToWallet(productId);
  }

  @override
  Future<void> removeProductFromWallet(String instanceId) async {
    await _remoteDataSource.removeProductFromWallet(instanceId);
  }

  @override
  Future<void> updateNickname(String instanceId, String? nickname) async {
    await _remoteDataSource.updateNickname(instanceId, nickname);
  }

  @override
  Future<void> addTag(String instanceId, String tagId) async {
    await _remoteDataSource.addTag(instanceId, tagId);
  }

  @override
  Future<void> removeTag(String instanceId, String tagId) async {
    await _remoteDataSource.removeTag(instanceId, tagId);
  }
}

