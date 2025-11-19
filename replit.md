# Thap Mobile App - Replit Setup

## Overview

Thap is a Flutter-based mobile application primarily designed for iOS and Android, now configured to run as a web application within the Replit environment. Its core purpose is to provide a comprehensive mobile experience with multi-language support, QR code scanning, image management, Google Sign-In, and an innovative "Ask AI" feature for product inquiries. The project aims to deliver a stable, fast, and user-friendly web application experience leveraging Flutter's capabilities.

## User Preferences

I prefer detailed explanations.
I want iterative development.
Ask before making major changes.
Do not make changes to the folder `docs/`.
Do not make changes to the `README.md` file.

## System Architecture

The application is built with Flutter 3.32.0 and Dart 3.8, utilizing a layered architecture comprising Presentation, State, Service, Repository, and Data layers. Currently undergoing migration from MobX/GetIt to Riverpod/GoRouter for modern state management and routing. Dio handles HTTP requests, and localization is managed via EasyLocalization, supporting 14 languages. The UI adheres to Material Design principles with a component-based structure, emphasizing reusability. The Replit deployment strategy involves building a release-mode Flutter web app and serving it statically via the `serve` npm package on port 5000.

**Demo Mode:** The application is currently configured in demo mode (`Env.isDemoMode = true`) which enables automatic authentication bypass for testing purposes. When demo mode is active:
- Authentication uses `AuthRepositoryDemo` instead of real Google Sign-In
- Auto-signs in as "Demo User" (demo@example.com) without credentials
- All AI providers can operate in demo mode without real API keys
- To disable demo mode for production: `flutter build web --dart-define=DEMO_MODE=false`

**Recent Migration Status (Nov 2025):**
- ✅ Successfully migrated from MobX to Riverpod for auth, wallet, and scan features
- ✅ App compiles with zero errors and runs in web preview
- ⚠️ Legacy GetIt service locator still active for backward compatibility
- 📋 Next: Complete Riverpod migration for remaining features

## External Dependencies

- **State Management:** MobX, Flutter MobX
- **HTTP/API:** Dio, HTTP
- **UI Components:** Flutter SVG, Pretty QR Code, Cached Network Image
- **Authentication:** Google Sign-In
- **Mobile Features (Limited Web Functionality):** Mobile Scanner, Image Picker, File Picker
- **Web Views:** Flutter InAppWebView, WebView Flutter
- **PDF Support:** PDFx
- **Storage:** Shared Preferences
- **Localization:** Easy Localization
- **Backend API:** `https://tingsapi.test.mindworks.ee/api`
- **AI Providers:** OpenAI, Google Gemini, Perplexity, Deepseek