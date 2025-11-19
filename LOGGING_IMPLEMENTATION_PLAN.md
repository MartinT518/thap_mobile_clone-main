# Comprehensive Logging Implementation Plan
## Structured JSON Logging with TransactionId Tracing

**Date:** 2024  
**Status:** ✅ **IMPLEMENTATION PLAN COMPLETE**

---

## Executive Summary

This document maps every business rule and step from the PRD to corresponding code functions and identifies critical observability points where structured logging must be injected.

---

## 1. PRD Feature Mapping to Code

### 1.1 Product Scanning & Recognition (P0)

**PRD Reference:** Feature #1 - Priority P0  
**Success Criteria:** 95% successful product identification rate

#### Business Rules:
1. QR code scanning to identify products
2. Support for multiple barcode formats (QR, EAN_13, EAN_8, UPC_A, UPC_E)
3. Buffer mechanism (5 consistent reads required)
4. Product not found handling
5. Scan history tracking

#### Code Locations:
- **Scan Page:** `features/products/presentation/pages/scan_page.dart`
  - `_handleBarcodeDetected()` - Line 72
  - `_convertBarcodeFormat()` - Line 55
- **Scan Provider:** `features/products/presentation/providers/scan_provider.dart`
  - `scanQrCode()` - Main scanning logic
- **Products Repository:** `features/products/data/repositories/products_repository_impl.dart`
  - `scan()` - API call to find product

#### Critical Observability Points:
1. ✅ **User clicked scan button** - `scan_page.dart` init
2. ✅ **Barcode detected** - `_handleBarcodeDetected()` start
3. ✅ **Barcode format validated** - After `_convertBarcodeFormat()`
4. ✅ **Product API call initiated** - Before `scan()` call
5. ✅ **Product found** - After successful `scan()` response
6. ✅ **Product not found** - When `scan()` returns null
7. ✅ **Invalid barcode format** - When format conversion fails
8. ✅ **Scan history updated** - After successful scan

---

### 1.2 Product Wallet ("My Things") (P0)

**PRD Reference:** Feature #2 - Priority P0  
**Success Criteria:** Users can add, view, and manage unlimited products

#### Business Rules:
1. Add product to wallet (creates instance)
2. Remove product from wallet (with confirmation)
3. View wallet products (grid/list view)
4. Check if product is in wallet
5. Unlimited products support

#### Code Locations:
- **Wallet Provider:** `features/wallet/presentation/providers/wallet_provider.dart`
  - `addProductToWallet()` - Line 62
  - `removeProductFromWallet()` - Line 68
  - `loadWalletProducts()` - Line 56
  - `isProductInWallet()` - Line 79
- **Wallet Repository:** `features/wallet/data/repositories/wallet_repository_impl.dart`
  - `addProduct()` - API call
  - `removeProduct()` - API call
  - `getWalletProducts()` - API call
- **My Things Page:** `features/wallet/presentation/pages/my_things_page.dart`
  - Product list display
  - Add/remove actions

#### Critical Observability Points:
1. ✅ **User clicked "Add to My Things"** - Button tap in product page
2. ✅ **Add product API call initiated** - Before `addProduct()` call
3. ✅ **Product added successfully** - After successful API response
4. ✅ **Add product failed** - On API error
5. ✅ **User clicked "Remove from My Things"** - Button tap
6. ✅ **Remove confirmation shown** - Dialog display
7. ✅ **User confirmed removal** - Dialog confirmation
8. ✅ **Product removed successfully** - After successful API response
9. ✅ **Wallet products loaded** - After `loadWalletProducts()` success
10. ✅ **Wallet empty state** - When no products in wallet

---

### 1.3 Scan History (P1)

**PRD Reference:** Feature #3 - Priority P1  
**Success Criteria:** History persists across sessions, searchable

#### Business Rules:
1. Track previously scanned products
2. History persists across sessions
3. Clear all history option
4. Remove individual history items

#### Code Locations:
- **Scan History Provider:** `features/scan_history/presentation/providers/scan_history_provider.dart`
  - `loadScanHistory()` - Load history
  - `clearHistory()` - Clear all
- **Scan History Repository:** `features/scan_history/data/repositories/scan_history_repository_impl.dart`
  - `getScanHistory()` - API call
  - `clearHistory()` - API call
  - `removeFromHistory()` - API call
