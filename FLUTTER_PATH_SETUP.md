# Flutter PATH Setup Guide
## Adding Flutter to Windows PATH

This guide shows you how to add Flutter to your system PATH so you can run `flutter` commands from anywhere.

---

## Method 1: Find Flutter Installation Location

First, let's find where Flutter is installed on your system:

### Option A: Check Common Locations

Flutter is typically installed in one of these locations:

1. **User AppData (Most Common):**
   ```
   C:\Users\<YourUsername>\AppData\Local\flutter
   ```

2. **Program Files:**
   ```
   C:\Program Files\flutter
   ```

3. **Custom Location:**
   - Check where you extracted Flutter when you installed it

### Option B: Search for Flutter

**Using PowerShell:**
```powershell
# Search for flutter.exe
Get-ChildItem -Path C:\Users\$env:USERNAME -Filter "flutter.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty DirectoryName
```

**Using File Explorer:**
1. Open File Explorer
2. Navigate to `C:\Users\<YourUsername>\AppData\Local`
3. Look for a `flutter` folder

---

## Method 2: Add Flutter to PATH (Permanent - Recommended)

### Step 1: Find Flutter Bin Directory

Once you find Flutter, note the path to the `bin` folder:
```
C:\Users\<YourUsername>\AppData\Local\flutter\bin
```

### Step 2: Add to System PATH

**Using GUI (Easiest):**

1. **Open System Properties:**
   - Press `Win + R`
   - Type: `sysdm.cpl`
   - Press Enter

2. **Go to Environment Variables:**
   - Click "Advanced" tab
   - Click "Environment Variables" button

3. **Edit PATH:**
   - Under "User variables" (or "System variables"), find `Path`
   - Click "Edit"
   - Click "New"
   - Add: `C:\Users\<YourUsername>\AppData\Local\flutter\bin`
   - Click "OK" on all dialogs

4. **Restart Terminal:**
   - Close all PowerShell/Command Prompt windows
   - Open a new terminal
   - Test with: `flutter --version`

**Using PowerShell (Admin):**

```powershell
# Run PowerShell as Administrator, then:
$flutterPath = "C:\Users\$env:USERNAME\AppData\Local\flutter\bin"
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$flutterPath", [EnvironmentVariableTarget]::User)
```

**Using Command Prompt (Admin):**

```cmd
setx PATH "%PATH%;C:\Users\%USERNAME%\AppData\Local\flutter\bin"
```

---

## Method 3: Add Flutter to PATH (Temporary - Current Session Only)

If you just need Flutter for the current terminal session:

**PowerShell:**
```powershell
# Find Flutter automatically
$flutterPath = Get-ChildItem -Path "$env:LOCALAPPDATA" -Filter "flutter" -Recurse -Directory -ErrorAction SilentlyContinue | Select-Object -First 1
if ($flutterPath) {
    $flutterBin = Join-Path $flutterPath.FullName "bin"
    $env:Path += ";$flutterBin"
    Write-Host "Flutter added to PATH: $flutterBin" -ForegroundColor Green
} else {
    Write-Host "Flutter not found. Please install Flutter first." -ForegroundColor Red
}

# Verify
flutter --version
```

**Command Prompt:**
```cmd
set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\flutter\bin
```

---

## Method 4: Create a PowerShell Profile Script (Recommended for Development)

This automatically adds Flutter to PATH every time you open PowerShell:

1. **Check if profile exists:**
   ```powershell
   Test-Path $PROFILE
   ```

2. **Create profile if it doesn't exist:**
   ```powershell
   if (!(Test-Path $PROFILE)) {
       New-Item -ItemType File -Path $PROFILE -Force
   }
   ```

3. **Add Flutter to profile:**
   ```powershell
   # Open profile in notepad
   notepad $PROFILE
   ```

4. **Add this to the file:**
   ```powershell
   # Add Flutter to PATH
   $flutterPath = "$env:LOCALAPPDATA\flutter\bin"
   if (Test-Path $flutterPath) {
       $env:Path += ";$flutterPath"
   }
   ```

5. **Save and close Notepad**

6. **Reload profile:**
   ```powershell
   . $PROFILE
   ```

---

## Verification

After adding Flutter to PATH, verify it works:

```powershell
# Check Flutter version
flutter --version

# Check Flutter doctor
flutter doctor

# Check if Flutter is in PATH
$env:Path -split ';' | Select-String flutter
```

**Expected Output:**
```
Flutter 3.x.x • channel stable • ...
Framework • revision ...
Engine • revision ...
Tools • Dart 3.x.x • DevTools 2.x.x
```

---

## Troubleshooting

### Issue: "flutter: command not found"

**Solutions:**
1. Make sure you added the correct path (should end with `\bin`)
2. Restart your terminal after adding to PATH
3. Check if Flutter is actually installed:
   ```powershell
   Test-Path "$env:LOCALAPPDATA\flutter\bin\flutter.exe"
   ```

### Issue: "Flutter not found in common locations"

**Solution:** Install Flutter first:
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows
2. Extract to a location (e.g., `C:\Users\<YourUsername>\AppData\Local\flutter`)
3. Then follow Method 2 above

### Issue: "Permission denied" when adding to PATH

**Solution:** Run PowerShell/Command Prompt as Administrator

---

## Quick Setup Script

Save this as `setup_flutter_path.ps1` and run it:

```powershell
# Flutter PATH Setup Script
Write-Host "Setting up Flutter PATH..." -ForegroundColor Cyan

# Find Flutter
$flutterPath = Get-ChildItem -Path "$env:LOCALAPPDATA" -Filter "flutter" -Recurse -Directory -ErrorAction SilentlyContinue | Select-Object -First 1

if ($flutterPath) {
    $flutterBin = Join-Path $flutterPath.FullName "bin"
    Write-Host "Found Flutter at: $flutterBin" -ForegroundColor Green
    
    # Check if already in PATH
    if ($env:Path -notlike "*$flutterBin*") {
        # Add to current session
        $env:Path += ";$flutterBin"
        Write-Host "Added Flutter to current session PATH" -ForegroundColor Green
        
        # Add to user PATH permanently
        $currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)
        if ($currentPath -notlike "*$flutterBin*") {
            [Environment]::SetEnvironmentVariable("Path", "$currentPath;$flutterBin", [EnvironmentVariableTarget]::User)
            Write-Host "Added Flutter to permanent PATH" -ForegroundColor Green
        } else {
            Write-Host "Flutter already in permanent PATH" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Flutter already in PATH" -ForegroundColor Yellow
    }
    
    # Verify
    Write-Host "`nVerifying Flutter installation..." -ForegroundColor Cyan
    flutter --version
} else {
    Write-Host "Flutter not found. Please install Flutter first." -ForegroundColor Red
    Write-Host "Download from: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor Yellow
}
```

**To run:**
```powershell
.\setup_flutter_path.ps1
```

---

## Summary

**Quickest Method (Permanent):**
1. Find Flutter: `C:\Users\<YourUsername>\AppData\Local\flutter\bin`
2. Add to PATH via System Properties (Win + R → `sysdm.cpl` → Environment Variables)
3. Restart terminal
4. Verify: `flutter --version`

**Quickest Method (Temporary):**
```powershell
$env:Path += ";$env:LOCALAPPDATA\flutter\bin"
flutter --version
```

---

**Status:** ✅ Ready to use after setup

