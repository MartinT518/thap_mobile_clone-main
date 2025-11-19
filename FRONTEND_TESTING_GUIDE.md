# Frontend Testing Guide - Thap Mobile App

## Overview

This guide provides comprehensive information about frontend/widget testing for the Thap mobile application. Widget tests verify that UI components render correctly, handle user interactions, and update state appropriately.

---

## Table of Contents

1. [Introduction to Widget Testing](#introduction-to-widget-testing)
2. [Setting Up Widget Tests](#setting-up-widget-tests)
3. [Writing Widget Tests](#writing-widget-tests)
4. [Testing Common UI Patterns](#testing-common-ui-patterns)
5. [Testing with Riverpod](#testing-with-riverpod)
6. [Testing Navigation](#testing-navigation)
7. [Testing Design System Components](#testing-design-system-components)
8. [Test Examples](#test-examples)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

---

## Introduction to Widget Testing

### What are Widget Tests?

Widget tests verify that:
- UI components render correctly
- User interactions work as expected
- State changes update the UI
- Navigation flows correctly
- Error and loading states display properly

### Benefits

- **Fast:** Run in milliseconds without device/emulator
- **Reliable:** Deterministic test environment
- **Isolated:** Test individual components
- **CI/CD Friendly:** Easy to integrate into pipelines

---

## Setting Up Widget Tests

### Test File Structure

```
source/test/widget/
├── login_page_test.dart
├── product_page_test.dart
├── settings_page_test.dart
├── my_things_page_test.dart
├── menu_page_test.dart
└── ...
```

### Basic Test Setup

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/ui/pages/my_page.dart';
import 'package:thap/core/theme/app_theme.dart';
import 'test_helper.dart';

void main() {
  group('MyPage Widget Tests', () {
    setUpAll(() {
      TestHelper.setupServiceLocatorForTests();
    });

    testWidgets('My test description', (tester) async {
      // Test implementation
    });
  });
}
```

---

## Writing Widget Tests

### 1. Basic Widget Rendering Test

```dart
testWidgets('Widget renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      home: MyWidget(),
    ),
  );

  expect(find.byType(MyWidget), findsOneWidget);
});
```

### 2. Testing with Riverpod

```dart
testWidgets('Widget uses provider correctly', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: MyWidget(),
      ),
    ),
  );

  await tester.pumpAndSettle();
  
  // Verify widget behavior
  expect(find.text('Expected Text'), findsOneWidget);
});
```

### 3. Testing User Interactions

```dart
testWidgets('Button tap triggers action', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );

  // Find and tap button
  final button = find.byType(ElevatedButton);
  expect(button, findsOneWidget);
  
  await tester.tap(button);
  await tester.pump();
  
  // Verify result
  expect(find.text('Updated Text'), findsOneWidget);
});
```

### 4. Testing Form Input

```dart
testWidgets('Text input updates correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MyFormWidget(),
    ),
  );

  // Find text field
  final textField = find.byType(TextField);
  expect(textField, findsOneWidget);
  
  // Enter text
  await tester.enterText(textField, 'Test Input');
  await tester.pump();
  
  // Verify text entered
  expect(find.text('Test Input'), findsOneWidget);
});
```

### 5. Testing State Changes

```dart
testWidgets('State change updates UI', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        home: MyStatefulWidget(),
      ),
    ),
  );

  // Initial state
  expect(find.text('Initial Text'), findsOneWidget);
  
  // Trigger state change
  await tester.tap(find.byKey(Key('update-button')));
  await tester.pump();
  
  // Verify updated state
  expect(find.text('Updated Text'), findsOneWidget);
});
```

---

## Testing Common UI Patterns

### Testing Buttons

```dart
testWidgets('Primary button is tappable', (tester) async {
  await tester.pumpWidget(
    ElevatedButton(
      onPressed: () {},
      child: Text('Click Me'),
    ),
  );

  final button = find.byType(ElevatedButton);
  expect(button, findsOneWidget);
  
  await tester.tap(button);
  await tester.pump();
  
  // Verify button was tapped (no errors)
  expect(button, findsOneWidget);
});
```

### Testing Dropdowns

```dart
testWidgets('Dropdown selection works', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: DropdownButtonFormField<String>(
        items: ['Option 1', 'Option 2'].map((e) => 
          DropdownMenuItem(value: e, child: Text(e))
        ).toList(),
        onChanged: (value) {},
      ),
    ),
  );

  // Tap dropdown
  await tester.tap(find.byType(DropdownButtonFormField));
  await tester.pumpAndSettle();
  
  // Select option
  await tester.tap(find.text('Option 1'));
  await tester.pumpAndSettle();
  
  // Verify selection
  expect(find.text('Option 1'), findsOneWidget);
});
```

### Testing Lists

```dart
testWidgets('List displays items correctly', (tester) async {
  final items = ['Item 1', 'Item 2', 'Item 3'];
  
  await tester.pumpWidget(
    MaterialApp(
      home: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(items[index]),
        ),
      ),
    ),
  );

  // Verify all items displayed
  for (final item in items) {
    expect(find.text(item), findsOneWidget);
  }
});
```

### Testing Loading States

```dart
testWidgets('Loading indicator displays', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        myProvider.overrideWith((ref) => LoadingState()),
      ],
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

