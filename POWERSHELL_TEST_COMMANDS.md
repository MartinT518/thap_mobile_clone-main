# Running Flutter Tests in PowerShell

## ✅ Correct PowerShell Commands

### Single Test File
```powershell
cd source
flutter test test/widget/settings_page_test.dart --no-pub
```

### All Widget Tests
```powershell
cd source
flutter test test/widget/ --no-pub
```

### All Tests
```powershell
cd source
flutter test --no-pub
```

### With Coverage
```powershell
cd source
flutter test --coverage --no-pub
```

---

## ❌ Common PowerShell Mistakes

### Wrong: Using `&&` (Bash syntax)
```powershell
cd source && flutter test --no-pub  # ❌ Doesn't work in PowerShell
```

### Correct: Using `;` (PowerShell syntax)
```powershell
cd source; flutter test --no-pub  # ✅ Works in PowerShell
```

### Better: Separate Commands
```powershell
cd source
flutter test --no-pub  # ✅ Most reliable
```

---

## If Flutter Command Not Found

If you get: `The term 'flutter' is not recognized`

### Option 1: Use Full Path
```powershell
cd source
C:\Users\mtamm\flutter\bin\flutter test --no-pub
```

### Option 2: Add Flutter to PATH (Permanent Fix)

1. **Find Flutter Path:**
   ```powershell
   # Usually: C:\Users\<username>\flutter\bin
   # Or: C:\src\flutter\bin
   ```

2. **Add to PATH:**
   - Open System Properties → Environment Variables
   - Edit "Path" variable
   - Add: `C:\Users\mtamm\flutter\bin`
   - Restart PowerShell

3. **Verify:**
   ```powershell
   flutter --version
   ```

### Option 3: Use Flutter in Current Session Only
```powershell
$env:Path += ";C:\Users\mtamm\flutter\bin"
cd source
flutter test --no-pub
```

---

## Recommended Workflow

### Step 1: Navigate to Source Directory
```powershell
cd C:\Users\mtamm\Documents\thap_mobile_clone-main\source
```

### Step 2: Run Tests
```powershell
# Single test file
flutter test test/widget/settings_page_test.dart --no-pub

# Or all tests
flutter test --no-pub
```

### Step 3: Check Results
- ✅ Green = Tests passed
- ❌ Red = Tests failed (check output for details)

---

## Quick Reference

| What You Want | PowerShell Command |
|---------------|-------------------|
| Run all tests | `cd source; flutter test --no-pub` |
| Run widget tests | `cd source; flutter test test/widget/ --no-pub` |
| Run single test | `cd source; flutter test test/widget/settings_page_test.dart --no-pub` |
| With coverage | `cd source; flutter test --coverage --no-pub` |
| Verbose output | `cd source; flutter test --no-pub -v` |

---

## Why `--no-pub`?

The `--no-pub` flag tells Flutter:
- **Don't run `flutter pub get`** before tests
- **Faster execution** (skips dependency check)
- **Useful when** dependencies are already installed

**You can omit it** if you want Flutter to check dependencies:
```powershell
cd source
flutter test  # Without --no-pub
```

---

## Summary

✅ **Keep using** `flutter test --no-pub` in PowerShell  
✅ **Use `;`** instead of `&&` for command chaining  
✅ **Navigate to `source`** directory first  
✅ **Command is correct** - just PowerShell syntax is different

