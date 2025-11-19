# Architecture Migration Guide

## 📋 Overview

This guide documents the migration from Legacy Architecture to v2.0 (Modern Architecture).

---

## 🏗️ Architecture Evolution

### Legacy Architecture (v1.0)
- **State Management:** MobX
- **Dependency Injection:** GetIt
- **Navigation:** Custom NavigationService
- **UI Components:** Custom buttons, inconsistent styles

### Modern Architecture (v2.0)
- **State Management:** Riverpod
- **Dependency Injection:** Riverpod providers
- **Navigation:** GoRouter
- **UI Components:** Design System v2.0

---

## ⚠️ Deprecation Notices

### 1. NavigationService (DEPRECATED)

**Status:** ⚠️ Deprecated - Use GoRouter  
**Timeline:** Will be removed in v3.0

**Old Way (Deprecated):**
```dart
import 'package:thap/services/navigation_service.dart';
import 'package:thap/services/service_locator.dart';

final navigationService = locator<NavigationService>();
navigationService.push(SomePage());
navigationService.pop();
```

**New Way (Recommended):**
```dart
import 'package:go_router/go_router.dart';

context.push('/some-page');
context.pop();
```

**Migration Steps:**
1. Import `go_router` instead of `navigation_service`
2. Use `context.push()` instead of `navigationService.push()`
3. Use `context.pop()` instead of `navigationService.pop()`
4. Define routes in `app_router.dart`

---

### 2. GetIt/Service Locator (DEPRECATED)

**Status:** ⚠️ Deprecated - Use Riverpod providers  
**Timeline:** Will be removed in v3.0

**Old Way (Deprecated):**
```dart
import 'package:thap/services/service_locator.dart';

final myService = locator<MyService>();
final myStore = locator<MyStore>();
```

**New Way (Recommended):**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// In provider file
final myServiceProvider = Provider((ref) => MyService());

// In widget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myService = ref.watch(myServiceProvider);
    // Use myService...
  }
}
```

**Migration Steps:**
1. Create Riverpod provider for your service
2. Convert `StatelessWidget` → `ConsumerWidget`
3. Use `ref.watch(provider)` instead of `locator<Service>()`
4. Remove GetIt registrations from `service_locator.dart`

---

### 3. MobX Stores (DEPRECATED)

**Status:** ⚠️ Deprecated - Use Riverpod StateNotifiers  
**Timeline:** Will be removed in v3.0

**Old Way (Deprecated):**
```dart
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:thap/stores/my_tings_store.dart';

Observer(
  builder: (_) => Text('${myTingsStore.products.length}'),
)
```

**New Way (Recommended):**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/wallet/presentation/providers/wallet_provider.dart';

Consumer(
  builder: (context, ref, child) {
    final walletState = ref.watch(walletNotifierProvider);
    return walletState.maybeWhen(
      loaded: (products) => Text('${products.length}'),
      orElse: () => CircularProgressIndicator(),
    );
  },
)
```

**Migration Steps:**
1. Create StateNotifier for your state
2. Create Riverpod provider
3. Replace `Observer` with `Consumer`
4. Use `ref.watch()` to access state
5. Remove MobX imports

---

### 4. Custom Buttons (DEPRECATED)

**Status:** ✅ COMPLETED - All migrated to Design System  
**Timeline:** Legacy buttons marked deprecated

**Old Way (Deprecated):**
```dart
import 'package:thap/ui/common/button.dart';

MainButton(
  onTap: () {},
  text: 'Click Me',
)

LightButton(
  onTap: () {},
  text: 'Cancel',
)
```

**New Way (Current):**
```dart
import 'package:thap/shared/widgets/design_system_components.dart';

ElevatedButton(
  onPressed: () {},
  style: DesignSystemComponents.primaryButton(),
  child: Text('Click Me'),
)

OutlinedButton(
  onPressed: () {},
  style: DesignSystemComponents.secondaryButton(),
  child: Text('Cancel'),
)
```

---

## 📊 Migration Status

