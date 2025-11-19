/// Example implementation showing how to add structured logging
/// This file demonstrates logging patterns for the Product Scanning flow
/// 
/// Copy these patterns to implement logging in other features

import 'package:thap/core/logging/structured_logger.dart';

// Example: Product Scanning Flow with Logging
class ProductScanningExample {
  final structuredLogger = StructuredLogger();

  /// Example: Scan page with logging
  Future<void> handleBarcodeDetectedExample(
    String barcode,
    String format,
    String? userId,
  ) async {
    // Generate transactionId for this flow
    final transactionId = structuredLogger.generateTransactionId();

    // 1. Log user action (barcode detected)
    structuredLogger.logUserAction(
      action: 'barcode_detected',
      transactionId: transactionId,
      userId: userId,
      screen: 'scan_page',
      data: {
        'barcode': barcode,
        'format': format,
      },
    );

    // 2. Validate barcode format
    final isValidFormat = _validateFormat(format);
    if (!isValidFormat) {
      structuredLogger.logBusinessRuleRejection(
        event: 'barcode_format_invalid',
        transactionId: transactionId,
        reason: 'Unsupported barcode format',
        data: {
          'barcode': barcode,
          'format': format,
        },
      );
      return;
    }

    // 3. Log API call initiation
    final apiStartTime = DateTime.now();
    structuredLogger.logApiCall(
      endpoint: '/api/products/scan',
      transactionId: transactionId,
      method: 'POST',
      requestData: {
        'barcode': barcode,
        'format': format,
      },
    );

    try {
      // 4. Make API call (example)
      // final product = await productsRepository.scan(barcode, format);
      
      // 5. Log API response
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logApiCall(
        endpoint: '/api/products/scan',
        transactionId: transactionId,
        method: 'POST',
        statusCode: 200,
        durationMs: apiDuration,
        responseData: {
          'productId': 'prod123', // product?.id,
          'found': true,
        },
      );

      // 6. Log successful state change
      structuredLogger.logSuccess(
        event: 'product_scanned',
        transactionId: transactionId,
        data: {
          'barcode': barcode,
          'format': format,
          'productId': 'prod123', // product?.id,
          'durationMs': apiDuration,
        },
      );

      // 7. Log navigation
      structuredLogger.logUserAction(
        action: 'navigate_to_product_detail',
        transactionId: transactionId,
        userId: userId,
        screen: 'scan_page',
        data: {
          'productId': 'prod123', // product?.id,
        },
      );
    } catch (e, stackTrace) {
      // 8. Log error
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logError(
        event: 'product_scan_failed',
        transactionId: transactionId,
        error: 'Product scan API call failed',
        exception: e,
        stackTrace: stackTrace,
        data: {
          'barcode': barcode,
          'format': format,
          'durationMs': apiDuration,
        },
      );
    }
  }

  /// Example: Product not found scenario
  void handleProductNotFoundExample(String barcode, String transactionId) {
    structuredLogger.logBusinessRuleRejection(
      event: 'product_not_found',
      transactionId: transactionId,
      reason: 'No product found for barcode',
      data: {
        'barcode': barcode,
      },
    );
  }

  bool _validateFormat(String format) {
    const supportedFormats = ['QR', 'EAN_13', 'EAN_8', 'UPC_A', 'UPC_E'];
    return supportedFormats.contains(format);
  }
}

// Example: Wallet Management Flow with Logging
class WalletManagementExample {
  final structuredLogger = StructuredLogger();