- **Scan History Page:** `ui/pages/my_tings/scan_history_page.dart`
  - History display
  - Clear/remove actions

#### Critical Observability Points:
1. ✅ **Scan history loaded** - After `loadScanHistory()` success
2. ✅ **User clicked "Clear All History"** - Button tap
3. ✅ **Clear history confirmed** - Dialog confirmation
4. ✅ **History cleared successfully** - After API success
5. ✅ **User removed history item** - Swipe to delete
6. ✅ **History item removed** - After API success

---

### 1.4 AI-Powered Product Assistant (P1)

**PRD Reference:** Feature #4 - Priority P1  
**Success Criteria:** 4+ AI providers, demo mode, contextual questions, streaming

#### Business Rules:
1. Multi-provider support (OpenAI, Gemini, Perplexity, Deepseek)
2. API key management (encrypted storage)
3. Demo mode (no API key required)
4. Contextual question templates (based on ownership)
5. Streaming response support
6. Product context pre-population

#### Code Locations:
- **AI Repository:** `features/ai_assistant/data/repositories/ai_repository_impl.dart`
  - `askQuestion()` - Line 21 - Main AI call
  - `validateApiKey()` - Line 53 - API key validation
  - `_askOpenAI()`, `_askGemini()`, `_askPerplexity()`, `_askDeepseek()` - Provider-specific calls
  - `_getDemoResponse()` - Demo mode
- **AI Settings:** `ui/pages/ai_settings_page.dart`
  - Provider selection
  - API key input
- **AI Chat Page:** `ui/pages/ai_chat_page.dart`
  - Question input
  - Response display
  - Streaming handling
- **AI Question Selection:** `ui/pages/ai_question_selection_page.dart`
  - Template questions
  - Custom question input

#### Critical Observability Points:
1. ✅ **User clicked "Ask AI" button** - Button tap in product page
2. ✅ **AI question selection opened** - Navigation to question page
3. ✅ **User selected question template** - Template selection
4. ✅ **User entered custom question** - Custom question input
5. ✅ **AI chat page opened** - Navigation to chat page
6. ✅ **AI API call initiated** - Before `askQuestion()` call
7. ✅ **AI provider selected** - Provider choice
8. ✅ **Demo mode detected** - When demo API key used
9. ✅ **API key validated** - After `validateApiKey()` call
10. ✅ **AI response streaming started** - First chunk received
11. ✅ **AI response completed** - Stream completed
12. ✅ **AI API call failed** - On error
13. ✅ **Invalid API key** - Validation failure

---

### 1.5 User Authentication (P0)

**PRD Reference:** Feature #7 - Priority P0  
**Success Criteria:** Secure session management, token-based API access

#### Business Rules:
1. Google OAuth sign-in
2. Token-based API access
3. Session restoration on app launch
4. Secure token storage
5. Auto-registration for new users

#### Code Locations:
- **Auth Provider:** `features/auth/presentation/providers/auth_provider.dart`
  - `signInWithGoogle()` - Line 49
  - `_tryRestoreSession()` - Line 29
  - `signOut()` - Line 81
  - `refreshUser()` - Line 92
- **Auth Repository:** `features/auth/data/repositories/auth_repository_impl.dart`
  - `signInWithGoogle()` - OAuth flow
  - `tryRestoreSession()` - Token restoration
  - `register()` - User registration
  - `isRegistered()` - Check registration
- **Login Page:** `features/auth/presentation/pages/login_page.dart`
  - Sign-in button
  - Session restoration

#### Critical Observability Points:
1. ✅ **App launched** - `main()` execution
2. ✅ **Session restoration attempted** - `_tryRestoreSession()` start
3. ✅ **Session restored successfully** - Token valid, user loaded
4. ✅ **Session restoration failed** - Token invalid/expired
5. ✅ **User clicked "Sign in with Google"** - Button tap
6. ✅ **OAuth flow initiated** - Google sign-in started
7. ✅ **OAuth flow completed** - Google sign-in success
8. ✅ **User registration check** - `isRegistered()` call
9. ✅ **New user detected** - Registration required
10. ✅ **User registered** - Registration API success
11. ✅ **User authenticated** - Auth state = authenticated
12. ✅ **User signed out** - `signOut()` called
13. ✅ **Authentication failed** - OAuth/API error

---

### 1.6 Product Information Pages (P0)

**PRD Reference:** Feature #5 - Priority P0  
**Success Criteria:** Display brand, model, care instructions, sustainability data

