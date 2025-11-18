# Running Tests

## Prerequisites

1. Flutter SDK installed and in PATH
2. Dependencies installed: `cd source && flutter pub get`
3. Code generation completed: `cd source && flutter pub run build_runner build --delete-conflicting-outputs`

## Running All Tests

```bash
cd source
flutter test
```

## Running Specific Test Files

```bash
# AI functionality tests
cd source
flutter test test/ai_service_test.dart
flutter test test/ai_repository_test.dart
flutter test test/ai_demo_responses_test.dart
flutter test test/ai_question_selection_test.dart
flutter test test/ai_chat_widget_test.dart

# Entity tests
flutter test test/product_entity_test.dart
flutter test test/user_entity_test.dart
flutter test test/wallet_product_test.dart
flutter test test/settings_entity_test.dart

# API contract validation
flutter test test/api_contract_validation_test.dart
```

## Test Coverage

To generate coverage report:

```bash
cd source
flutter test --coverage
```

Coverage report will be in `coverage/lcov.info`

## Expected Test Results

All tests should pass:
- ✅ AI Service tests (7 tests)
- ✅ AI Repository tests (6 tests)
- ✅ AI Demo Responses tests (6 tests)
- ✅ AI Question Selection tests (4 tests)
- ✅ AI Chat Widget tests (3 tests)
- ✅ Product Entity tests (4 tests)
- ✅ User Entity tests
- ✅ Wallet Product tests
- ✅ Settings Entity tests
- ✅ API Contract Validation tests

## Troubleshooting

### Code Generation Required

If tests fail with missing `.freezed.dart` or `.g.dart` files:

```bash
cd source
flutter pub run build_runner build --delete-conflicting-outputs
```

### Service Locator Issues

If tests fail with service locator errors, ensure:
1. `setupServiceLocator()` is called in `setUpAll()`
2. Mock SharedPreferences is initialized
3. All required services are registered

### Flutter Not Found

If `flutter` command is not recognized:
1. Add Flutter to PATH
2. Or use full path: `/path/to/flutter/bin/flutter test`
