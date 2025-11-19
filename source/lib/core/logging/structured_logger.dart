import 'dart:convert';
import 'package:logger/logger.dart';

/// Structured logger for business event tracking
/// All logs include transactionId for flow tracing
class StructuredLogger {
  static final StructuredLogger _instance = StructuredLogger._internal();
  factory StructuredLogger() => _instance;
  StructuredLogger._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: Level.debug,
  );

  /// Generate a unique transaction ID for tracing a user flow
  String generateTransactionId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        '_' +
        (1000 + (9999 - 1000) * (DateTime.now().microsecond / 1000000)).round().toString();
  }

  /// Log business event with structured JSON format
  /// 
  /// [event] - Business event name (e.g., "payment_initiated", "product_scanned")
  /// [transactionId] - Unique ID to trace the flow
  /// [data] - Additional event data
  /// [level] - Log level (INFO for success, WARN for business rule rejection, ERROR for failures)
  void logEvent({
    required String event,
    required String transactionId,
    Map<String, dynamic>? data,
    Level level = Level.info,
  }) {
    final logData = {
      'event': event,
      'transactionId': transactionId,
      'timestamp': DateTime.now().toIso8601String(),
      if (data != null) ...data,
    };

    final jsonString = jsonEncode(logData);

    switch (level) {
      case Level.debug:
        _logger.d(jsonString);
        break;
      case Level.info:
        _logger.i(jsonString);
        break;
      case Level.warning:
        _logger.w(jsonString);
        break;
      case Level.error:
        _logger.e(jsonString);
        break;
      default:
        _logger.t(jsonString);
    }
  }

  /// Log successful state change
  void logSuccess({
    required String event,
    required String transactionId,
    Map<String, dynamic>? data,
  }) {
    logEvent(
      event: event,
      transactionId: transactionId,
      data: data,
      level: Level.info,
    );
  }

  /// Log business rule rejection (e.g., invalid coupon, insufficient permissions)
  void logBusinessRuleRejection({
    required String event,
    required String transactionId,
    required String reason,
    Map<String, dynamic>? data,
  }) {
    logEvent(
      event: event,
      transactionId: transactionId,
      data: {
        'reason': reason,
        'rejected': true,
        if (data != null) ...data,
      },
      level: Level.warning,
    );
  }

  /// Log system failure
  void logError({
    required String event,
    required String transactionId,
    required String error,
    Object? exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    logEvent(
      event: event,
      transactionId: transactionId,
      data: {
        'error': error,
        if (exception != null) 'exception': exception.toString(),
        if (data != null) ...data,
      },
      level: Level.error,
    );

    if (exception != null && stackTrace != null) {
      _logger.e('', error: exception, stackTrace: stackTrace);
    }
  }

  /// Log user action (button click, navigation, etc.)
  void logUserAction({
    required String action,
    required String transactionId,
    String? userId,
    String? screen,
    Map<String, dynamic>? data,
  }) {
    logEvent(
      event: 'user_action',
      transactionId: transactionId,
      data: {
        'action': action,
        if (userId != null) 'userId': userId,
        if (screen != null) 'screen': screen,
        if (data != null) ...data,
      },
      level: Level.info,
    );
  }

  /// Log API call
  void logApiCall({
    required String endpoint,
    required String transactionId,
    required String method,
    int? statusCode,
    int? durationMs,
    Map<String, dynamic>? requestData,
    Map<String, dynamic>? responseData,
    String? error,
  }) {
    logEvent(
      event: 'api_call',
      transactionId: transactionId,
      data: {
        'endpoint': endpoint,
        'method': method,
        if (statusCode != null) 'statusCode': statusCode,
        if (durationMs != null) 'durationMs': durationMs,
        if (requestData != null) 'request': requestData,
        if (responseData != null) 'response': responseData,
        if (error != null) 'error': error,
      },
      level: error != null ? Level.error : Level.info,
    );
  }
}

/// Global instance for easy access
final structuredLogger = StructuredLogger();

