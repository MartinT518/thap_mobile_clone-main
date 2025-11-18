import 'package:logger/logger.dart';
import 'package:thap/data/network/api/my_tings_api.dart';
import 'package:thap/models/cdn_image.dart';
import 'package:thap/models/product_item.dart';
import 'package:thap/models/product_note.dart';

class MyTingsRepository {
  final MyTingsApi _api;

  MyTingsRepository(this._api);

  Future<List<ProductItem>> list() async {
    final response = await _api.list();

    if (response.statusCode == 200) {
      return (response.data as List).map((ting) => ProductItem.fromJson(ting)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to get my tings');
    }
  }

  Future<String?> add(String productId) async {
    final response = await _api.add(productId);

    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to add a ting');
    }
  }

  Future<bool> delete(String productInstanceId) async {
    final response = await _api.delete(productInstanceId);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      throw Exception('Failed to delete my ting');
    }
  }

  Future<String?> addReceipt(String productInstanceId, String filePath, String fileName) async {
    final response = await _api.addReceipt(productInstanceId, filePath, fileName);

    if (response.statusCode != 200) {
      Logger().e('Could not add receipt');
      return null;
    } else {
      return response.data;
    }
  }

  Future<CdnImage?> addProductImage(
    String productInstanceId,
    String filePath,
    String fileName,
  ) async {
    final response = await _api.addProductImage(productInstanceId, filePath, fileName);

    if (response.statusCode != 200) {
      Logger().e('Could not add product image');
      return null;
    } else {
      return CdnImage.fromJson(response.data);
    }
  }

  Future<void> removeProductImage(String productInstanceId, CdnImage image) async {
    final response = await _api.removeProductImage(productInstanceId, image);

    if (response.statusCode != 200) {
      Logger().e('Could not remove product image');
    }
  }

  Future<void> deleteReceipt(String productInstanceId) async {
    final response = await _api.deleteReceipt(productInstanceId);

    if (response.statusCode != 200) {
      Logger().e('Could not delete receipt');
    }
  }

  Future<void> setNickname(String productInstanceId, String? title) async {
    final response = await _api.setNickname(productInstanceId, title);

    if (response.statusCode != 200) {
      Logger().e('Could not save ting title');
    }
  }

  Future<ProductNoteModel?> getNote(String productInstanceId) async {
    final response = await _api.getNote(productInstanceId);

    if (response.statusCode == 200) {
      return ProductNoteModel.fromJson(response.data);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Could not load ting note');
    }
  }

  Future<void> saveNote(String productInstanceId, String? content) async {
    final response = await _api.saveNote(productInstanceId, content);

    if (response.statusCode != 200) {
      Logger().e('Could not save ting note');
    }
  }

  Future<String?> addNoteAttachment(
    String productInstanceId,
    String filePath,
    String fileName,
  ) async {
    final response = await _api.addNoteAttachment(productInstanceId, filePath, fileName);

    if (response.statusCode != 200) {
      Logger().e('Could not add note attachment');
      return null;
    } else {
      return response.data;
    }
  }

  Future<void> removeNoteAttachment(String productInstanceId, String attachmentUrl) async {
    final response = await _api.removeNoteAttachment(
      productInstanceId,
      Uri.encodeFull(attachmentUrl),
    );

    if (response.statusCode != 200) {
      Logger().e('Could not remove product note attachment');
    }
  }

  Future<List<CdnImage>> getImages(String productInstanceId) async {
    final response = await _api.getImages(productInstanceId);

    if (response.statusCode == 200) {
      return (response.data as List).map((image) => CdnImage.fromJson(image)).toList();
    } else {
      throw Exception('Could not load ting images');
    }
  }

  Future<void> saveExternalData(String productInstanceId, String? title, String? imageUrl) async {
    final response = await _api.saveExternalData(productInstanceId, title, imageUrl);

    if (response.statusCode != 200) {
      Logger().e('Could not save ting external data');
    }
  }

  Future<void> addTag(String productInstanceId, String tagId) async {
    final response = await _api.addTag(productInstanceId, tagId);

    if (response.statusCode != 200) {
      Logger().e('Could not add ting tag', error: response.data);
    }
  }

  Future<void> deleteTag(String productInstanceId, String tagId) async {
    final response = await _api.deleteTag(productInstanceId, tagId);

    if (response.statusCode != 200) {
      Logger().e('Could not delete ting tag', error: response.data);
    }
  }

  Future<void> register(String productInstanceId, dynamic data) async {
    final response = await _api.register(productInstanceId, data);

    if (response.statusCode != 200) {
      Logger().e('Could not register product', error: response.data);
    }
  }

  Future<void> setIsOwner(String productInstanceId, bool isOwner) async {
    final response = await _api.setIsOwner(productInstanceId, isOwner);

    if (response.statusCode != 200) {
      Logger().e('Could not save is owner state', error: response.data);
    }
  }

  Future<List<ProductItem>> sharedList() async {
    final response = await _api.sharedList();

    if (response.statusCode == 200) {
      return (response.data as List).map((ting) => ProductItem.fromJson(ting)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to get my tings');
    }
  }
}
