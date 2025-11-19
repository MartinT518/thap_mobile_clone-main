import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:thap/configuration.dart';
import 'package:thap/services/auth_service.dart';
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';
import 'package:thap/services/toast_service.dart';
import 'package:thap/stores/user_profile_store.dart';
import 'package:thap/ui/pages/login/login_page.dart';

_parseAndDecode(String response) {
  // Remove empty objects
  return jsonDecode(response.replaceAll(RegExp(r',\s?{\s?}'), ''));
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class ApiClient {
  final Dio dio;
  final UserProfileStore? userProfileStore; // Made nullable for Riverpod migration

  ApiClient({required this.dio, this.userProfileStore}) {
    dio
      ..options.baseUrl = Configuration.apiUrl
      ..options.connectTimeout = Configuration.apiTimeout
      ..options.receiveTimeout = Configuration.apiTimeout
      ..options.responseType = ResponseType.json;

    if (Configuration.apiPrettyLog) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: true,
          error: true,
          compact: true,
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          // Handle unauthorized state from API
          if (e.response?.statusCode == 401 && e.response?.data == 'Unauthorized') {
            locator<AuthService>().signOut();
            locator<NavigationService>().replaceAll(const LoginPage());
            locator<ToastService>().error('Unauthorized, please sign in again!');
            return;
          }
          return handler.next(e);
        },
      ),
    );

    // Update User header (only if userProfileStore is available)
    if (userProfileStore != null) {
      reaction(
        (_) => userProfileStore!.userProfile?.email,
        (email) => dio.options.headers['User'] = email,
      );

      // Update token header
      reaction(
        (_) => userProfileStore!.token,
        (token) => dio.options.headers['Authorization'] = 'Bearer ${userProfileStore!.token}',
      );
    }

    dio.transformer = BackgroundTransformer();
    (dio.transformer as BackgroundTransformer).jsonDecodeCallback = _parseJson;

    // Ignore certificate if using local development API
    // if (Configuration.apiUrl.startsWith('https://192.168')) {
    //   (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
    //     HttpClient client,
    //   ) {
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   };
    // }
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      // Handle not relative api urls
      if (url.startsWith('http')) {
        return await dio.getUri(Uri.parse(url), options: options);
      }

      return await dio.get(url, queryParameters: queryParameters, options: options);
    } catch (e) {
      final response = (e as DioException).response;
      if (response != null) {
        return response;
      }
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post(url, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      final response = (e as DioException).response;
      if (response != null) {
        return response;
      }
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.put(url, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      final response = (e as DioException).response;
      if (response != null) {
        return response;
      }
      rethrow;
    }
  }

  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.patch(url, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      if (e.runtimeType == DioException) {
        final response = (e as DioException).response;
        if (response != null) {
          return response;
        }
      }
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.delete(url, data: data, queryParameters: queryParameters, options: options);
    } catch (e) {
      final response = (e as DioException).response;
      if (response != null) {
        return response;
      }
      rethrow;
    }
  }
}
