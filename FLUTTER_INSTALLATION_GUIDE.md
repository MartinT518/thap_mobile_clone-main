# Flutter SDK Installation Guide for Windows

## Quick Installation Steps

### Method 1: Download ZIP (Recommended)

1. **Download Flutter SDK**

   - Visit: https://docs.flutter.dev/get-started/install/windows
   - Download the latest stable release ZIP file
   - File size: ~1.5 GB

2. **Extract Flutter**

   - Extract the ZIP to a location like:
     - `C:\src\flutter` (recommended)
     - Or `C:\flutter`
   - ⚠️ **Important**: Do NOT install in:
     - `C:\Program Files\` (requires admin permissions)
     - Folders with spaces or special characters

3. **Add Flutter to PATH**

   - Press `Win + R`, type `sysdm.cpl`, press Enter
   - Go to "Advanced" tab → Click "Environment Variables"
   - Under "User variables", find "Path" and click "Edit"
   - Click "New" and add: `C:\src\flutter\bin` (or your Flutter path)
   - Click "OK" on all dialogs
   - **Restart your terminal/PowerShell** for changes to take effect

4. **Verify Installation**
   ```powershell
   flutter doctor
   ```
   This will check your setup and show what else might be needed.

### Method 2: Using Git

If you have Git installed:

```powershell
cd C:\src
git clone https://github.com/flutter/flutter.git -b stable
```

Then add to PATH as described in Method 1, Step 3.

## Post-Installation Setup

### 1. Accept Android Licenses (if developing for Android)

```powershell
flutter doctor --android-licenses
```

### 2. Install Additional Tools (if needed)

Flutter Doctor will tell you what's missing. Common requirements:

- **Android Studio** (for Android development)

  - Download: https://developer.android.com/studio
  - Install Android SDK, Android SDK Platform-Tools

- **Visual Studio** (for Windows desktop development)

  - Download: https://visualstudio.microsoft.com/downloads/
  - Install "Desktop development with C++" workload

- **VS Code** (optional, recommended editor)
  - Download: https://code.visualstudio.com/
  - Install Flutter extension

### 3. Verify Everything Works

```powershell
# Check Flutter installation
flutter doctor -v

# Check Flutter version
flutter --version

# Test in your project
cd C:\Users\mtamm\Documents\thap_mobile_clone-main\source
flutter pub get
flutter test
```

## Troubleshooting

### Flutter command not found

- Make sure you added Flutter to PATH correctly
- Restart your terminal/PowerShell
- Try: `refreshenv` (if using Chocolatey) or restart your computer

### PATH not working

- Verify the path: `echo $env:PATH` (PowerShell) or `echo %PATH%` (CMD)
- Make sure the path points to `flutter\bin` folder
- Check for typos in the path

### Git not found (if using Method 2)

- Install Git: https://git-scm.com/download/win
- Or use Method 1 (ZIP download) instead

### Firewall/Antivirus Issues

- Some antivirus software may block Flutter
- Add Flutter folder to antivirus exclusions if needed

## Quick Test

After installation, test with your project:

```powershell
cd C:\Users\mtamm\Documents\thap_mobile_clone-main\source
flutter pub get
flutter doctor
flutter test
```

## Additional Resources

- Official Flutter Docs: https://docs.flutter.dev/
- Flutter Installation: https://docs.flutter.dev/get-started/install/windows
- Flutter Community: https://flutter.dev/community