### Testing Error States

```dart
testWidgets('Error message displays', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        myProvider.overrideWith((ref) => ErrorState('Error message')),
      ],
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );

  expect(find.text('Error message'), findsOneWidget);
});
```

---

## Testing with Riverpod

### Overriding Providers

```dart
testWidgets('Widget with mocked provider', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith((ref) => MockAuthNotifier()),
        walletProvider.overrideWith((ref) => MockWalletNotifier()),
      ],
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );

  await tester.pumpAndSettle();
  
  // Test with mocked providers
});
```

### Testing Provider State Changes

```dart
testWidgets('Provider state change updates UI', (tester) async {
  final container = ProviderContainer();
  
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: MyWidget(),
      ),
    ),
  );

  // Initial state
  expect(find.text('Initial'), findsOneWidget);
  
  // Update provider state
  container.read(myProvider.notifier).updateState('New State');
  await tester.pump();
  
  // Verify UI updated
  expect(find.text('New State'), findsOneWidget);
  
  container.dispose();
});
```

---

## Testing Navigation

### Testing with GoRouter

```dart
testWidgets('Navigation to product page', (tester) async {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductPage(
          productId: state.pathParameters['id']!,
        ),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp.router(routerConfig: router),
    ),
  );

  // Navigate
  await tester.tap(find.byKey(Key('product-card')));
  await tester.pumpAndSettle();

  // Verify navigation
  expect(find.byType(ProductPage), findsOneWidget);
});
```

### Testing Back Navigation

```dart
testWidgets('Back button navigates correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
      },
      initialRoute: '/details',
    ),
  );

  // Tap back button
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();

  // Verify back navigation
  expect(find.byType(HomePage), findsOneWidget);
});
```

---

## Testing Design System Components

### Testing Design System Buttons

```dart
testWidgets('Button uses Design System style', (tester) async {
  await tester.pumpWidget(
    ElevatedButton(
      onPressed: () {},
      style: DesignSystemComponents.primaryButton(),
      child: Text('Click Me'),
    ),
  );

  final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
  expect(button.style, isNotNull);
  expect(button.style?.backgroundColor, isNotNull);
});
```

### Testing Design System Cards

```dart
testWidgets('Card uses Design System style', (tester) async {
  await tester.pumpWidget(
    Card(
      child: Text('Card Content'),
    ),
  );

  final card = tester.widget<Card>(find.byType(Card));
  expect(card.shape, isNotNull);
  expect(card.elevation, isNotNull);
});
```

---

## Test Examples

### Complete Login Page Test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/auth/presentation/pages/login_page.dart';
import 'package:thap/core/theme/app_theme.dart';

