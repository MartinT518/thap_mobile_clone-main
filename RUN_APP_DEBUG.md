# Run App to Debug Console Errors

## Step-by-Step Guide

### Option 1: Using Flutter Command (if in PATH)

```powershell
# Navigate to source directory (you're already in root)
cd source

# Check available devices
flutter devices

# Run app in debug mode (shows console errors)
flutter run --debug
```

### Option 2: Using Full Flutter Path

If `flutter` command is not recognized:

```powershell
# Navigate to source
cd source

# Use full path to flutter
C:\Users\mtamm\flutter\bin\flutter devices

# Run app
C:\Users\mtamm\flutter\bin\flutter run --debug
```

### Option 3: Using VS Code (Easiest)

1. Open the `source` folder in VS Code
2. Press `F5` or click "Run and Debug"
3. Select "Flutter" from the debugger dropdown
4. Console will show in the Debug Console panel

---

## What to Do Once App is Running

### 1. Navigate to Settings Page
- Look for Settings in the app menu
- Or navigate directly if you know the route

### 2. Watch Console Output
Look for these errors:
- `RenderBox was not laid out`
- `BoxConstraints violation`
- `AppHeaderBar` related errors
- Any red error messages

### 3. Visual Check
- Does the header bar render?
- Is it the correct height?
- Are there any visual glitches?

---

## Expected Console Output

### If AppHeaderBar is Working:
```
✅ No layout errors
✅ Header renders correctly
✅ No console errors
```

### If AppHeaderBar Has Issues:
```
❌ RenderBox was not laid out: ...
❌ BoxConstraints violation
❌ Exception in rendering
```

---

## Quick Test: Navigate to Settings

Once app is running, try to:
1. Open Settings page
2. Check console for errors
3. Take note of any error messages
4. Share the console output

---

## Alternative: Run with Verbose Logging

For even more detailed output:

```powershell
cd source
C:\Users\mtamm\flutter\bin\flutter run --debug -v
```

This will show:
- Detailed widget tree
- Layout constraints
- All rendering operations
- More error context

---

## What This Will Tell Us

**If app runs fine:**
- ✅ Code is correct
- ❌ Test environment needs adjustment
- → We need to fix test setup, not the code

**If app has errors:**
- ❌ Code has issues
- ✅ Tests are correctly catching problems
- → We need to fix the AppHeaderBar code

---

## Next Steps After Running

1. **Share console output** - Copy any errors you see
2. **Note visual behavior** - Does header render?
3. **Check navigation** - Can you navigate to/from Settings?

This will help us determine the exact issue!

