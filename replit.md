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

The application is built with Flutter 3.32.0 and Dart 3.8, utilizing a layered architecture comprising Presentation, State, Service, Repository, and Data layers. MobX is employed for reactive state management, and Dio handles HTTP requests. Localization is managed via EasyLocalization, supporting 14 languages. The UI adheres to Material Design principles with a component-based structure, emphasizing reusability. The Replit deployment strategy involves building a release-mode Flutter web app and serving it statically to ensure stability and performance. A key feature is the "Ask AI" functionality, which integrates with multiple AI providers (OpenAI, Google Gemini, Perplexity, Deepseek) to offer contextual product-related questions and answers, including a "Demo Mode" for testing without real API keys.

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