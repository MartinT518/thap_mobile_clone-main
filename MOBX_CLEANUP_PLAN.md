# MobX to Riverpod Cleanup Plan

## Current Status
- **32/35 tests passing** (91%)
- **3 failures** due to MobX legacy code

---

## Migration Mapping

### 1. UserProfileStore → authProvider (Already Exists!)

**Legacy (MobX):**
```dart
final userProfileStore = locator<UserProfileStore>();
userProfileStore.userProfile?.name
userProfileStore.setToken(token)
```

**New (Riverpod):**
```dart
final authState = ref.watch(authProvider);
authState.maybeWhen(
  authenticated: (user) => user.name,
  orElse: () => null,
)
```

**Files to Update:**
- `ui/pages/user_profile_page.dart`
- `ui/pages/my_tings/my_tings_empty_section.dart`
- `ui/pages/settings_page.dart`
- `ui/pages/menu_page.dart`
- `data/network/api/api_client.dart`
- `services/auth_service.dart`

---

### 2. MyTingsStore → walletNotifierProvider (Already Exists!)

**Legacy (MobX):**
```dart
final myTingsStore = locator<MyTingsStore>();
Observer(builder: (_) => Text('${myTingsStore.products.length}'))
```

**New (Riverpod):**
```dart
final walletState = ref.watch(walletNotifierProvider);
walletState.maybeWhen(
  loaded: (products) => Text('${products.length}'),
  orElse: () => CircularProgressIndicator(),
)
```

**Files to Update:**
- `ui/pages/my_tings/my_tings_page.dart`
- `ui/pages/my_tings/my_tings_list_section.dart`
- `ui/common/add_to_my_tings_button.dart`

---

### 3. ProductTagsStore → Keep for now (Simple)

**Legacy (MobX):**
```dart
final tagsStore = locator<ProductTagsStore>();
Observer(builder: (_) => ListView(children: tagsStore.tags))
```

**New (Riverpod):**
```dart
Consumer(builder: (context, ref, child) {
  final tags = tagsStore.tags; // Keep store temporarily
  return ListView(children: tags);
})
```

**Files to Update:**
- `ui/pages/user_tags_page.dart`
- `ui/common/product_tags_section.dart`

---

### 4. ProductPagesStore → Remove (Unused)

**Files to Update:**
- `service_locator.dart` (remove registration)
- Delete `stores/product_pages_store.dart`
- Delete `stores/product_pages_store.g.dart`

---

## Observer → Consumer Migration

**Before:**
```dart
import 'package:flutter_mobx/flutter_mobx.dart';

Observer(
  builder: (_) => Text(store.someValue),
)
```

**After:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

Consumer(
  builder: (context, ref, child) {
    final state = ref.watch(someProvider);
    return Text(state);
  },
)
```

---

## Implementation Order

### Phase 1: Quick Wins (Fix tests)
1. ✅ Remove `ProductPagesStore` (unused)
2. ✅ Update `service_locator.dart` (remove MobX registrations)
3. ✅ Fix test helper (remove GetIt expectations)

### Phase 2: UserProfileStore → authProvider
4. ✅ Update `api_client.dart`
5. ✅ Update `user_profile_page.dart`
6. ✅ Update `my_tings_empty_section.dart`
7. ✅ Update `settings_page.dart`
8. ✅ Update `menu_page.dart`

### Phase 3: MyTingsStore → walletNotifierProvider
9. ✅ Update `my_tings_page.dart`
10. ✅ Update `my_tings_list_section.dart`
11. ✅ Update `add_to_my_tings_button.dart`

### Phase 4: ProductTagsStore (Convert Observer)
12. ✅ Update `user_tags_page.dart`
13. ✅ Update `product_tags_section.dart`

### Phase 5: Cleanup
14. ✅ Delete old MobX store files
15. ✅ Run tests → **35/35 passing!**

---

## Expected Test Results

**Before Cleanup:**
```
32 passing
3 failing (MobX/GetIt errors)
```

**After Cleanup:**
```
35 passing ✅
0 failing
```

---

## Risk Assessment

**Low Risk:**
- Riverpod providers already exist and tested
- Changes are mostly find-and-replace
- Backward compatible (GetIt coexists with Riverpod)

**Medium Risk:**
- ApiClient token injection needs careful testing

**Mitigation:**
- Keep GetIt temporarily for non-critical services
- Test incrementally after each phase

---

## Next Steps

1. Start with Phase 1 (quick wins)
2. Run tests after each phase
3. Commit working code incrementally
4. Final cleanup once all tests pass

