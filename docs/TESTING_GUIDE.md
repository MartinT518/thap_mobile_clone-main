# Testing Guide - Thap Mobile App

## Overview

This guide provides comprehensive information about testing the Thap mobile application, including unit tests, integration tests, E2E tests, and API contract validation.

## Test Categories

### 1. Unit Tests
**Location**: `tests/unit/`  
**Purpose**: Test individual functions, classes, and business logic  
**Coverage Target**: 80%+

**Example Test Areas**:
- Domain entities (Product, User, WalletProduct)
- Repository interfaces
- Business logic functions
- Utility functions

**Running Unit Tests**:
```bash
flutter test tests/unit/
```

### 2. Widget Tests
**Location**: `tests/widget/`  
**Purpose**: Test UI components in isolation  
**Coverage Target**: All UI components

**Example Test Areas**:
- Login page rendering
- Product detail page
- Scan page UI
- My Things page
- Button interactions

**Running Widget Tests**:
```bash
flutter test tests/widget/
```

### 3. Integration Tests
**Location**: `tests/integration/`  
**Purpose**: Test feature-level functionality with multiple components  
**Coverage Target**: All major features

**Example Test Areas**:
- Authentication flow (login → session restore)
- Product scanning flow (scan → view → add to wallet)
- Wallet management flow (add → view → remove)
- Settings update flow

**Running Integration Tests**:
```bash
flutter test tests/integration/
```

### 4. E2E Tests
**Location**: `tests/e2e/`  
**Purpose**: Test complete user workflows end-to-end  
**Coverage Target**: Critical user journeys

**Example Test Scenarios**:
1. **Onboarding & First Scan**
   - App launch
   - Google login
   - Navigate to scan
   - Scan product
   - View product details
   - Add to wallet

2. **Wallet Management**
   - View My Things
   - Add product
   - View in wallet
   - Remove product

3. **AI Assistant**
   - Configure provider
   - Enter API key
   - Ask question
   - View streaming response

**Running E2E Tests**:
```bash
flutter test tests/e2e/
```

### 5. API Contract Tests
**Location**: `tests/api_contract/`  
**Purpose**: Validate frontend-backend API alignment  
**Coverage Target**: 100% of endpoints

**Test Areas**:
- Endpoint URLs match
- Request body formats
- Response formats
- Error handling
- Authentication headers

**Running API Contract Tests**:
```bash
flutter test tests/api_contract/
```

## Test Data

### Mock Data
**Location**: `tests/test_helpers/mock_data.dart`

**Available Mocks**:
- `MockData.mockUser` - Sample user
- `MockData.mockProduct` - Sample product
- `MockData.mockOwnedProduct` - Owned product
- `MockData.mockWalletProduct` - Wallet product
- `MockData.mockProductList` - List of products
- `MockData.mockProductJson` - Product JSON
- `MockData.mockUserJson` - User JSON

**Usage**:
```dart
import 'package:thap/tests/test_helpers/mock_data.dart';

final product = MockData.mockProduct;
```

## Writing Tests

### Unit Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:thap/features/products/domain/entities/product.dart';

void main() {
  group('Product Entity', () {
    test('displayName returns nickname when available', () {
      final product = Product(
        id: '1',
        name: 'Product Name',
        nickname: 'My Product',
        brand: 'Brand',
        isOwner: false,
      );
      expect(product.displayName, 'My Product');
    });
  });
}
```

### Widget Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/auth/presentation/pages/login_page.dart';

void main() {
  testWidgets('Login page displays sign in button', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: LoginPage()),
      ),
    );
    expect(find.text('Sign in with Google'), findsOneWidget);
  });
}
```

### Integration Test Example
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('Authentication Flow', () {
    test('Complete sign-in and sign-out flow', () async {
      // Setup
      final container = ProviderContainer();
      
      // Test sign-in
      // Verify authenticated state
      // Test sign-out
      // Verify initial state
      
      container.dispose();
    });
  });
}
```

## Test Coverage

### Generating Coverage Report
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Coverage Goals
- **Unit Tests**: 80%+ coverage
- **Widget Tests**: All UI components
- **Integration Tests**: All major features
- **E2E Tests**: Critical user journeys
- **API Contract**: 100% endpoint coverage

## Continuous Integration

### CI/CD Pipeline
Tests run automatically on:
- Pull requests
- Commits to main branch
- Nightly builds

### Test Execution Order
1. Unit tests (fastest)
2. Widget tests
3. Integration tests
4. API contract tests
5. E2E tests (slowest)

## Best Practices

### 1. Test Isolation
- Each test should be independent
- Use `setUp` and `tearDown` for common setup
- Mock external dependencies

### 2. Descriptive Test Names
```dart
// Good
test('displayName returns nickname when available', () {});

// Bad
test('test1', () {});
```

### 3. Arrange-Act-Assert Pattern
```dart
test('example', () {
  // Arrange
  final product = Product(...);
  
  // Act
  final result = product.displayName;
  
  // Assert
  expect(result, 'Expected Name');
});
```

### 4. Group Related Tests
```dart
group('Product Entity', () {
  test('test1', () {});
  test('test2', () {});
});
```

### 5. Mock External Services
- Mock API calls
- Mock storage
- Mock device features (camera, etc.)

## Troubleshooting

### Common Issues

1. **Tests failing due to async operations**
   - Use `await tester.pumpAndSettle()`
   - Use `await Future.delayed()`

2. **Provider not found errors**
   - Ensure `ProviderScope` wraps widgets
   - Override providers in tests

3. **Platform-specific code**
   - Use conditional imports
   - Mock platform channels

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Riverpod Testing Guide](https://riverpod.dev/docs/concepts/testing)
- [Integration Testing Guide](https://docs.flutter.dev/testing/integration-tests)

