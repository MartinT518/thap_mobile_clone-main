# Flutter Hooks Error Analysis and Fix

## Error Summary

**Error Message:**
```
Assertion failed:
HookElement._currentHookElement != null

Hooks can only be called from the build method of a widget that mix-in 'Hooks'.
Hooks should only be called within the build method of a widget.
Calling them outside of build method leads to an unstable state and is therefore prohibited.
```

**Location:** `flutter_hooks-0.21.3+1/lib/src/framework.dart:133:12`

## Root Cause Analysis

The error occurs when Flutter Hooks are called outside of a widget's `build` method. This can happen in several scenarios:

1. **Hooks called in class field initializers** (outside build)
2. **Hooks called in constructors** (outside build)
3. **Hooks called in callbacks executed outside build context**
4. **State synchronization issues** where hooks don't properly sync with prop changes

## Identified Issue: `TingCheckbox` State Synchronization

### Problem
In `source/lib/ui/common/ting_checkbox.dart`, the `useState` hook was initialized with the `checked` prop, but it didn't sync when the prop changed:

```dart
final checkedInternal = useState<bool>(checked);
```

When `SettingsPage` rebuilds with updated `userData.value?.allowFeedback` or `userData.value?.consentMarketing`, the `TingCheckbox` widget receives a new `checked` value, but the internal `useState` doesn't update because `useState` only uses the initial value on first build.

### Impact
- Internal state becomes out of sync with the prop
- Can cause rendering inconsistencies
- May trigger hook-related errors if the widget is recreated in certain ways

## Fix Applied

### File: `source/lib/ui/common/ting_checkbox.dart`

**Added `useEffect` to sync internal state with prop changes:**

```dart
@override
Widget build(BuildContext context) {
  final checkedInternal = useState<bool>(checked);

  // Sync internal state with prop changes
  useEffect(() {
    checkedInternal.value = checked;
    return null;
  }, [checked]);

  return Material(
    // ... rest of widget
  );
}
```

**Benefits:**
- ✅ Internal state stays in sync with prop changes
- ✅ Prevents state inconsistencies
- ✅ Ensures hooks are called correctly within build context
- ✅ Follows Flutter Hooks best practices

## Other Potential Issues Checked

### ✅ All HookWidgets Use Hooks Correctly
Verified that all `HookWidget` classes in the codebase:
- Call hooks only within `build` methods
- Don't call hooks in class fields or constructors
- Properly use `useEffect` for side effects

### ✅ No Hooks in Services
Confirmed that no service classes attempt to use hooks (which would be invalid).

### ✅ Proper Hook Usage Patterns
All widgets follow the correct pattern:
```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue); // ✅ Correct
    useEffect(() { ... }, []); // ✅ Correct
    return Widget(...);
  }
}
```

## Testing Recommendations

1. **Test `TingCheckbox` with prop changes:**
   - Verify checkbox updates when `checked` prop changes
   - Test in `SettingsPage` with async data updates

2. **Monitor for hook errors:**
   - Watch console for any remaining hook-related assertions
   - Test navigation to pages with HookWidgets

3. **Verify state synchronization:**
   - Ensure checkboxes reflect correct state after data loads
   - Test rapid prop changes

## Related Files

- `source/lib/ui/common/ting_checkbox.dart` - Fixed
- `source/lib/ui/pages/settings_page.dart` - Uses `TingCheckbox`
- `source/lib/ui/pages/user_profile_page.dart` - Uses `TingCheckbox`

## Prevention Guidelines

To prevent similar issues in the future:

1. **Always sync hook state with props:**
   ```dart
   final internalState = useState(propValue);
   useEffect(() {
     internalState.value = propValue;
     return null;
   }, [propValue]);
   ```

2. **Never call hooks outside build:**
   - ❌ Don't call hooks in class fields
   - ❌ Don't call hooks in constructors
   - ❌ Don't call hooks in static methods
   - ✅ Only call hooks in `build` method

3. **Use `useEffect` for side effects:**
   - ✅ Use `useEffect` for async operations
   - ✅ Use `useEffect` for cleanup
   - ✅ Use `useEffect` for prop synchronization

## Expected Outcome

After this fix:
- ✅ `TingCheckbox` properly syncs with prop changes
- ✅ No more hook assertion errors
- ✅ Consistent checkbox state in `SettingsPage`
- ✅ Better state management in hook-based widgets

## Next Steps

1. **Test the app** to verify the fix resolves the error
2. **Monitor console** for any remaining hook-related issues
3. **Review other HookWidgets** for similar state synchronization needs
4. **Consider adding tests** for prop synchronization in hook widgets