  /// Example: Add product to wallet with logging
  Future<void> addProductToWalletExample(
    String productId,
    String userId,
  ) async {
    final transactionId = structuredLogger.generateTransactionId();

    // 1. Log user action
    structuredLogger.logUserAction(
      action: 'add_to_wallet_clicked',
      transactionId: transactionId,
      userId: userId,
      screen: 'product_detail_page',
      data: {
        'productId': productId,
      },
    );

    // 2. Check if already in wallet (business rule)
    // final isInWallet = await walletRepository.isProductInWallet(productId);
    // if (isInWallet) {
    //   structuredLogger.logBusinessRuleRejection(
    //     event: 'product_already_in_wallet',
    //     transactionId: transactionId,
    //     reason: 'Product is already in wallet',
    //     data: {
    //       'productId': productId,
    //     },
    //   );
    //   return;
    // }

    // 3. Log API call
    final apiStartTime = DateTime.now();
    structuredLogger.logApiCall(
      endpoint: '/api/wallet/products',
      transactionId: transactionId,
      method: 'POST',
      requestData: {
        'productId': productId,
      },
    );

    try {
      // 4. Make API call
      // final instanceId = await walletRepository.addProduct(productId);

      // 5. Log success
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logSuccess(
        event: 'product_added_to_wallet',
        transactionId: transactionId,
        data: {
          'productId': productId,
          'instanceId': 'inst123', // instanceId,
          'durationMs': apiDuration,
        },
      );
    } catch (e, stackTrace) {
      // 6. Log error
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logError(
        event: 'add_to_wallet_failed',
        transactionId: transactionId,
        error: 'Failed to add product to wallet',
        exception: e,
        stackTrace: stackTrace,
        data: {
          'productId': productId,
          'durationMs': apiDuration,
        },
      );
    }
  }
}

// Example: AI Assistant Flow with Logging
class AIAssistantExample {
  final structuredLogger = StructuredLogger();

  /// Example: AI question asked with logging
  Future<void> askAIQuestionExample(
    String question,
    String productId,
    String userId,
    String provider,
    bool isDemoMode,
  ) async {
    final transactionId = structuredLogger.generateTransactionId();

    // 1. Log user action
    structuredLogger.logUserAction(
      action: 'ask_ai_clicked',
      transactionId: transactionId,
      userId: userId,
      screen: 'product_detail_page',
      data: {
        'productId': productId,
      },
    );

    // 2. Log question selection
    structuredLogger.logUserAction(
      action: 'ai_question_selected',
      transactionId: transactionId,
      userId: userId,
      screen: 'ai_question_selection_page',
      data: {
        'question': question,
        'productId': productId,
      },
    );

    // 3. Log AI provider and mode
    structuredLogger.logEvent(
      event: 'ai_request_initiated',
      transactionId: transactionId,
      data: {
        'provider': provider,
        'isDemoMode': isDemoMode,
        'productId': productId,
        'question': question,
      },
    );

    // 4. Log API call
    final apiStartTime = DateTime.now();
    structuredLogger.logApiCall(
      endpoint: '/api/ai/ask',
      transactionId: transactionId,
      method: 'POST',
      requestData: {
        'provider': provider,
        'question': question,
        'productId': productId,
      },
    );

    try {
      // 5. Stream AI response
      // await for (final chunk in aiStream) {
      //   // Log first chunk
      //   if (isFirstChunk) {
      //     structuredLogger.logEvent(
      //       event: 'ai_response_streaming_started',
      //       transactionId: transactionId,
      //       data: {
      //         'provider': provider,
      //       },
      //     );
      //   }
      // }

      // 6. Log completion
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logSuccess(
        event: 'ai_response_completed',
        transactionId: transactionId,
        data: {
          'provider': provider,
          'isDemoMode': isDemoMode,
          'durationMs': apiDuration,
        },
      );
    } catch (e, stackTrace) {
      // 7. Log error
      final apiDuration = DateTime.now().difference(apiStartTime).inMilliseconds;
      structuredLogger.logError(
        event: 'ai_request_failed',
        transactionId: transactionId,
        error: 'AI API call failed',
        exception: e,
        stackTrace: stackTrace,
        data: {
          'provider': provider,
          'isDemoMode': isDemoMode,
          'durationMs': apiDuration,
        },
      );
    }
  }
}