void main() {
  group('LoginPage Widget Tests', () {
    testWidgets('displays all required elements', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const LoginPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify logo
      expect(find.byType(SvgPicture), findsWidgets);
      
      // Verify sign in button
      expect(find.text('Sign in with Google'), findsOneWidget);
      
      // Verify terms message
      expect(find.textContaining('By signing in'), findsOneWidget);
    });

    testWidgets('sign in button is tappable', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const LoginPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final signInButton = find.text('Sign in with Google');
      expect(signInButton, findsOneWidget);

      await tester.tap(signInButton);
      await tester.pump();

      // Button should be tappable (no errors)
      expect(find.text('Sign in with Google'), findsOneWidget);
    });
  });
}
```

---

## Best Practices

### 1. Use Descriptive Test Names
```dart
// Good
testWidgets('Login page displays sign in button', (tester) async {});

// Bad
testWidgets('test1', (tester) async {});
```

### 2. Group Related Tests
```dart
group('LoginPage Widget Tests', () {
  testWidgets('displays button', (tester) async {});
  testWidgets('button is tappable', (tester) async {});
  testWidgets('handles error state', (tester) async {});
});
```

### 3. Test User Behavior, Not Implementation
```dart
// Good - tests user behavior
testWidgets('user can sign in', (tester) async {
  await tester.tap(find.text('Sign in'));
  // Verify user is signed in
});

// Avoid - tests implementation details
testWidgets('calls signIn method', (tester) async {
  // Don't test internal method calls
});
```

### 4. Use Meaningful Finders
```dart
// Good
find.byKey(Key('sign-in-button'))
find.text('Sign in with Google')
find.byType(ElevatedButton)

// Avoid
find.byType(Widget)
```

### 5. Wait for Async Operations
```dart
// Use pumpAndSettle for animations and async operations
await tester.pumpAndSettle();

// Use pump for immediate updates
await tester.pump();
```

### 6. Mock External Dependencies
```dart
testWidgets('handles API error', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        apiProvider.overrideWith((ref) => MockApiError()),
      ],
      child: MyWidget(),
    ),
  );
});
```

---

## Troubleshooting

### Widget Not Found

**Problem:** `find.byType(MyWidget)` returns nothing

**Solutions:**
- Ensure widget is actually rendered: `await tester.pumpAndSettle()`
- Check if widget is wrapped in another widget
- Verify widget is in the widget tree

### Provider Not Found

**Problem:** Provider errors in tests

**Solutions:**
- Wrap widget in `ProviderScope`
- Override providers for testing
- Use `TestHelper.setupServiceLocatorForTests()`

### Navigation Not Working

**Problem:** Navigation doesn't work in tests

**Solutions:**
- Use `MaterialApp.router` with `GoRouter`
- Wait for navigation: `await tester.pumpAndSettle()`
- Verify routes are properly configured

### State Not Updating

**Problem:** UI doesn't update after state change

**Solutions:**
- Call `await tester.pump()` after state change
- Use `pumpAndSettle()` for animations
- Verify provider is properly set up

---

## Running Widget Tests

### Run All Widget Tests
```bash
cd source
flutter test test/widget/
```

### Run Specific Widget Test
```bash
cd source
flutter test test/widget/login_page_test.dart
```

### Run with Coverage
```bash
cd source
flutter test --coverage test/widget/
genhtml coverage/lcov.info -o coverage/html
```

---

## Coverage Goals

- **Pages:** All main pages (Login, Product, Settings, My Things, Menu)
- **Components:** All reusable UI components
- **Interactions:** All user interactions (tap, scroll, input)
- **States:** Loading, error, empty, and success states
- **Navigation:** All navigation flows

---

## Summary

Widget tests are essential for ensuring UI components work correctly. Follow these guidelines:

1. ✅ Test all main pages
2. ✅ Test user interactions
3. ✅ Test state changes
4. ✅ Test error and loading states
5. ✅ Test navigation flows
6. ✅ Use Riverpod overrides for testing
7. ✅ Follow best practices

**Status:** ✅ Widget testing framework ready

