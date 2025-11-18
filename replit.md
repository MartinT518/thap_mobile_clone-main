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

## Ask AI Feature

The app now includes an integrated "Ask AI" feature that allows users to ask questions about products using their preferred AI provider.

### Supported AI Providers

- **OpenAI** (GPT-3.5-turbo)
- **Google Gemini** (gemini-pro)
- **Perplexity** (llama-3.1-sonar-small-128k-online)
- **Deepseek** (deepseek-chat)

### Feature Flow

1. **Settings Configuration:**
   - Navigate to Settings → AI Assistant Settings
   - Select preferred AI provider
   - Enter and validate API key
   - Settings stored in shared_preferences

2. **Product Interaction:**
   - "Ask AI" button appears on product pages (replacing "Buy Here" button)
   - Button is contextual based on ownership status

3. **Question Selection:**
   - **For owned products ("My Things"):**
     - How do I care for this product?
     - What are common issues and solutions?
     - How can I maximize the lifespan?
     - What accessories are compatible?
   - **For scan history (pre-purchase):**
     - Is this product worth buying?
     - What are the pros and cons?
     - Are there better alternatives?
     - What should I know before buying?

4. **AI Chat:**
   - Streaming responses from AI provider
   - Input remains active for follow-up questions
   - Error handling with toast notifications
   - Product context included in prompts

### Technical Implementation

**Files:**
- `source/lib/models/ai_provider.dart` - Provider models and configurations
- `source/lib/services/ai_settings_service.dart` - Settings persistence
- `source/lib/services/ai_service.dart` - API integration with all providers
- `source/lib/ui/pages/ai_settings_page.dart` - Settings UI
- `source/lib/ui/common/ask_ai_button.dart` - Product page button
- `source/lib/ui/pages/ai_question_selection_page.dart` - Contextual questions
- `source/lib/ui/pages/ai_chat_page.dart` - Chat interface

**Error Handling:**
- API failures throw exceptions (not swallowed as text)
- Toast notifications for validation and API errors
- Graceful fallback for missing configuration

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

### 2025-11-18: Ask AI Feature Implementation

- **Implemented complete "Ask AI" feature** to replace "Buy Here" button with AI-powered product questions
- Added support for 4 AI providers: OpenAI, Google Gemini, Perplexity, and Deepseek
- Created AI Settings page for provider selection and API key configuration
- Implemented contextual question selection based on product ownership status:
  - Owned products ("My Things"): care, troubleshooting, accessories
  - Scan history (pre-purchase): buying decisions, comparisons, research
- Built AI chat interface with streaming responses and follow-up question support
- Integrated AI services with proper error handling and toast notifications
- Used shared_preferences for persistent settings storage
- All code is web-compatible and follows existing Flutter patterns

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
- **Fixed web compatibility issue:** Added null-check guards for mobile-specific device features (DeviceRegion.getSIMCountryCode) in register_page.dart to prevent runtime crashes on web browsers
- App now loads successfully and displays login screen

## Troubleshooting

### App shows blank white screen

This typically means the app is still loading. Check:
1. Browser console for JavaScript errors
2. Workflow logs to ensure the server is running
3. Network tab to verify assets are loading
4. Wait 15-30 seconds for the initial load (Flutter web can take time on first load)

### WebGL warning in browser console

You may see: "WARNING: Falling back to CPU-only rendering. WebGL support not detected."

This is normal in some browser environments and doesn't affect core functionality. The app will use CPU rendering instead of GPU acceleration.

### Google Sign-In not working

Google Sign-In requires proper web configuration:
- Client ID must be configured for web platform
- Domain must be authorized in Google Cloud Console
- This is expected behavior for a mobile app ported to web without full OAuth setup

### Runtime errors in browser console

The app may encounter some runtime errors due to:
- Missing backend API responses (app connects to test API: tingsapi.test.mindworks.ee)
- Mobile-specific features not available in web browsers (camera, vibration, etc.)
- Missing environment configuration

### Build errors

If you encounter build errors:

```bash
cd source
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter build web --release
```

### After code changes, app doesn't update

The workflow serves pre-built static files. After making code changes:

```bash
cd source
flutter build web --release
```

Then restart the workflow or wait for auto-restart.

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
