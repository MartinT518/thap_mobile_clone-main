# API Contract Validation Document

This document validates that the frontend and backend API contracts are aligned.

## Validation Date

**Date**: 2025-01-XX  
**Frontend Version**: v2.0  
**Backend API Version**: v1.0.2 (from `tings_api.yml`)

## Authentication Endpoints

### ✅ POST /v2/user/authenticate

**Frontend Usage**: `AuthRemoteDataSource.authenticate()`  
**Request Body**:

```json
{
  "accessToken": "string",
  "provider": "string"
}
```

**Response**: `String?` (token)  
**Status**: ✅ Aligned

### ✅ POST /v2/user/register

**Frontend Usage**: `AuthRemoteDataSource.register()`  
**Request Body**:

```json
{
  "email": "string",
  "name": "string",
  "language": "string",
  "country": "string"
}
```

**Response**: `String?` (token)  
**Status**: ✅ Aligned

### ✅ GET /v2/user/is_registered/{email}

**Frontend Usage**: `AuthRemoteDataSource.isRegistered()`  
**Response**: `boolean` (200 = registered, 404 = not registered)  
**Status**: ✅ Aligned

### ✅ GET /v2/user/profile

**Frontend Usage**: `AuthRemoteDataSource.getUserProfile()`  
**Response**: `UserModel` JSON  
**Status**: ✅ Aligned

---

## Product Endpoints

### ✅ GET /v2/products/{productId}

**Frontend Usage**: `ProductsRemoteDataSource.getProduct()`  
**Response**: `ProductModel` JSON  
**Status**: ✅ Aligned

### ✅ POST /v2/products/scan

**Frontend Usage**: `ProductsRemoteDataSource.scanQrCode()`  
**Request Body**:

```json
{
  "codeData": "string",
  "codeType": "string"
}
```

**Response**: `ProductModel` JSON  
**Status**: ✅ Aligned

### ✅ GET /v2/products/find?qrUrl={url}

**Frontend Usage**: `ProductsRemoteDataSource.findByQrUrl()`  
**Response**: `ProductModel` JSON  
**Status**: ✅ Aligned

### ✅ GET /v2/products/find/{ean}

**Frontend Usage**: `ProductsRemoteDataSource.findByEan()`  
**Response**: `ProductModel` JSON  
**Status**: ✅ Aligned

### ✅ GET /v2/products/search/{keyword}

**Frontend Usage**: `ProductsRemoteDataSource.searchProducts()`  
**Response**: `List<ProductSearchResult>` JSON  
**Status**: ✅ Aligned

### ✅ GET /v2/products/pages/{productId}/{language}

**Frontend Usage**: `ProductsRemoteDataSource.getProductPages()`  
**Response**: `List<Map<String, dynamic>>` JSON  
**Status**: ✅ Aligned

---

## Wallet (My Things) Endpoints

### ✅ GET /v2/tings/list

**Frontend Usage**: `WalletRemoteDataSource.getWalletProducts()`  
**Response**: `List<ProductItem>` JSON (with `instanceId`)  
**Status**: ✅ Aligned

### ✅ POST /v2/tings/add

**Frontend Usage**: `WalletRemoteDataSource.addProductToWallet()`  
**Request Body**:

```json
{
  "productId": "string"
}
```

**Response**: `String` (instanceId)  
**Status**: ✅ Aligned

### ✅ DELETE /v2/tings/{instanceId}/remove

**Frontend Usage**: `WalletRemoteDataSource.removeProductFromWallet()`  
**Response**: `200 OK`  
**Status**: ✅ Aligned

### ✅ POST /v2/tings/nickname

**Frontend Usage**: `WalletRemoteDataSource.updateNickname()`  
**Request Body**:

```json
{
  "productInstanceId": "string",
  "nickname": "string?"
}
```

**Status**: ✅ Aligned

---

## Scan History Endpoints

### ✅ GET /v2/user/scanHistory

**Frontend Usage**: `ScanHistoryRemoteDataSource.getScanHistory()`  
**Response**: `List<ScanHistoryItem>` JSON  
**Status**: ✅ Aligned

### ✅ POST /v2/user/scanHistory

**Frontend Usage**: `ScanHistoryRemoteDataSource.addToHistory()`  
**Request Body**:

```json
{
  "productId": "string"
}
```

**Status**: ✅ Aligned

### ✅ DELETE /v2/user/scanHistory/{scanHistoryId}

**Frontend Usage**: `ScanHistoryRemoteDataSource.removeFromHistory()`  
**Status**: ✅ Aligned

---

## Settings Endpoints

### ✅ GET /v2/user/settings

**Frontend Usage**: `SettingsRemoteDataSource.getSettings()`  
**Response**: `Settings` JSON  
**Status**: ✅ Aligned

### ✅ PUT /v2/user/settings

**Frontend Usage**: `SettingsRemoteDataSource.updateSettings()`  
**Request Body**:

```json
{
  "language": "string?",
  "country": "string?",
  "marketingConsent": "boolean",
  "analyticsConsent": "boolean"
}
```

**Status**: ✅ Aligned

---

## Data Models Alignment

### Product Model

**Frontend**: `ProductModel` (Freezed)  
**Backend**: `ProductItem` (from API)  
**Fields**:

- ✅ `id`: String
- ✅ `name`: String
- ✅ `brand`: String
- ✅ `barcode`: String?
- ✅ `imageUrl`: String?
- ✅ `description`: String?
- ✅ `isOwner`: Boolean
- ✅ `tags`: List<String>
- ✅ `instanceId`: String? (for wallet products)
- ✅ `nickname`: String? (for wallet products)

**Status**: ✅ Aligned

### User Model

**Frontend**: `UserModel` (Freezed)  
**Backend**: `User` (from API)  
**Fields**:

- ✅ `id`: String
- ✅ `email`: String
- ✅ `name`: String
- ✅ `photoUrl`: String?
- ✅ `token`: String
- ✅ `authMethod`: AuthMethod enum

**Status**: ✅ Aligned

---

## Error Handling

### HTTP Status Codes

- ✅ `200`: Success
- ✅ `404`: Not Found
- ✅ `401`: Unauthorized
- ✅ `500`: Server Error

**Frontend Handling**: All error cases handled in repositories  
**Status**: ✅ Aligned

---

## Authentication

### Token Storage

- ✅ Frontend: `FlutterSecureStorage` (encrypted)
- ✅ Header: `Authorization: Bearer {token}`
- ✅ Interceptor: `AuthInterceptor` adds token to requests

**Status**: ✅ Aligned

---

## Summary

| Category       | Endpoints | Status              |
| -------------- | --------- | ------------------- |
| Authentication | 4         | ✅ All Aligned      |
| Products       | 6         | ✅ All Aligned      |
| Wallet         | 4         | ✅ All Aligned      |
| Scan History   | 3         | ✅ All Aligned      |
| Settings       | 2         | ✅ All Aligned      |
| **Total**      | **19**    | **✅ 100% Aligned** |

## Notes

1. All endpoints use `/v2/` prefix as expected
2. Request/response formats match between frontend and backend
3. Error handling is consistent
4. Authentication token handling is properly implemented
5. All data models are aligned

## Recommendations

1. ✅ Continue using OpenAPI spec (`tings_api.yml`) as source of truth
2. ✅ Run API contract tests in CI/CD pipeline
3. ✅ Update this document when API changes are made
4. ✅ Consider using code generation from OpenAPI spec for type safety
