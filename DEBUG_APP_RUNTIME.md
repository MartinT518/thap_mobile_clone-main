# Debug App Runtime - Check Console Errors

## Quick Start

### Step 1: Check Available Devices
```powershell
cd source
flutter devices
```

### Step 2: Run App in Debug Mode
```powershell
cd source
flutter run --debug
```

Or if you have a specific device:
```powershell
cd source
flutter run -d <device-id> --debug
```

### Step 3: Navigate to Settings Page

Once the app is running:
1. Navigate to the Settings page (where `AppHeaderBar` is used)
2. Watch the console/terminal for errors
3. Check if the header renders correctly visually

---

## What to Look For

### Console Errors to Watch For:

1. **Layout Errors:**
   ```
   RenderBox was not laid out
   BoxConstraints violation
   ```

2. **AppHeaderBar Specific:**
   ```
   AppHeaderBar layout issues
   PreferredSizeWidget errors
   ```

3. **SafeArea Issues:**
   ```
   SafeArea padding conflicts
   ```

4. **General Flutter Errors:**
   ```
   Exception caught by rendering library
   Exception caught by widgets library
   ```

---

## Alternative: Run with Verbose Logging

```powershell
cd source
flutter run --debug -v
```

The `-v` flag provides verbose output with more detailed error information.

---

## Quick Navigation Test

If the app has a navigation menu, try:
1. Open Settings page
2. Check if header renders
3. Try navigating back
4. Check console for any errors during navigation

---

## If App Crashes on Startup

If the app doesn't start, check:
1. **Service Locator Errors:**
   ```
   Service not registered
   ```

2. **Localization Errors:**
   ```
   EasyLocalization errors
   Translation key not found
   ```

3. **Dependency Errors:**
   ```powershell
   cd source
   flutter pub get
   ```

---

## Compare: Test vs Runtime

After running the app:
- ✅ **If app runs fine:** The issue is test environment specific
- ❌ **If app has errors:** The issue is in the actual code

This will help us determine if:
- The fix is correct but tests need adjustment
- OR the fix itself needs refinement

