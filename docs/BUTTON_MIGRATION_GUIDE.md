# Button Migration Guide

## Overview

This guide documents the migration from legacy `MainButton` and `LightButton` to Design System compliant buttons.

## Migration Status

### ✅ Completed Files
1. `source/lib/ui/pages/ai_chat_page.dart` - MainButton → ElevatedButton + primaryButton()
2. `source/lib/ui/pages/settings_page.dart` - MainButton → ElevatedButton + primaryButton()

### 🔄 Files Requiring Migration (18 remaining)

**AI Pages:**
- `source/lib/ui/pages/ai_settings_page.dart` (1 MainButton)

**Product Pages:**
- `source/lib/ui/pages/product/product_page.dart`
- `source/lib/ui/pages/product/share_buttons_section.dart`
- `source/lib/ui/pages/product/set_product_info_section.dart`
- `source/lib/ui/pages/product/product_form_page.dart`
- `source/lib/ui/pages/product/producer_feedback_section.dart`
- `source/lib/ui/pages/product/add_receipt_section.dart`
- `source/lib/ui/pages/product/add_product_image.dart`

**Auth Pages:**
- `source/lib/ui/pages/login/register_page.dart`

**User/Profile Pages:**
- `source/lib/ui/pages/my_tings/my_tings_empty_section.dart`
- `source/lib/ui/pages/user_tags_page.dart`
- `source/lib/ui/pages/user_profile_page.dart`

**Common Components:**
- `source/lib/ui/common/tings_internal_browser.dart`
- `source/lib/ui/common/product_tags_section.dart`
- `source/lib/ui/common/product_file.dart`
- `source/lib/ui/common/address.dart`
- `source/lib/ui/common/add_to_my_tings_button.dart`

## Migration Pattern

### MainButton → ElevatedButton

**Before:**
```dart
import 'package:thap/ui/common/button.dart';

MainButton(
  onTap: () => doSomething(),
  text: 'Click Me',
)
```

**After:**
```dart
import 'package:thap/shared/widgets/design_system_components.dart';

ElevatedButton(
  onPressed: () => doSomething(),
  style: DesignSystemComponents.primaryButton(),
  child: const Text('Click Me'),
)
```

### LightButton → OutlinedButton

**Before:**
```dart
import 'package:thap/ui/common/button.dart';

LightButton(
  onTap: () => doSomething(),
  text: 'Click Me',
)
```

**After:**
```dart
import 'package:thap/shared/widgets/design_system_components.dart';

OutlinedButton(
  onPressed: () => doSomething(),
  style: DesignSystemComponents.secondaryButton(),
  child: const Text('Click Me'),
)
```

### Disabled State

**Before:**
```dart
MainButton(
  onTap: isLoading ? () {} : doSomething,
  text: 'Submit',
)
```

**After:**
```dart
ElevatedButton(
  onPressed: isLoading ? null : doSomething,  // null disables the button
  style: DesignSystemComponents.primaryButton(),
  child: const Text('Submit'),
)
```

### With Icons

**Before:**
```dart
MainButton(
  onTap: () => doSomething(),
  text: 'Share',
  iconName: 'share',
)
```

**After:**
```dart
ElevatedButton.icon(
  onPressed: () => doSomething(),
  style: DesignSystemComponents.primaryButton(),
  icon: const Icon(Icons.share, size: 20),
  label: const Text('Share'),
)
```

## Import Changes

### Remove:
```dart
import 'package:thap/ui/common/button.dart';
```

### Add:
```dart
import 'package:thap/shared/widgets/design_system_components.dart';
```

## Benefits of Migration

1. **Design System Compliance:** Buttons follow Design System v2.0 specifications
2. **Consistency:** All buttons use the same styling
3. **Accessibility:** Better disabled state handling
4. **Maintainability:** Centralized button styling in DesignSystemComponents
5. **Performance:** No custom widget overhead

## Testing Checklist

After migration, test:
- [ ] Button appears with correct styling (blue, pill shape, 48px height)
- [ ] onPressed callback works correctly
- [ ] Disabled state (null onPressed) shows gray background
- [ ] Button text is centered
- [ ] Button respects minimum tap target (48px)
- [ ] Button works on both light and dark themes

## Next Steps

1. Complete migration of remaining 18 files
2. Run tests to ensure no regressions
3. Update UI tests if necessary
4. Remove deprecated `MainButton` and `LightButton` classes
5. Remove `source/lib/ui/common/button.dart` file

## Timeline

- **Target Completion:** Next commit
- **Estimated Effort:** 1-2 hours
- **Priority:** Medium (functional but improves code quality)

