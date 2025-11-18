import 'package:dio/dio.dart';
import 'package:thap/data/network/api/api_client.dart';
import 'package:thap/models/cdn_image.dart';

class MyTingsApi {
  final ApiClient _apiClient;

  MyTingsApi(this._apiClient);

  Future<Response> list() async {
    return await _apiClient.get('/v2/tings/list');
  }

  Future<Response> add(String productId) async {
    return await _apiClient.post('/v2/tings/add', data: {
      'productId': productId,
    });
  }

  Future<Response> delete(String productInstanceId) async {
    return await _apiClient.delete('/v2/tings/$productInstanceId/remove');
  }

  Future<Response> addReceipt(
      String productInstanceId, String filePath, String fileName) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/receipt',
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath, filename: fileName)
        }));
  }

  Future<Response> addProductImage(
      String productInstanceId, String filePath, String fileName) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/upload_image',
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath, filename: fileName)
        }));
  }

  Future<Response> removeProductImage(
      String productInstanceId, CdnImage image) async {
    return await _apiClient.delete(
        '/v2/tings/$productInstanceId/remove_image?imageUrl=${image.url}');
  }

  Future<Response> deleteReceipt(String productInstanceId) async {
    return await _apiClient.delete('/v2/tings/$productInstanceId/receipt');
  }

  Future<Response> setNickname(String productInstanceId, String? title) async {
    return await _apiClient.post('/v2/tings/nickname', data: {
      'productInstanceId': productInstanceId,
      'nickname': title,
    });
  }

  Future<Response> getNote(String productInstanceId) async {
    return await _apiClient.get('/v2/tings/$productInstanceId/note');
  }

  Future<Response> saveNote(String productInstanceId, String? content) async {
    return await _apiClient
        .post('/v2/tings/$productInstanceId/note', data: {'content': content});
  }

  Future<Response> addNoteAttachment(
      String productInstanceId, String filePath, String fileName) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/note/attachment',
        data: FormData.fromMap({
          'file': await MultipartFile.fromFile(filePath, filename: fileName)
        }));
  }

  Future<Response> removeNoteAttachment(
      String productInstanceId, String attachmentUrl) async {
    return await _apiClient.delete(
        '/v2/tings/$productInstanceId/note/attachment?attachmentUrl=$attachmentUrl');
  }

  Future<Response> getImages(String productInstanceId) async {
    return await _apiClient.get('/v2/tings/$productInstanceId/images');
  }

  Future<Response> saveExternalData(
      String productInstanceId, String? title, String? imageUrl) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/external_data',
        data: {'title': title, 'imageUrl': imageUrl});
  }

  Future<Response> addTag(String productInstanceId, String tagId) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/set_tag/$tagId');
  }

  Future<Response> deleteTag(String productInstanceId, String tagId) async {
    return await _apiClient
        .delete('/v2/tings/$productInstanceId/remove_tag/$tagId');
  }

  Future<Response> register(String productInstanceId, dynamic data) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/register',
        data: data);
  }

  Future<Response> setIsOwner(String productInstanceId, bool isOwner) async {
    return await _apiClient.post('/v2/tings/$productInstanceId/is_owner',
        data: {'isOwner': isOwner});
  }

  Future<Response> sharedList() async {
    return await _apiClient.get('/v2/tings/list/shared');
  }
}
