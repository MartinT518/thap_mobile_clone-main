# Technical Architecture Document
## Thap Mobile Application

**Version:** 2.0  
**Date:** November 18, 2025  
**Platform:** Flutter 3.32.0 / Dart 3.8  
**Deployment:** Web (Replit), iOS, Android

---

## Table of Contents
1. [System Overview](#system-overview)
2. [Architecture Patterns](#architecture-patterns)
3. [Technology Stack](#technology-stack)
4. [Data Flow](#data-flow)
5. [State Management](#state-management)
6. [API Integration](#api-integration)
7. [Security](#security)
8. [Performance](#performance)
9. [Testing Strategy](#testing-strategy)
10. [Deployment](#deployment)

---

## 1. System Overview

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐  │
│  │  Pages   │ │ Widgets  │ │ Dialogs  │ │ Sheets   │  │
│  └──────────┘ └──────────┘ └──────────┘ └──────────┘  │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                  State Management (MobX)                 │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐   │
│  │ UserProfile  │ │ ProductStore │ │ AISettings   │   │
│  │    Store     │ │              │ │   Service    │   │
│  └──────────────┘ └──────────────┘ └──────────────┘   │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                     Service Layer                        │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐      │
│  │   Auth      │ │ Navigation  │ │ AI Service  │      │
│  │  Service    │ │   Service   │ │             │      │
│  └─────────────┘ └─────────────┘ └─────────────┘      │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                   Repository Layer                       │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐   │
│  │     User     │ │   Product    │ │   MyTings    │   │
│  │  Repository  │ │  Repository  │ │  Repository  │   │
│  └──────────────┘ └──────────────┘ └──────────────┘   │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                      Data Layer                          │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐   │
│  │  REST API    │ │    Local     │ │  External    │   │
│  │   (Dio)      │ │   Storage    │ │   AI APIs    │   │
│  └──────────────┘ └──────────────┘ └──────────────┘   │
└─────────────────────────────────────────────────────────┘
```

### Key Architectural Decisions

**1. Clean Architecture Principles**
- Separation of concerns (UI, Business Logic, Data)
- Dependency inversion (abstractions, not implementations)
- Single responsibility per module

**2. Reactive State Management (MobX)**
- Observable state with automatic UI updates
- Computed values for derived state
- Actions for state mutations

**3. Service Locator Pattern (GetIt)**
- Dependency injection for loose coupling
- Singleton services (AuthService, NavigationService)
- Factory instances where needed

**4. Repository Pattern**
- Abstract data sources (API, local storage)
- Consistent interface for data access
- Easy to mock for testing

---

## 2. Architecture Patterns

### Layered Architecture

#### Presentation Layer (`lib/ui/`)
**Responsibility:** Display data, capture user input

```
lib/ui/
├── pages/              # Full-screen views
│   ├── home_page.dart
│   ├── product_detail_page.dart
│   ├── ai_chat_page.dart
│   └── settings_page.dart
├── common/             # Reusable widgets
│   ├── product_card.dart
│   ├── ask_ai_button.dart
│   └── loading_indicator.dart
└── dialogs/            # Modal dialogs
    ├── confirmation_dialog.dart
    └── api_key_dialog.dart
```

**Rules:**
- Pages consume stores via `Observer` widgets
- No direct API calls from UI
- No business logic in widgets
- Presentational components only

#### State Management Layer (`lib/stores/`)
**Responsibility:** Manage application state

```
lib/stores/
├── user_profile_store.dart      # User session state
├── product_store.dart            # Product data cache
└── settings_store.dart           # App settings
```

**Pattern:** MobX Store
```dart
abstract class _UserProfileStoreBase with Store {
  @observable
  UserProfile? userProfile;
  
  @computed
  bool get isAuthenticated => userProfile != null;
  
  @action
  void setUserProfile(UserProfile profile) {
    userProfile = profile;
  }
}
```

#### Service Layer (`lib/services/`)
**Responsibility:** Business logic, orchestration

```
lib/services/
├── auth_service.dart             # Authentication logic
├── navigation_service.dart       # App navigation
├── ai_service.dart               # AI provider integration
└── ai_settings_service.dart      # AI config persistence
```

**Pattern:** Service classes with dependency injection
```dart
class AuthService {
  final UserRepository _userRepository;
  final UserProfileStore _userProfileStore;
  
  AuthService(this._userRepository, this._userProfileStore);
  
  Future<void> signIn() async {
    // Business logic here
  }
}
```

#### Repository Layer (`lib/data/repository/`)
**Responsibility:** Data access abstraction

```
lib/data/repository/
├── user_repository.dart          # User data
├── app_repository.dart           # App config
├── my_tings_repository.dart      # User's products
└── demo_*.dart                   # Demo mode implementations
```

**Pattern:** Interface + Implementation
```dart
abstract class UserRepository {
  Future<UserProfile> authenticate(String email, String token);
  Future<void> updateProfile(UserProfile profile);
}

class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;
  
  @override
  Future<UserProfile> authenticate(String email, String token) async {
    final response = await _apiClient.post('/user/authenticate', ...);
    return UserProfile.fromJson(response.data);
  }
}
```

#### Data Layer (`lib/data/`)
**Responsibility:** External communication

```
lib/data/
├── api/                # REST API clients
│   └── api_client.dart
├── models/             # Data models
│   ├── user_profile.dart
│   ├── product.dart
│   └── product_item.dart
└── local/              # Local storage
    └── shared_prefs.dart
```

---

## 3. Technology Stack

### Core Framework
```
Flutter: 3.32.0
Dart SDK: 3.8.0
Platforms: iOS, Android, Web
```

### State Management
```
mobx: ^2.x              # Reactive state management
flutter_mobx: ^2.x      # Flutter bindings
build_runner: ^2.x      # Code generation
```

### Networking
```
dio: ^5.x               # HTTP client
retrofit: ^4.x          # Type-safe REST client
pretty_dio_logger: ^1.x # Request/response logging
```

### Navigation
```
get_it: ^7.x            # Service locator
injectable: ^2.x        # DI code generation
```

### Local Storage
```
shared_preferences: ^2.x  # Key-value storage
```

### UI Components
```
flutter_svg: ^2.x         # SVG rendering
cached_network_image: ^3.x # Image caching
pretty_qr_code: ^3.x      # QR code display
```

### Mobile Features
```
mobile_scanner: ^5.x      # QR scanning
image_picker: ^1.x        # Photo selection
file_picker: ^8.x         # File selection
google_sign_in: ^6.x      # OAuth
```

### Localization
```
easy_localization: ^3.x   # i18n support
intl: ^0.19.x             # Internationalization
```

### External APIs
```
OpenAI: gpt-3.5-turbo
Google Gemini: gemini-pro
Perplexity: llama-3.1-sonar-small-128k-online
Deepseek: deepseek-chat
```

---

## 4. Data Flow

### User Authentication Flow

```
User Action (Login)
    ↓
AuthService.socialSignIn()
    ↓
GoogleSignIn.signIn() → OAuth Flow
    ↓
UserRepository.authenticate(email, token)
    ↓
API: POST /v2/user/authenticate
    ↓
UserProfile received
    ↓
UserProfileStore.setUserProfile(profile)
    ↓
NavigationService.navigateToHome()
    ↓
UI Updates (Observer widgets rebuild)
```

### Product Scanning Flow

```
User Action (Scan QR)
    ↓
Camera Permission Check
    ↓
MobileScanner.onDetect(barcode)
    ↓
Extract Product ID
    ↓
AppRepository.getProductByEAN(productId)
    ↓
API: GET /v2/products/{id}
    ↓
Product Data received
    ↓
ProductStore.addProduct(product)
    ↓
NavigationService.navigateToProductDetail(product)
    ↓
UI Displays Product
```

### Add to Wallet Flow

```
User Action (Add to My Things)
    ↓
MyTingsRepository.addProductToTings(productId)
    ↓
API: POST /v2/tings/add {productId}
    ↓
ProductInstance created
    ↓
ProductStore.updateOwnership(productId, isOwner: true)
    ↓
ProductStore.removeFromHistory(productId)
    ↓
UI Updates (Button changes to "Remove")
```

### AI Question Flow

```
User Action (Ask AI)
    ↓
Check AISettingsService.isConfigured
    ↓
Navigate to AIQuestionSelectionPage
    ↓
User Selects Question
    ↓
Navigate to AIChatPage
    ↓
AIService.sendMessage(question, productContext)
    ↓
Check Demo Mode?
    ├─ Yes → Generate simulated response
    └─ No → Call AI Provider API
    ↓
Stream Response Chunks
    ↓
UI Updates (Real-time text display)
    ↓
Enable Follow-up Input
```

---

## 5. State Management

### MobX Store Hierarchy

```
AppStore (Root)
├── UserProfileStore          # User session
│   ├── userProfile: UserProfile?
│   ├── isAuthenticated: bool (computed)
│   └── signOut(): void (action)
│
├── ProductStore              # Product cache
│   ├── products: Map<String, Product>
│   ├── scanHistory: List<ProductItem>
│   ├── myThings: List<ProductItem>
│   └── updateProduct(): void (action)
│
└── SettingsStore             # App settings
    ├── language: String
    ├── country: String
    └── updateSettings(): void (action)
```

### Observable Pattern

```dart
// Store definition
@observable
UserProfile? userProfile;

@computed
bool get isAuthenticated => userProfile != null;

@action
void setUserProfile(UserProfile profile) {
  userProfile = profile;
}
```

```dart
// UI consumption
Observer(
  builder: (_) => Text(
    store.isAuthenticated 
      ? 'Welcome ${store.userProfile!.name}' 
      : 'Please sign in'
  ),
)
```

### State Lifecycle

1. **Initialization**: Stores registered in service locator
2. **Hydration**: Load persisted state from SharedPreferences
3. **Runtime**: Actions modify observables
4. **Reaction**: Computed values auto-update
5. **UI Update**: Observer widgets rebuild
6. **Persistence**: Critical state saved to SharedPreferences

---

## 6. API Integration

### Backend API (Tings API)

**Base URL:** `https://tingsapi.test.mindworks.ee/api`

#### Authentication
```
Method: Bearer Token
Header: Authorization: Bearer {token}
Token Source: OAuth response
Token Storage: Encrypted SharedPreferences
```

#### Endpoints

**User Management**
```
POST   /v2/user/authenticate
GET    /v2/user/profile
PATCH  /v2/user/profile
GET    /v2/user/scan_history
DELETE /v2/user/scan_history/{id}
```

**Product Management**
```
GET    /v2/products/{id}
GET    /v2/products/search?q={query}
```

**User's Products (Tings)**
```
GET    /v2/tings/list
POST   /v2/tings/add
DELETE /v2/tings/{id}/remove
PATCH  /v2/tings/{id}/update
```

**App Configuration**
```
GET    /v2/app
```

#### Request/Response Flow

```dart
// Dio interceptor for auth
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = locator<UserProfileStore>().userProfile?.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
```

#### Error Handling

```dart
try {
  final response = await apiClient.get('/products/123');
  return Product.fromJson(response.data);
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Unauthorized - logout user
    await authService.signOut();
  } else if (e.response?.statusCode == 404) {
    throw ProductNotFoundException();
  } else {
    throw NetworkException(e.message);
  }
}
```

### External AI APIs

#### OpenAI
```
URL: https://api.openai.com/v1/chat/completions
Auth: Bearer {api_key}
Model: gpt-3.5-turbo
Stream: true
```

**Request:**
```json
{
  "model": "gpt-3.5-turbo",
  "messages": [
    {"role": "user", "content": "Question with product context"}
  ],
  "stream": true
}
```

#### Google Gemini
```
URL: https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent
Auth: API key in query param
Stream: true
```

**Request:**
```json
{
  "contents": [
    {"parts": [{"text": "Question with product context"}]}
  ]
}
```

#### Perplexity
```
URL: https://api.perplexity.ai/chat/completions
Auth: Bearer {api_key}
Model: llama-3.1-sonar-small-128k-online
Stream: true
```

#### Deepseek
```
URL: https://api.deepseek.com/v1/chat/completions
Auth: Bearer {api_key}
Model: deepseek-chat
Stream: true
```

#### AI Service Abstraction

```dart
abstract class AIProvider {
  Future<Stream<String>> sendMessage(String message, List<Message> history);
}

class OpenAIProvider implements AIProvider {
  @override
  Future<Stream<String>> sendMessage(String message, List<Message> history) async {
    // OpenAI-specific implementation
  }
}

class AIService {
  AIProvider? _provider;
  
  Future<Stream<String>> chat(String message, ProductContext context) async {
    final prompt = _buildPrompt(message, context);
    return await _provider!.sendMessage(prompt, conversationHistory);
  }
}
```

---

## 7. Security

### Authentication Security

**OAuth 2.0 Flow**
```
1. User initiates Google Sign-In
2. Redirect to Google OAuth consent page
3. User grants permissions
4. Google redirects with authorization code
5. App exchanges code for access token
6. Token stored encrypted in SharedPreferences
7. Token included in all API requests
```

**Token Storage**
```dart
final prefs = await SharedPreferences.getInstance();
final encryptedToken = encrypt(token);
await prefs.setString('auth_token', encryptedToken);
```

### API Key Security

**AI Provider Keys**
- Stored locally in SharedPreferences
- Encrypted at rest (AES-256)
- Never sent to Tings backend
- Never logged or exposed in UI
- Cleared on logout

**Demo Mode**
- Recognized keys: "demo", "test", "demo-key-123"
- No actual API calls made
- Simulated responses only
- No API costs incurred

### Network Security

**HTTPS Only**
- All API calls over TLS 1.2+
- Certificate pinning (production)
- No plaintext transmission

**Request Security**
```dart
final dio = Dio(BaseOptions(
  baseUrl: 'https://tingsapi.test.mindworks.ee/api',
  connectTimeout: Duration(seconds: 60),
  receiveTimeout: Duration(seconds: 60),
  validateStatus: (status) => status! < 500,
));
```

### Data Privacy

**User Data**
- Minimal data collection (email, name, photo)
- No tracking without consent
- GDPR compliant
- User-initiated data deletion

**Local Data**
- SharedPreferences for non-sensitive data
- Encrypted storage for tokens and API keys
- Cache cleared on logout

---

## 8. Performance

### Optimization Strategies

#### Image Loading
```dart
CachedNetworkImage(
  imageUrl: product.imageUrl,
  placeholder: (context, url) => ShimmerPlaceholder(),
  errorWidget: (context, url, error) => ErrorPlaceholder(),
  memCacheWidth: 600,  // Reduce memory usage
  memCacheHeight: 800,
)
```

#### List Performance
```dart
ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ProductCard(product: products[index]);
  },
  cacheExtent: 500,  // Pre-render off-screen items
)
```

#### State Management
- Computed values cached until dependencies change
- Actions batch multiple mutations
- Observers rebuild only affected widgets

#### API Optimization
- Request debouncing (search: 300ms)
- Response caching (products: 5 minutes)
- Pagination for large lists (20 items per page)
- Retry logic with exponential backoff

### Performance Metrics

**Target Metrics:**
- App launch: < 3 seconds
- Page transition: < 300ms
- API response: < 500ms (p95)
- Image load: < 2 seconds
- AI first token: < 1 second

**Monitoring:**
- Firebase Performance Monitoring
- Crashlytics for error tracking
- Custom analytics events

---

## 9. Testing Strategy

### Unit Tests

**Coverage Target:** 80%

```dart
// Store test
test('UserProfileStore sets profile correctly', () {
  final store = UserProfileStore();
  final profile = UserProfile(name: 'Test', email: 'test@example.com');
  
  store.setUserProfile(profile);
  
  expect(store.userProfile, equals(profile));
  expect(store.isAuthenticated, isTrue);
});
```

**Test Files:**
```
test/
├── stores/
│   ├── user_profile_store_test.dart
│   └── product_store_test.dart
├── services/
│   ├── auth_service_test.dart
│   └── ai_service_test.dart
└── repositories/
    └── user_repository_test.dart
```

### Integration Tests

**API Integration:**
```dart
testWidgets('Product detail page loads correctly', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigate to product
  await tester.tap(find.byType(ProductCard).first);
  await tester.pumpAndSettle();
  
  // Verify product details displayed
  expect(find.text('Product Name'), findsOneWidget);
  expect(find.byType(AskAIButton), findsOneWidget);
});
```

### E2E Tests

**Critical User Flows:**
1. Sign in with Google
2. Scan QR code → View product
3. Add product to wallet
4. Configure AI provider
5. Ask AI question → Receive response

```dart
testWidgets('Complete AI question flow', (tester) async {
  // 1. Sign in
  await signInHelper(tester);
  
  // 2. Configure AI (demo mode)
  await configureAIHelper(tester, apiKey: 'demo');
  
  // 3. Navigate to product
  await navigateToProductHelper(tester, productId: 'test-123');
  
  // 4. Ask AI question
  await tester.tap(find.text('Ask AI'));
  await tester.pumpAndSettle();
  
  await tester.tap(find.text('How to optimize this battery life?'));
  await tester.pumpAndSettle();
  
  // 5. Verify response appears
  expect(find.byType(AIChatPage), findsOneWidget);
  await tester.pump(Duration(seconds: 2));
  expect(find.textContaining('battery'), findsWidgets);
});
```

### Mocking

```dart
class MockUserRepository extends Mock implements UserRepository {}
class MockAIService extends Mock implements AIService {}

// Use in tests
final mockRepo = MockUserRepository();
when(mockRepo.authenticate(any, any))
  .thenAnswer((_) async => UserProfile(...));
```

---

## 10. Deployment

### Web Deployment (Replit)

**Build Process:**
```bash
cd source
flutter build web --release
```

**Output:**
```
source/build/web/
├── index.html
├── main.dart.js       # Compiled Dart → JS
├── flutter.js
├── assets/
└── canvaskit/
```

**Serving:**
```bash
dhttpd --host=0.0.0.0 --port=5000 --path=source/build/web
```

**Configuration:**
```yaml
# .replit
[deployment]
deploymentTarget = "static"
publicDir = "source/build/web"
build = ["sh", "-c", "cd source && flutter build web --release"]
```

### iOS Deployment

**Build:**
```bash
flutter build ios --release
```

**Requirements:**
- Xcode 15+
- iOS deployment target: 12.0+
- Code signing certificate
- Provisioning profile

**App Store:**
- Bundle ID: com.thap.app
- Version: 2.0.0
- Build number: Auto-increment

### Android Deployment

**Build:**
```bash
flutter build apk --release
flutter build appbundle --release
```

**Requirements:**
- Android Studio
- Min SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Signing key

**Google Play:**
- Package name: com.thap.app
- Version code: Auto-increment
- AAB format for Play Store

### Environment Configuration

**Development:**
```dart
const kDemoMode = true;
const kApiBaseUrl = 'https://tingsapi.test.mindworks.ee/api';
```

**Production:**
```dart
const kDemoMode = false;
const kApiBaseUrl = 'https://tingsapi.mindworks.ee/api';
```

### CI/CD Pipeline

**Automated Testing:**
```yaml
# GitHub Actions example
name: Test & Build
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build web --release
```

---

## 11. Monitoring & Logging

### Application Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
  level: kReleaseMode ? Level.warning : Level.debug,
);

// Usage
logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message', error, stackTrace);
```

### Error Tracking

**Crashlytics Integration:**
```dart
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

runZonedGuarded(() {
  runApp(MyApp());
}, (error, stackTrace) {
  FirebaseCrashlytics.instance.recordError(error, stackTrace);
});
```

### Analytics

**Events:**
- Screen views
- Button taps (AI button, scan button)
- API calls (success/failure)
- AI provider usage
- Error occurrences

---

## Appendix

### Code Generation

**MobX:**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

**Localization:**
```bash
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
```

### Dependencies Update

```bash
flutter pub outdated
flutter pub upgrade
flutter pub get
```

### Performance Profiling

```bash
flutter run --profile
# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

---

**Document Owner:** Engineering Team  
**Last Updated:** November 18, 2025  
**Next Review:** December 15, 2025