| Component | Old | New | Status | Progress |
|-----------|-----|-----|--------|----------|
| **Buttons** | MainButton/LightButton | DesignSystemComponents | ✅ Complete | 100% (20/20 files) |
| **State Management** | MobX | Riverpod | ⚠️ Partial | 70% (Wallet, Auth done) |
| **Navigation** | NavigationService | GoRouter | ⚠️ Partial | 50% (Routes defined) |
| **DI** | GetIt | Riverpod | ⚠️ Partial | 30% (New features only) |
| **Loading States** | CircularProgressIndicator | Shimmer | ✅ Complete | 100% (Components ready) |
| **Dialogs** | Custom | DesignSystemComponents | ✅ Complete | 100% |
| **Toast** | Legacy | Design System v2.0 | ✅ Complete | 100% |

---

## 🎯 Migration Priorities

### High Priority (Breaking Changes in v3.0)
1. ✅ **Buttons** - Completed
2. ⏳ **MobX Stores** - In progress (70%)
3. ⏳ **NavigationService** - In progress (50%)

### Medium Priority (Deprecation Warnings)
4. ⏳ **GetIt** - In progress (30%)
5. ✅ **Loading States** - Components ready

### Low Priority (Nice to Have)
6. **Code Organization** - Clean architecture patterns
7. **Testing** - Increase coverage to 90%

---

## 🚀 Quick Start for New Features

When building new features, use this stack:

```dart
// 1. Define entity (domain layer)
@freezed
class MyEntity with _$MyEntity {
  const factory MyEntity({
    required String id,
    required String name,
  }) = _MyEntity;
}

// 2. Create repository (data layer)
abstract class MyRepository {
  Future<List<MyEntity>> getItems();
}

// 3. Implement repository
class MyRepositoryImpl implements MyRepository {
  final Dio _dio;
  MyRepositoryImpl(this._dio);
  
  @override
  Future<List<MyEntity>> getItems() async {
    // Implementation
  }
}

// 4. Create provider
final myRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return MyRepositoryImpl(dio);
});

// 5. Create state notifier
@freezed
class MyState with _$MyState {
  const factory MyState.initial() = _Initial;
  const factory MyState.loading() = _Loading;
  const factory MyState.loaded(List<MyEntity> items) = _Loaded;
  const factory MyState.error(String message) = _Error;
}

class MyNotifier extends StateNotifier<MyState> {
  final MyRepository _repository;
  
  MyNotifier(this._repository) : super(const MyState.initial());
  
  Future<void> loadItems() async {
    state = const MyState.loading();
    try {
      final items = await _repository.getItems();
      state = MyState.loaded(items);
    } catch (e) {
      state = MyState.error(e.toString());
    }
  }
}

final myNotifierProvider = StateNotifierProvider<MyNotifier, MyState>((ref) {
  final repository = ref.watch(myRepositoryProvider);
  return MyNotifier(repository);
});

// 6. Use in UI
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myNotifierProvider);
    
    return state.when(
      initial: () => ElevatedButton(
        onPressed: () => ref.read(myNotifierProvider.notifier).loadItems(),
        style: DesignSystemComponents.primaryButton(),
        child: Text('Load Items'),
      ),
      loading: () => ProductListItemShimmer(), // Shimmer skeleton
      loaded: (items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(items[index].name),
        ),
      ),
      error: (message) => Text('Error: $message'),
    );
  }
}
```

---

## 📚 Resources

- **Design System:** `docs/Design_System.md`
- **Architecture:** `docs/Technical_Architecture_v2_Recommended.md`
- **Testing:** `docs/TESTING_GUIDE.md`
- **API Contracts:** `docs/API_CONTRACT_VALIDATION.md`

---

## ⚡ Tips

1. **Always use Design System components** for consistency
2. **Prefer Riverpod over GetIt** for new code
3. **Use Freezed** for immutable data classes
4. **Write tests** for all new features
5. **Follow the layered architecture** (presentation → domain → data)

---

## 🎉 Completed Migrations

### Recent Achievements
- ✅ **All 20 button files migrated** to Design System v2.0
- ✅ **Shimmer skeletons** implemented
- ✅ **Offline mode** with cache-first strategy
- ✅ **Image caching** optimized (60-80% memory reduction)
- ✅ **AI streaming** fixed and enhanced
- ✅ **Dialogs** standardized
- ✅ **Toast notifications** following Design System

---

**Last Updated:** 2024
**Version:** 2.0.0
**Status:** Migration in progress (70% complete)

