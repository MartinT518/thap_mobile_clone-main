# Thap Mobile App

A Flutter-based mobile application with multi-language support, QR code scanning, and comprehensive mobile features.

## Overview

Thap is a cross-platform mobile application built with Flutter, supporting both iOS and Android. The app features:

- Multi-language support (14 languages: EN, ET, SV, LT, LV, DE, FI, FR, ES, IT, DA, NL, PT, PL, RU)
- QR code generation and scanning
- Image and file management
- Google Sign-In integration
- PDF viewing capabilities
- In-app web views
- MobX state management

## Prerequisites

### Required Tools

- **Flutter SDK**: 3.7.2 or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Included with Flutter
- **Git**: For version control

### Platform-Specific Requirements

#### iOS Development
- **macOS**: Required for iOS development
- **Xcode**: 16.0 or higher ([Download from Mac App Store](https://apps.apple.com/us/app/xcode/id497799835))
- **CocoaPods**: Installed automatically with Flutter
- **iOS Simulator**: Included with Xcode

#### Android Development
- **Android Studio**: Arctic Fox or higher ([Download](https://developer.android.com/studio))
- **Android SDK**: API Level 21 (Android 5.0) or higher (latest recommended)
- **Android Emulator**: Available through Android Studio

### Recommended IDEs
- **Visual Studio Code** with Flutter extension
- **Android Studio** with Flutter and Dart plugins
- **IntelliJ IDEA** with Flutter plugin

## Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd tings_mobileclient
```

### 2. Install Dependencies

Navigate to the source directory and get packages:

```bash
cd source
flutter pub get
```

### 3. Generate Code (MobX)

The app uses MobX for state management. Generate required files:

```bash
flutter packages pub run build_runner build
```

For continuous generation during development:

```bash
flutter packages pub run build_runner watch
```

### 4. Generate App Icons (Optional)

If icons need to be regenerated:

```bash
dart run flutter_launcher_icons
```

## Running the App

### Quick Start

From the `source/` directory:

```bash
# List available devices
flutter devices

# Run on connected device or emulator
flutter run

# Run in debug mode (default)
flutter run --debug

# Run in release mode
flutter run --release
```

### Platform-Specific Commands

#### Run on iOS

```bash
# Run on iOS simulator
flutter run -d ios

# Run on specific iOS simulator
flutter run -d "iPhone 15 Pro"

# Run on physical iOS device
flutter run -d <device-id>
```

#### Run on Android

```bash
# Run on Android emulator
flutter run -d android

# Run on specific Android device
flutter run -d <device-id>
```

## Debugging

### Visual Studio Code

1. Open the `source/` folder in VS Code
2. Install the Flutter extension
3. Press `F5` or go to Run > Start Debugging
4. Select your target device from the bottom-right status bar

**Useful VS Code Commands:**
- `Cmd/Ctrl + Shift + P` → "Flutter: Select Device"
- `Cmd/Ctrl + Shift + P` → "Flutter: Hot Reload"
- `Cmd/Ctrl + Shift + P` → "Flutter: Hot Restart"

### Android Studio

1. Open the `source/` folder in Android Studio
2. Wait for Gradle sync to complete
3. Select your target device from the device dropdown
4. Click the Run button (green play icon) or Debug button (bug icon)

### Hot Reload

While the app is running:
- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `v` to open DevTools
- Press `q` to quit

## Emulators and Simulators

### iOS Simulator

#### Setup

1. Install Xcode from the Mac App Store
2. Open Xcode and install additional components if prompted
3. Agree to license: `sudo xcodebuild -license accept`
4. Install simulator: `xcodebuild -downloadPlatform iOS`

#### List Available Simulators

```bash
xcrun simctl list devices
```

#### Launch Simulator

```bash
# Open default simulator
open -a Simulator

# Launch specific device
xcrun simctl boot "iPhone 15 Pro"
open -a Simulator
```

#### Create New Simulator

1. Open Xcode
2. Go to Window > Devices and Simulators
3. Click the `+` button in the Simulators tab
4. Select device type and iOS version

### Android Emulator

#### Setup

1. Open Android Studio
2. Go to Tools > Device Manager (or AVD Manager)
3. Click "Create Device"
4. Select a device definition (e.g., Pixel 7)
5. Download a system image (recommended: latest stable release)
6. Configure AVD settings (RAM, storage, etc.)
7. Click Finish

#### List Available Emulators

```bash
flutter emulators
```

Or:

```bash
emulator -list-avds
```

#### Launch Emulator

```bash
# Using Flutter
flutter emulators --launch <emulator-id>

# Using Android SDK directly
emulator -avd <emulator-name>
```

#### Run on Emulator

```bash
# Start emulator and run app
flutter emulators --launch <emulator-id>
flutter run
```


## Building for Release

### iOS

#### Prerequisites
- Valid Apple Developer account
- Certificates and provisioning profiles configured in Xcode

#### Build

```bash
# Build IPA
flutter build ipa
```

### Android

#### Build APK

```bash
# Build APK
flutter build apk --release

# Build APK for specific ABI
flutter build apk --release --split-per-abi
```

Built files location:
- APK: `source/build/app/outputs/flutter-apk/app-release.apk`

## Common Commands

```bash
# Clean build artifacts
flutter clean

# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Check Flutter installation
flutter doctor

# View connected devices
flutter devices

# Generate MobX code
flutter packages pub run build_runner build

# Watch and auto-generate MobX code
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## Project Structure

```
tings_mobileclient/
├── source/              # Main Flutter project
│   ├── lib/            # Dart source code
│   ├── android/        # Android-specific code
│   ├── ios/            # iOS-specific code
│   ├── assets/         # Images, icons, translations
│   └── pubspec.yaml    # Dependencies
└── README.md           # This file
```

## Troubleshooting

### Common Issues

#### "Flutter command not found"
Ensure Flutter is in your PATH:
```bash
export PATH="$PATH:`pwd`/flutter/bin"
```

#### iOS build fails
```bash
cd source/ios
pod install
cd ..
flutter clean
flutter run
```

#### Android build fails
```bash
flutter clean
cd source/android
./gradlew clean
cd ..
flutter run
```

#### MobX code generation issues
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### "No devices found"
- **iOS**: Launch simulator manually or check Xcode installation
- **Android**: Start emulator or enable USB debugging on physical device

#### Platform SDK version issues
Update SDK versions in:
- Android: `source/android/app/build.gradle.kts` (compileSdkVersion, minSdkVersion, targetSdkVersion)
- iOS: Xcode project settings

#### Dependencies conflicts
```bash
flutter clean
rm source/pubspec.lock
flutter pub get
```

### Get Help

Run Flutter doctor to diagnose issues:

```bash
flutter doctor -v
```

## Tips

- After major Flutter or platform upgrades, consider creating a new Flutter project and migrating files over
- Use `flutter clean` before builds if experiencing cache issues
- Compare changes with git when upgrading platforms
- For translations, update `CFBundleLocalizations` in iOS Info.plist and ensure `assets/translations/` contains all language files
- Keep `build_runner` watching during active development for automatic code generation


---

For more information, visit [Flutter Documentation](https://docs.flutter.dev/).
