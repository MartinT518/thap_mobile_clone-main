# Setup Guide - Thap Mobile App

## Quick Start

This guide covers all setup scenarios for the Thap Mobile App.

---

## Table of Contents

1. [Flutter Installation](#flutter-installation)
2. [Cursor IDE Setup](#cursor-ide-setup)
3. [Replit Setup](#replit-setup)
4. [Running the App](#running-the-app)
5. [Viewing in Phone Layout](#viewing-in-phone-layout)
6. [Troubleshooting](#troubleshooting)

---

## Flutter Installation

### Windows Installation

#### Method 1: Automated Script (Easier)

1. **Run the installation script:**
   ```powershell
   # Open PowerShell as Administrator
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   .\install_flutter.ps1
   ```

2. **Follow the prompts** to download and extract Flutter

#### Method 2: Manual Installation

1. **Download Flutter:**
   - Visit: https://docs.flutter.dev/get-started/install/windows
   - Download Flutter SDK (Stable, ~1.5 GB)

2. **Extract:**
   - Extract ZIP to `C:\src\flutter`
   - Should create: `C:\src\flutter\bin\flutter.bat`

3. **Add to PATH:**
   - Press `Win + R` → type `sysdm.cpl` → Enter
   - Advanced tab → Environment Variables
   - User variables → Path → Edit
   - New → Add: `C:\src\flutter\bin`
   - OK → OK → OK
   - **Restart PowerShell**

4. **Verify:**
   ```powershell
   flutter doctor
   ```

### Post-Installation Setup

1. **Accept Android Licenses (if developing for Android):**
   ```powershell
   flutter doctor --android-licenses
   ```

2. **Install Additional Tools (if needed):**
   - **Android Studio** (for Android development)
   - **Visual Studio** (for Windows desktop development)
   - **VS Code** (optional, recommended editor)

3. **Verify Everything Works:**
   ```powershell
   flutter doctor -v
   flutter --version
   ```

---

## Cursor IDE Setup

### Step 1: Install Flutter Extensions

1. Open Cursor IDE
2. Press `Ctrl + Shift + X` to open Extensions
3. Search for "Flutter" and install "Flutter" by Dart Code
4. The Dart extension will be installed automatically

### Step 2: Configure Flutter SDK

1. Press `Ctrl + Shift + P` to open Command Palette
2. Type: `Flutter: Change SDK`
3. Select your Flutter SDK path (e.g., `C:\src\flutter`)

### Step 3: Verify Setup

1. Press `Ctrl + Shift + P`
2. Type: `Flutter: Run Flutter Doctor`
3. Check for any issues

---

## Replit Setup

### After Pushing to Git

Once you've pushed your code to GitHub/GitLab:

1. **Import Your Repository:**
   - Go to [Replit](https://replit.com)
   - Click "Create Repl" → "Import from GitHub"
   - Select your repository
   - Replit will automatically detect it's a Flutter project

2. **Replit Will Automatically:**
   - ✅ Install Flutter SDK (configured in `.replit` file)
   - ✅ Run `flutter pub get` to install dependencies
   - ✅ Set up the development environment

3. **Run Tests:**
   ```bash
   cd source
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   flutter test
   ```

4. **Build and Run Web App:**
   - The `.replit` file is already configured
   - Just click the "Run" button in Replit!

### Replit Configuration

The `.replit` file includes:
- ✅ Flutter package in nix packages
- ✅ Build workflow for Flutter web
- ✅ Web server on port 5000
- ✅ Static deployment configuration

---

## Running the App

### Step 1: Get Dependencies

```powershell
cd source
flutter pub get
```

### Step 2: Generate Code (MobX)

The app uses MobX for state management. Generate required files:

```powershell
flutter packages pub run build_runner build
```

For continuous generation during development:

```powershell
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

### Step 3: Enable Web Support

```powershell
flutter config --enable-web
```

### Step 4: Run the App

```powershell
# Option 1: Development mode with hot reload
flutter run -d chrome

# Option 2: Build and serve (production-like)
flutter build web
cd build\web
python -m http.server 5000
```

---

## Viewing in Phone Layout

### Method 1: Chrome DevTools (Best)

1. Open app in Chrome (http://localhost:5000 or the port Flutter shows)
2. Press **F12** to open DevTools
3. Press **Ctrl + Shift + M** to toggle Device Toolbar
4. Select a phone model:
   - **iPhone 12 Pro** (390×844) - Recommended
   - **iPhone SE** (375×667)
   - **Galaxy S20** (360×800)
   - **Responsive** (custom size)

### Method 2: Using Flutter DevTools

If using `flutter run -d chrome`:
1. App opens automatically in Chrome
2. Press **F12** → Device Toolbar
3. Select phone dimensions

### Recommended Phone Dimensions

| Device | Width | Height | Aspect Ratio |
|--------|-------|--------|--------------|
| iPhone 14 Pro | 393px | 852px | 19.5:9 |
| iPhone 12 | 390px | 844px | 19.5:9 |
| iPhone SE | 375px | 667px | 16:9 |
| Galaxy S20 | 360px | 800px | 20:9 |
| Pixel 5 | 393px | 851px | 19.5:9 |

---

## Using Flutter Extension in Cursor

### Keyboard Shortcuts:

- **`Ctrl + Shift + P`** → Command Palette
  - `Flutter: Run`
  - `Flutter: Hot Reload`
  - `Flutter: Hot Restart`
  - `Flutter: Open DevTools`

- **`F5`** → Start Debugging
- **`Ctrl + F5`** → Run Without Debugging
- **`Ctrl + S`** → Save & Hot Reload
- **`Shift + F5`** → Stop

### Features:

✨ **Hot Reload** - See changes instantly (< 1 second)  
🐛 **Debugging** - Set breakpoints, inspect variables  
📊 **DevTools** - Widget inspector, performance profiler  
🎨 **Widget Refactoring** - Right-click → Extract Widget  
📦 **Package Management** - Auto-suggests dependencies

---

## Hot Reload & Restart

### Hot Reload (Fast Development!)

1. **Make a code change** in any `.dart` file
2. **Save** the file (`Ctrl + S`)
3. **Go to terminal** where Flutter is running
4. **Press `r`** (lowercase)
5. **See changes instantly!** ⚡ (< 1 second)

### Terminal Commands:

- **`r`** - Hot reload (keeps app state)
- **`R`** - Hot restart (restarts from scratch)
- **`q`** - Quit/stop the app
- **`h`** - Show all commands

### When to Use Hot Restart:

- After modifying `web/index.html` or other configuration files
- After major structural changes
- If hot reload doesn't work

---

## Test Demo Authentication

Once running:

1. **Login Screen appears**
2. **Click "Sign in with Google"**
3. **Wait 1 second** (simulated delay)
4. **Signed in as "Demo User"** (demo@example.com)
5. **Explore the app!**

No real Google account needed - it's all simulated!

---

## Troubleshooting

### "flutter: command not found"
- Restart PowerShell/Terminal
- Run: `$env:PATH -split ';' | Select-String flutter`
- If empty, PATH not set correctly - follow manual steps

### "Chrome not found"
- Install Chrome: https://google.com/chrome
- Or run: `flutter run -d edge` (for Microsoft Edge)

### "No devices found"
```powershell
flutter config --enable-web
flutter devices
```
Should show "Chrome" in the list

### Extensions not working
- Reload Cursor: `Ctrl + Shift + P` → `Developer: Reload Window`
- Check extensions: `Ctrl + Shift + X`

### App not loading in browser
- Check console for errors (F12)
- Try: `flutter clean` then `flutter pub get`
- Rebuild: `flutter build web --release`

### iOS build fails
```bash
cd source/ios
pod install
cd ..
flutter clean
flutter run
```

### Android build fails
```bash
flutter clean
cd source/android
./gradlew clean
cd ..
flutter run
```

### MobX code generation issues
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Dependencies conflicts
```bash
flutter clean
rm source/pubspec.lock
flutter pub get
```

---

## Current Configuration

Your app is configured with:

- ✅ **Demo Mode**: `Env.isDemoMode = true`
- ✅ **Service Locator**: Initialized in `main.dart`
- ✅ **Demo Auth**: Uses `AuthRepositoryDemo`
- ✅ **No Real API**: All data is mocked

---

## Performance Tips

1. **Use Flutter DevTools** to check performance
2. **Hot Reload** instead of full rebuild (saves time)
3. **Profile mode** for performance testing:
   ```powershell
   flutter run --profile -d chrome
   ```
4. **Production build** for final testing:
   ```powershell
   flutter build web --release
   ```

---

## Additional Resources

- **Flutter Docs**: https://docs.flutter.dev/
- **Flutter for Web**: https://docs.flutter.dev/platform-integration/web
- **DevTools**: https://docs.flutter.dev/tools/devtools
- **Project README**: See `README.md` for project overview

---

## Quick Commands Reference

```powershell
# Check Flutter
flutter doctor -v
flutter --version

# Project Setup
cd source
flutter pub get
flutter config --enable-web

# Run Development
flutter run -d chrome
flutter run -d edge

# Build Production
flutter build web
flutter build web --release

# Clean & Rebuild
flutter clean
flutter pub get
flutter build web

# Check Devices
flutter devices

# Generate Code
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

---

## You're Ready!

Once Flutter is installed:
1. Run `flutter pub get` in the `source` folder
2. Run `flutter run -d chrome`
3. Press F12 and switch to mobile view
4. Click "Sign in with Google"
5. Enjoy your demo app!

Happy coding! 🚀

