# Thap Mobile App - Replit Setup

## Project Overview

Thap is a Flutter-based mobile application that has been configured to run as a web application in the Replit environment. The app features multi-language support, QR code scanning capabilities, image management, Google Sign-In integration, and comprehensive mobile features.

**Original Platform:** iOS and Android mobile app  
**Replit Configuration:** Flutter Web (Release Build)  
**Primary Language:** Dart 3.8  
**Framework:** Flutter 3.32.0

## Project Structure

```
/
├── source/              # Main Flutter application directory
│   ├── lib/            # Dart source code
│   │   ├── data/       # Data models and repositories
│   │   ├── models/     # Data models
│   │   ├── services/   # Service layer (API, navigation, etc.)
│   │   ├── stores/     # MobX state management stores
│   │   ├── ui/         # User interface components
│   │   └── main.dart   # Application entry point
│   ├── assets/         # Images, fonts, translations, icons
│   ├── build/web/      # Compiled web application (served to users)
│   ├── android/        # Android platform-specific code (not used in web)
│   ├── ios/            # iOS platform-specific code (not used in web)
│   ├── web/            # Web platform configuration
│   └── pubspec.yaml    # Flutter dependencies configuration
├── docs/               # Documentation
└── README.md           # Original project documentation
```

## Technologies Used

- **Flutter 3.32.0**: Cross-platform UI framework
- **Dart 3.8**: Programming language
- **MobX**: State management library
- **Easy Localization**: Multi-language support (14 languages)
- **Material Design**: UI design system

### Key Dependencies

- **State Management:** MobX, Flutter MobX
- **HTTP/API:** Dio, HTTP
- **UI Components:** Flutter SVG, Pretty QR Code, Cached Network Image
- **Authentication:** Google Sign-In
- **Mobile Features:** Mobile Scanner, Image Picker, File Picker
- **Web Views:** Flutter InAppWebView, WebView Flutter
- **PDF Support:** PDFx
- **Storage:** Shared Preferences

## Replit Configuration

### Development Workflow

The app runs in **production/release mode** to ensure compatibility with the Replit environment:

1. **Build Step:** `flutter build web --release` - Compiles the Flutter app to optimized JavaScript
2. **Serve Step:** `dhttpd --host=0.0.0.0 --port=5000` - Serves the compiled web app on port 5000

### Why Release Mode?

Flutter's debug mode web server had compatibility issues with Replit's iframe-based preview system. Building in release mode and serving static files provides:
- Better stability
- Faster load times
- Smaller bundle size
- Better browser compatibility

## Backend API

The app connects to a test API:
- **API URL:** `https://tingsapi.test.mindworks.ee/api`
- **Timeout:** 60 seconds
- **Configuration:** `source/lib/configuration.dart`

## Known Limitations

Since this is a mobile app ported to web, some features may have limited functionality:

1. **Mobile-specific features** (camera, vibration, native permissions) may not work in web browsers
2. **Google Sign-In** requires proper web configuration
3. Some **device-specific APIs** may throw errors in the browser console
4. The app was designed for portrait mobile screens, so the web layout may not be optimal for desktop

## Development Commands

### Build the Web App

```bash
cd source
flutter build web --release
```

### Run Local Development Server (Debug Mode)

```bash
cd source
flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0
```

Note: Debug mode may have compatibility issues. Use release build for production.

### Install Dependencies

```bash
cd source
flutter pub get
```

### Generate MobX Code

When modifying MobX stores, regenerate code:

```bash
cd source
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Clean Build Artifacts

```bash
cd source
flutter clean
```

## Deployment

The app is configured to deploy as a **static site** on Replit:

- **Build Command:** `cd source && flutter build web --release`
- **Public Directory:** `source/build/web`
- **Deployment Type:** Static

The deployment will automatically build the Flutter web app and serve the static files.

## Supported Languages

The app supports 14 languages:
- English (en) - Default
- Estonian (et)
- Swedish (sv)
- Lithuanian (lt)
- Latvian (lv)
- German (de)
- Finnish (fi)
- French (fr)
- Spanish (es)
- Italian (it)
- Danish (da)
- Dutch (nl)
- Portuguese (pt)
- Polish (pl)
- Russian (ru)

Translation files are located in `source/assets/translations/`

## Recent Changes

### 2025-11-18: Initial Replit Setup

- Installed Dart 3.8 and Flutter 3.32.0
- Enabled Flutter web support and created web directory
- Updated SDK constraint to ^3.8.0 in pubspec.yaml
- Installed all Flutter dependencies
- Generated MobX code using build_runner
- Built Flutter web app in release mode
- Configured workflow to serve on port 5000 using dhttpd
- Set up static deployment configuration
- Created project documentation

## Troubleshooting

### App shows blank white screen

This typically means the app is still loading. Check:
1. Browser console for JavaScript errors
2. Workflow logs to ensure the server is running
3. Network tab to verify assets are loading

### Runtime errors in browser console

The app may encounter runtime errors due to:
- Missing backend API responses
- Mobile-specific features not available in web browsers
- Missing environment configuration

These are expected for a mobile app running in a web environment.

### Build errors

If you encounter build errors:

```bash
cd source
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter build web --release
```

## User Preferences

None configured yet.

## Architecture Notes

- **State Management:** Uses MobX for reactive state management
- **Navigation:** Custom navigation service using GetIt for dependency injection
- **API Layer:** Dio for HTTP requests with logging
- **Localization:** EasyLocalization package with JSON translation files
- **UI Architecture:** Component-based architecture with reusable widgets

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [MobX Documentation](https://mobx.netlify.app/)
- Original README: `README.md`
