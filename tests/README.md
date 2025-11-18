# Thap Mobile App - Test Suite

This directory contains comprehensive tests for the Thap mobile application.

## Test Structure

```
tests/
├── unit/              # Unit tests for individual components
├── widget/            # Widget tests for UI components
├── integration/       # Integration tests for feature flows
├── e2e/               # End-to-end tests for complete user workflows
├── api_contract/      # API contract validation tests
└── test_helpers/      # Shared test utilities and mocks
```

## Running Tests

### All Tests
```bash
flutter test
```

### Specific Test Suite
```bash
# Unit tests only
flutter test tests/unit/

# Widget tests only
flutter test tests/widget/

# Integration tests
flutter test tests/integration/

# E2E tests (requires device/emulator)
flutter test tests/e2e/
```

### With Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Categories

### 1. Unit Tests
- Test individual functions, classes, and business logic
- Fast execution, no dependencies on Flutter framework
- Located in `tests/unit/`

### 2. Widget Tests
- Test UI components in isolation
- Verify widget rendering and interactions
- Located in `tests/widget/`

### 3. Integration Tests
- Test feature-level functionality
- Multiple components working together
- Located in `tests/integration/`

### 4. E2E Tests
- Complete user workflows
- Full app navigation and interactions
- Located in `tests/e2e/`

### 5. API Contract Tests
- Validate frontend-backend API alignment
- Verify request/response formats
- Located in `tests/api_contract/`

## Test Coverage Goals

- **Unit Tests**: 80%+ coverage
- **Widget Tests**: All UI components
- **Integration Tests**: All major features
- **E2E Tests**: Critical user journeys
- **API Contract**: 100% endpoint coverage

## Writing Tests

### Example Unit Test
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

### Example Widget Test
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

## Continuous Integration

Tests run automatically on:
- Pull requests
- Commits to main branch
- Nightly builds

## Test Data

- Use `test_helpers/mock_data.dart` for consistent test data
- Mock external dependencies (APIs, storage) in `test_helpers/mocks.dart`