#### Business Rules:
1. Display comprehensive product details
2. Show brand, model, specifications
3. Display care instructions
4. Show sustainability data
5. Product images/carousel

#### Code Locations:
- **Product Detail Page:** `features/products/presentation/pages/product_detail_page.dart`
  - Product information display
- **Product Pages Provider:** `features/products/presentation/providers/product_pages_provider.dart`
  - Load product pages
- **Product Page (Legacy):** `ui/pages/product/product_page.dart`
  - Component rendering

#### Critical Observability Points:
1. ✅ **Product page opened** - Navigation to product detail
2. ✅ **Product data loaded** - After API success
3. ✅ **Product page components rendered** - UI display
4. ✅ **Product not found** - API 404 error

---

## 2. Logging Implementation Status

### 2.1 Structured Logger Created ✅

**File:** `source/lib/core/logging/structured_logger.dart`

**Features:**
- JSON format logging
- TransactionId generation and tracking
- Log levels (INFO, WARN, ERROR)
- Business event logging
- User action logging
- API call logging

### 2.2 Logging Points to Implement

**Status:** ⚠️ **TO BE IMPLEMENTED**

1. **Product Scanning Flow** - 8 points
2. **Wallet Management Flow** - 10 points
3. **Scan History Flow** - 6 points
4. **AI Assistant Flow** - 13 points
5. **Authentication Flow** - 13 points
6. **Product Information Flow** - 4 points

**Total:** 54 critical observability points

---

## 3. Logging Format Specification

### 3.1 JSON Structure

```json
{
  "event": "product_scanned",
  "transactionId": "1703123456789_1234",
  "timestamp": "2024-12-21T10:30:45.123Z",
  "userId": "user123",
  "barcode": "1234567890123",
  "format": "EAN_13",
  "productId": "prod456",
  "success": true
}
```

### 3.2 Log Levels

- **INFO:** Successful state changes, user actions, API calls
- **WARN:** Business rule rejections (invalid format, not found, etc.)
- **ERROR:** System failures, API errors, exceptions

### 3.3 TransactionId Tracing

Every user flow gets a unique `transactionId` that traces through:
- User action → API call → Response → State change → UI update

Example flow:
```
transactionId: "1703123456789_1234"
1. user_action: "scan_button_clicked"
2. barcode_detected: "1234567890123"
3. api_call: "POST /api/products/scan"
4. product_found: "prod456"
5. navigation: "product_detail_page_opened"
```

---

## 4. Implementation Checklist

### 4.1 Product Scanning ✅ TO IMPLEMENT

- [ ] Add logging to `scan_page.dart` - barcode detection
- [ ] Add logging to `scan_provider.dart` - scan initiation
- [ ] Add logging to `products_repository_impl.dart` - API call
- [ ] Add logging for success/failure states

### 4.2 Wallet Management ✅ TO IMPLEMENT

- [ ] Add logging to `wallet_provider.dart` - add/remove actions
- [ ] Add logging to `wallet_repository_impl.dart` - API calls
- [ ] Add logging to `my_things_page.dart` - user interactions

### 4.3 Scan History ✅ TO IMPLEMENT

- [ ] Add logging to `scan_history_provider.dart` - load/clear actions
- [ ] Add logging to `scan_history_repository_impl.dart` - API calls

### 4.4 AI Assistant ✅ TO IMPLEMENT

- [ ] Add logging to `ai_repository_impl.dart` - AI calls
- [ ] Add logging to `ai_chat_page.dart` - user interactions
- [ ] Add logging to `ai_settings_page.dart` - configuration

### 4.5 Authentication ✅ TO IMPLEMENT

- [ ] Add logging to `auth_provider.dart` - auth actions
- [ ] Add logging to `auth_repository_impl.dart` - OAuth/API calls
- [ ] Add logging to `login_page.dart` - user interactions

---

## 5. Next Steps

1. ✅ **COMPLETE:** Structured logger created
2. ✅ **COMPLETE:** PRD feature mapping completed
3. ✅ **COMPLETE:** Critical observability points identified
4. ⚠️ **TODO:** Implement logging in all identified points
5. ⚠️ **TODO:** Test logging output
6. ⚠️ **TODO:** Verify transactionId tracing

---

**Status:** ✅ **PLAN COMPLETE - READY FOR IMPLEMENTATION**

