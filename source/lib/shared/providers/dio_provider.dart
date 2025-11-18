import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:thap/core/config/env.dart';

/// Dio instance provider for HTTP requests
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: Env.apiTimeout,
      receiveTimeout: Env.apiTimeout,
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Add pretty logger in debug mode
  if (Env.apiPrettyLog) {
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

  // Add auth interceptor (will be implemented when auth is ready)
  // dio.interceptors.add(AuthInterceptor(ref));

  return dio;
});

