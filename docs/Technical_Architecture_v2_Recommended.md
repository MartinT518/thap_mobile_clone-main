# Technical Architecture Document (v2.0 - Recommended)
## Thap Mobile Application - Modern Architecture

**Version:** 2.0 (Recommended for Regeneration)  
**Date:** November 18, 2025  
**Platform:** Flutter 3.32.0+ / Dart 3.8+  
**Architecture:** Clean Architecture + Riverpod + GoRouter

---

## ⚠️ Why This Architecture Revision?

The original MobX + GetIt architecture (documented in `Technical_Architecture.md`) encountered several issues:
- Complex code generation requirements
- Service locator pattern conflicts in demo mode
- Difficult dependency management
- White screen issues in web deployment
- Over-engineered for the app's complexity

**This revised architecture provides:**
- ✅ Simpler state management (Riverpod)
- ✅ Better testability
- ✅ Faster development
- ✅ Native Flutter patterns
- ✅ Easier debugging
- ✅ Better web compatibility

---

## Table of Contents
1. [High-Level Architecture](#high-level-architecture)
2. [Core Principles](#core-principles)
3. [Technology Stack (Revised)](#technology-stack-revised)
4. [Project Structure](#project-structure)
5. [State Management (Riverpod)](#state-management-riverpod)
6. [Routing & Navigation](#routing--navigation)
7. [Data Layer](#data-layer)
8. [Feature Implementation](#feature-implementation)
9. [Demo Mode Strategy](#demo-mode-strategy)
10. [Migration from v1](#migration-from-v1)

---

## 1. High-Level Architecture

### Layered Architecture (Simplified)

```
┌─────────────────────────────────────────────────────┐
│              Presentation Layer                      │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐   │
│  │   Pages    │  │  Widgets   │  │  Providers │   │
│  │ (StatelessWidget)          │  │ (UI State) │   │
│  └────────────┘  └────────────┘  └────────────┘   │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│            Application Logic Layer                   │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐   │
│  │   State    │  │  Services  │  │  Use Cases │   │
│  │ Providers  │  │ (Business  │  │ (Optional) │   │
│  │ (Riverpod) │  │   Logic)   │  │            │   │
│  └────────────┘  └────────────┘  └────────────┘   │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                 Data Layer                           │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐   │
│  │ Repository │  │  API Client│  │   Local    │   │
│  │  (Abstract)│  │    (Dio)   │  │  Storage   │   │
│  └────────────┘  └────────────┘  └────────────┘   │
└─────────────────────────────────────────────────────┘
```

### Key Architectural Decisions

**1. Riverpod over MobX**
- No code generation for basic features
- Compile-time safety
- Better Flutter integration
- Simpler mental model

**2. GoRouter over Custom Navigation**
- Type-safe routing
- Deep linking support
- Web URL support
- Easier to maintain

**3. Repository Pattern**
- Single source of truth for data
- Easy to swap implementations (API ↔ Mock)
- Clean separation of concerns

**4. Environment-Based Configuration**
- Compile-time demo mode flag
- No runtime service switching
- Cleaner dependency graph

---

## 2. Core Principles

### SOLID Principles Applied

**Single Responsibility**
- Each provider manages one piece of state
- Each repository handles one data source
- Each widget has one purpose

**Open/Closed**
- Repositories are interfaces
- Easy to extend (new AI providers)
- Closed to modification (existing features)

**Dependency Inversion**
- Depend on abstractions (Repository interfaces)
- Concrete implementations injected via Riverpod

### Additional Principles

**Simplicity First**
- Avoid over-engineering
- Use Flutter conventions
- Minimize abstractions

**Testability**
- All providers easily mockable
- Repository pattern enables testing
- Dependency injection built-in

**Performance**
- Lazy loading of providers
- Efficient rebuilds (Riverpod)
- Cached data with proper invalidation

---

## 3. Technology Stack (Revised)

### Core Framework
```yaml
flutter: 3.32.0+
dart: 3.8.0+
```

### State Management & DI
```yaml
# CHANGED: Riverpod instead of MobX + GetIt
flutter_riverpod: ^2.4.0          # State management + DI
riverpod_annotation: ^2.3.0       # Code generation (optional)
```

### Routing
```yaml
# CHANGED: GoRouter instead of custom navigation
go_router: ^13.0.0                # Declarative routing
```

### Networking (Unchanged)
```yaml
dio: ^5.4.0                       # HTTP client
retrofit: ^4.0.0                  # Type-safe REST API
json_annotation: ^4.8.0           # JSON serialization
```

### Local Storage (Unchanged)
```yaml
shared_preferences: ^2.2.0        # Simple key-value
flutter_secure_storage: ^9.0.0    # Encrypted storage
```

### UI & Assets (Unchanged)
```yaml
flutter_svg: ^2.0.0
cached_network_image: ^3.3.0
pretty_qr_code: ^3.0.0
```

### Mobile Features (Unchanged)
```yaml
mobile_scanner: ^5.0.0            # QR scanning
image_picker: ^1.0.0
google_sign_in: ^6.2.0
```

### Localization (Unchanged)
```yaml
easy_localization: ^3.0.0
intl: ^0.19.0
```

### Development Tools
```yaml
# CHANGED: Simpler build
build_runner: ^2.4.0              # Only for json_serializable
freezed: ^2.4.0                   # Immutable models (optional)
riverpod_generator: ^2.3.0        # Riverpod code gen (optional)
```

---

## 4. Project Structure

### Recommended Directory Structure

```
lib/
├── main.dart                     # App entry point
├── app.dart                      # MaterialApp + routing setup
│
├── core/                         # Core utilities
│   ├── config/
│   │   ├── env.dart             # Environment config
│   │   └── constants.dart       # App constants
│   ├── router/
│   │   └── app_router.dart      # GoRouter configuration
│   └── theme/
│       └── app_theme.dart       # Theme data
│
├── features/                     # Feature modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   ├── repositories/
│   │   │   │   ├── auth_repository.dart          (abstract)
│   │   │   │   ├── auth_repository_impl.dart     (API)
│   │   │   │   └── auth_repository_demo.dart     (Demo)
│   │   │   └── datasources/
│   │   │       └── auth_remote_datasource.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart          (interface)
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart            (Riverpod)
│   │       ├── pages/
│   │       │   └── login_page.dart
│   │       └── widgets/
│   │           └── google_sign_in_button.dart
│   │
│   ├── products/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── wallet/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── ai_assistant/
│       ├── data/
│       │   ├── models/
│       │   │   ├── ai_provider_model.dart
│       │   │   └── chat_message_model.dart
│       │   ├── repositories/
│       │   │   ├── ai_repository.dart            (abstract)
│       │   │   ├── ai_repository_impl.dart       (API)
│       │   │   └── ai_repository_demo.dart       (Simulated)
│       │   └── datasources/
│       │       ├── openai_datasource.dart
│       │       ├── gemini_datasource.dart
│       │       ├── perplexity_datasource.dart
│       │       └── deepseek_datasource.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── ai_provider.dart
│       │   │   └── chat_message.dart
│       │   └── repositories/
│       │       └── ai_repository.dart            (interface)
│       └── presentation/
│           ├── providers/
│           │   ├── ai_settings_provider.dart
│           │   └── ai_chat_provider.dart
│           ├── pages/
│           │   ├── ai_settings_page.dart
│           │   └── ai_chat_page.dart
│           └── widgets/
│               └── ask_ai_button.dart
│
└── shared/                       # Shared across features
    ├── providers/
    │   └── dio_provider.dart    # Shared Dio instance
    ├── widgets/
    │   ├── loading_indicator.dart
    │   └── error_widget.dart
    └── utils/
        └── validators.dart
```

---

## 5. State Management (Riverpod)

### Provider Types & Usage

#### StateProvider (Simple State)
```dart
// Simple state that can be modified directly
final languageProvider = StateProvider<String>((ref) => 'en');

// Usage in widget
class LanguageSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    
    return DropdownButton(
      value: language,
      onChanged: (value) {
        ref.read(languageProvider.notifier).state = value!;
      },
      items: [...],
    );
  }
}
```

#### StateNotifierProvider (Complex State)
```dart
// State class
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}

// State notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AuthState.initial());
  
  Future<void> signIn() async {
    state = const AuthState.loading();
    try {
      final user = await _repository.signInWithGoogle();
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
  
  void signOut() {
    _repository.signOut();
    state = const AuthState.initial();
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
```

#### FutureProvider (Async Data)
```dart
// Fetches data asynchronously
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserProfile();
});

// Usage in widget
class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    
    return profileAsync.when(
      data: (profile) => ProfileView(profile: profile),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error: error),
    );
  }
}
```

#### StreamProvider (Real-time Data)
```dart
// For AI streaming responses
final aiResponseProvider = StreamProvider.family<String, String>((ref, prompt) {
  final aiService = ref.watch(aiServiceProvider);
  return aiService.streamResponse(prompt);
});

// Usage
class AIChatPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseStream = ref.watch(aiResponseProvider('How to care for battery?'));
    
    return responseStream.when(
      data: (response) => Text(response),
      loading: () => LoadingIndicator(),
      error: (error, stack) => ErrorMessage(error: error),
    );
  }
}
```

### Dependency Injection with Riverpod

```dart
// Repository provider (injectable)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (kDemoMode) {
    return AuthRepositoryDemo();
  } else {
    final dio = ref.watch(dioProvider);
    return AuthRepositoryImpl(dio);
  }
});

// Dio provider (singleton)
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: kApiBaseUrl,
    connectTimeout: Duration(seconds: 60),
  ));
  
  // Add interceptors
  dio.interceptors.add(AuthInterceptor(ref));
  
  return dio;
});
```

---

## 6. Routing & Navigation

### GoRouter Configuration

```dart
// lib/core/router/app_router.dart
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState is Authenticated;
      final isLoginRoute = state.matchedLocation == '/login';
      
      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }
      if (isAuthenticated && isLoginRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: 'product/:id',
            name: 'product-detail',
            builder: (context, state) {
              final productId = state.pathParameters['id']!;
              return ProductDetailPage(productId: productId);
            },
            routes: [
              GoRoute(
                path: 'ai-chat',
                name: 'ai-chat',
                builder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return AIChatPage(productId: productId);
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => SettingsPage(),
        routes: [
          GoRoute(
            path: 'ai',
            name: 'ai-settings',
            builder: (context, state) => AISettingsPage(),
          ),
        ],
      ),
    ],
  );
});
```

### Navigation Usage

```dart
// Navigate to route
context.go('/home/product/123');
context.goNamed('product-detail', pathParameters: {'id': '123'});

// Push (stack navigation)
context.push('/settings/ai');

// Pop
context.pop();

// Replace
context.replace('/home');
```

---

## 7. Data Layer

### Repository Pattern

```dart
// Abstract repository (domain layer)
abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

// API implementation (data layer)
class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  
  AuthRepositoryImpl(this._dio, this._googleSignIn);
  
  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Sign in cancelled');
    
    final response = await _dio.post('/v2/user/authenticate', data: {
      'email': googleUser.email,
      'name': googleUser.displayName,
    });
    
    return User.fromJson(response.data);
  }
  
  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
  
  @override
  Future<User?> getCurrentUser() async {
    final response = await _dio.get('/v2/user/profile');
    return User.fromJson(response.data);
  }
}

// Demo implementation (for testing)
class AuthRepositoryDemo implements AuthRepository {
  @override
  Future<User> signInWithGoogle() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network
    return User(
      id: 'demo-user',
      email: 'demo@example.com',
      name: 'Demo User',
    );
  }
  
  @override
  Future<void> signOut() async {
    await Future.delayed(Duration(milliseconds: 500));
  }
  
  @override
  Future<User?> getCurrentUser() async {
    return User(
      id: 'demo-user',
      email: 'demo@example.com',
      name: 'Demo User',
    );
  }
}
```

### AI Repository Example

```dart
// Abstract AI repository
abstract class AIRepository {
  Stream<String> sendMessage(String message, List<ChatMessage> history);
  Future<bool> validateApiKey(String provider, String apiKey);
}

// Real API implementation
class AIRepositoryImpl implements AIRepository {
  final Dio _dio;
  
  AIRepositoryImpl(this._dio);
  
  @override
  Stream<String> sendMessage(String message, List<ChatMessage> history) async* {
    final provider = await _getConfiguredProvider();
    
    switch (provider) {
      case AIProvider.openai:
        yield* _streamOpenAI(message, history);
      case AIProvider.gemini:
        yield* _streamGemini(message, history);
      // ... other providers
    }
  }
  
  Stream<String> _streamOpenAI(String message, List<ChatMessage> history) async* {
    final response = await _dio.post(
      'https://api.openai.com/v1/chat/completions',
      data: {
        'model': 'gpt-3.5-turbo',
        'messages': _buildMessages(message, history),
        'stream': true,
      },
      options: Options(responseType: ResponseType.stream),
    );
    
    await for (final chunk in response.data.stream) {
      // Parse and yield chunks
      yield _parseChunk(chunk);
    }
  }
}

// Demo implementation
class AIRepositoryDemo implements AIRepository {
  @override
  Stream<String> sendMessage(String message, List<ChatMessage> history) async* {
    // Simulate streaming
    final response = _generateDemoResponse(message);
    final words = response.split(' ');
    
    for (final word in words) {
      await Future.delayed(Duration(milliseconds: 50));
      yield word + ' ';
    }
  }
  
  String _generateDemoResponse(String message) {
    if (message.contains('battery')) {
      return 'To optimize battery life: 1) Avoid extreme temperatures, '
             '2) Charge between 20-80%, 3) Use original charger.';
    }
    // ... more contextual responses
    return 'This is a demo response for: $message';
  }
}
```

---

## 8. Feature Implementation

### Example: AI Chat Feature

#### 1. Define Models (Data Layer)

```dart
// lib/features/ai_assistant/data/models/chat_message_model.dart
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String role, // 'user' or 'assistant'
    required String content,
    required DateTime timestamp,
  }) = _ChatMessage;
  
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
```

#### 2. Define Repository (Domain Layer)

```dart
// lib/features/ai_assistant/domain/repositories/ai_repository.dart
abstract class AIRepository {
  Stream<String> sendMessage(String message, String productContext);
  Future<void> saveApiKey(String provider, String apiKey);
  Future<String?> getApiKey(String provider);
}
```

#### 3. Implement Repository (Data Layer)

```dart
// lib/features/ai_assistant/data/repositories/ai_repository_impl.dart
class AIRepositoryImpl implements AIRepository {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  
  AIRepositoryImpl(this._dio, this._secureStorage);
  
  @override
  Stream<String> sendMessage(String message, String productContext) async* {
    final provider = await _getActiveProvider();
    final apiKey = await getApiKey(provider);
    
    if (apiKey == 'demo' || apiKey == 'test') {
      yield* _simulateResponse(message);
      return;
    }
    
    yield* _callRealAPI(provider, apiKey, message, productContext);
  }
  
  @override
  Future<void> saveApiKey(String provider, String apiKey) async {
    await _secureStorage.write(key: 'ai_key_$provider', value: apiKey);
  }
  
  @override
  Future<String?> getApiKey(String provider) async {
    return await _secureStorage.read(key: 'ai_key_$provider');
  }
}
```

#### 4. Create Provider (Presentation Layer)

```dart
// lib/features/ai_assistant/presentation/providers/ai_chat_provider.dart
@freezed
class AIChatState with _$AIChatState {
  const factory AIChatState({
    @Default([]) List<ChatMessage> messages,
    @Default('') String currentResponse,
    @Default(false) bool isStreaming,
    String? error,
  }) = _AIChatState;
}

class AIChatNotifier extends StateNotifier<AIChatState> {
  final AIRepository _repository;
  
  AIChatNotifier(this._repository) : super(const AIChatState());
  
  Future<void> sendMessage(String message, String productContext) async {
    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      role: 'user',
      content: message,
      timestamp: DateTime.now(),
    );
    
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isStreaming: true,
      currentResponse: '',
    );
    
    try {
      // Stream AI response
      await for (final chunk in _repository.sendMessage(message, productContext)) {
        state = state.copyWith(
          currentResponse: state.currentResponse + chunk,
        );
      }
      
      // Add complete response as message
      final assistantMessage = ChatMessage(
        id: DateTime.now().toString(),
        role: 'assistant',
        content: state.currentResponse,
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
        currentResponse: '',
        isStreaming: false,
      );
      
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isStreaming: false,
      );
    }
  }
}

// Provider definition
final aiChatProvider = StateNotifierProvider.family<AIChatNotifier, AIChatState, String>(
  (ref, productId) {
    final repository = ref.watch(aiRepositoryProvider);
    return AIChatNotifier(repository);
  },
);
```

#### 5. Build UI (Presentation Layer)

```dart
// lib/features/ai_assistant/presentation/pages/ai_chat_page.dart
class AIChatPage extends ConsumerStatefulWidget {
  final String productId;
  
  const AIChatPage({required this.productId});
  
  @override
  ConsumerState<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends ConsumerState<AIChatPage> {
  final _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatProvider(widget.productId));
    
    return Scaffold(
      appBar: AppBar(title: Text('Ask AI')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatState.messages.length + (chatState.isStreaming ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < chatState.messages.length) {
                  return ChatBubble(message: chatState.messages[index]);
                } else {
                  return ChatBubble(
                    message: ChatMessage(
                      id: 'streaming',
                      role: 'assistant',
                      content: chatState.currentResponse,
                      timestamp: DateTime.now(),
                    ),
                    isStreaming: true,
                  );
                }
              },
            ),
          ),
          ChatInput(
            controller: _controller,
            onSend: () {
              final message = _controller.text;
              if (message.isNotEmpty) {
                ref.read(aiChatProvider(widget.productId).notifier)
                   .sendMessage(message, widget.productId);
                _controller.clear();
              }
            },
            enabled: !chatState.isStreaming,
          ),
        ],
      ),
    );
  }
}
```

---

## 9. Demo Mode Strategy

### Environment-Based Configuration

```dart
// lib/core/config/env.dart
class Env {
  // Set at compile time
  static const bool isDemoMode = bool.fromEnvironment('DEMO_MODE', defaultValue: false);
  
  static const String apiBaseUrl = isDemoMode
      ? 'http://localhost:3000' // Not used in demo
      : 'https://tingsapi.mindworks.ee/api';
}

// Compile with demo mode:
// flutter build web --dart-define=DEMO_MODE=true
// flutter run --dart-define=DEMO_MODE=true
```

### Repository Selection Based on Environment

```dart
// lib/shared/providers/repository_providers.dart
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (Env.isDemoMode) {
    return AuthRepositoryDemo();
  } else {
    final dio = ref.watch(dioProvider);
    final googleSignIn = ref.watch(googleSignInProvider);
    return AuthRepositoryImpl(dio, googleSignIn);
  }
});

final aiRepositoryProvider = Provider<AIRepository>((ref) {
  if (Env.isDemoMode) {
    return AIRepositoryDemo();
  } else {
    final dio = ref.watch(dioProvider);
    final storage = ref.watch(secureStorageProvider);
    return AIRepositoryImpl(dio, storage);
  }
});
```

### Demo API Key Detection (Runtime)

```dart
// In AIRepositoryImpl
@override
Stream<String> sendMessage(String message, String context) async* {
  final apiKey = await getApiKey(activeProvider);
  
  // Check for demo keys at runtime
  if (apiKey == 'demo' || apiKey == 'test' || apiKey == 'demo-key-123') {
    yield* _simulateResponse(message);
    return;
  }
  
  // Real API call
  yield* _callProviderAPI(message, context);
}
```

---

## 10. Migration from v1

### Key Changes Summary

| Aspect | v1 (MobX + GetIt) | v2 (Riverpod + GoRouter) |
|--------|-------------------|---------------------------|
| State Management | MobX Stores | Riverpod Providers |
| Dependency Injection | GetIt Service Locator | Riverpod |
| Routing | Custom NavigationService | GoRouter |
| Code Generation | build_runner for MobX | Optional (json_serializable) |
| Demo Mode | Runtime service switching | Compile-time flag |
| Testing | Complex mocking | Simple provider overrides |

### Migration Steps

**1. Replace State Management**
```dart
// OLD (MobX)
class UserProfileStore = _UserProfileStoreBase with _$UserProfileStore;

abstract class _UserProfileStoreBase with Store {
  @observable
  UserProfile? userProfile;
  
  @action
  void setUserProfile(UserProfile profile) {
    userProfile = profile;
  }
}

// NEW (Riverpod)
final userProfileProvider = StateProvider<UserProfile?>((ref) => null);

// Usage change
// OLD: store.setUserProfile(profile)
// NEW: ref.read(userProfileProvider.notifier).state = profile
```

**2. Replace Navigation**
```dart
// OLD
locator<NavigationService>().navigateTo('/product-detail', arguments: productId);

// NEW
context.goNamed('product-detail', pathParameters: {'id': productId});
```

**3. Replace Service Locator**
```dart
// OLD
void setupServiceLocator() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<ApiClient>(ApiClient());
}
final authService = locator<AuthService>();

// NEW
final authServiceProvider = Provider<AuthService>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthService(repository);
});
// Usage: ref.read(authServiceProvider)
```

**4. Simplify Demo Mode**
```dart
// OLD: Runtime switching with service locator
if (kDemoMode) {
  locator.registerSingleton<UserRepository>(DemoUserRepository());
} else {
  locator.registerSingleton<UserRepository>(UserRepositoryImpl());
}

// NEW: Compile-time or runtime detection
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return Env.isDemoMode ? DemoUserRepository() : UserRepositoryImpl(ref.watch(dioProvider));
});
```

---

## 11. Testing Strategy

### Unit Testing with Riverpod

```dart
// test/features/auth/auth_provider_test.dart
void main() {
  test('signIn success updates state to authenticated', () async {
    // Create mock repository
    final mockRepository = MockAuthRepository();
    when(mockRepository.signInWithGoogle())
        .thenAnswer((_) async => User(id: '1', email: 'test@example.com'));
    
    // Create container with override
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    
    // Get notifier
    final notifier = container.read(authProvider.notifier);
    
    // Execute
    await notifier.signIn();
    
    // Verify
    final state = container.read(authProvider);
    expect(state, isA<Authenticated>());
    expect((state as Authenticated).user.email, 'test@example.com');
  });
}
```

### Widget Testing

```dart
// test/features/auth/login_page_test.dart
void main() {
  testWidgets('shows loading indicator during sign in', (tester) async {
    final mockRepository = MockAuthRepository();
    when(mockRepository.signInWithGoogle())
        .thenAnswer((_) => Future.delayed(Duration(seconds: 2), () => User(...)));
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockRepository),
        ],
        child: MaterialApp(home: LoginPage()),
      ),
    );
    
    // Tap sign in button
    await tester.tap(find.text('Sign in with Google'));
    await tester.pump();
    
    // Verify loading indicator appears
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

---

## 12. Performance Optimization

### Riverpod Performance Features

**1. Automatic Disposal**
```dart
// Providers auto-dispose when not watched
final productProvider = FutureProvider.autoDispose.family<Product, String>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProduct(id);
});
```

**2. Caching with KeepAlive**
```dart
final userProfileProvider = FutureProvider<UserProfile>((ref) async {
  // Keep alive even when not watched
  ref.keepAlive();
  
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUserProfile();
});
```

**3. Selective Rebuilds**
```dart
// Only rebuild when specific field changes
class ProductPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only rebuild when product name changes
    final productName = ref.watch(productProvider.select((p) => p.name));
    
    return Text(productName);
  }
}
```

---

## 13. Security Best Practices

### Secure Storage for API Keys

```dart
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

// Usage in repository
@override
Future<void> saveApiKey(String provider, String apiKey) async {
  final storage = _secureStorage;
  await storage.write(key: 'ai_key_$provider', value: apiKey);
}
```

### OAuth Token Management

```dart
final tokenProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(secureStorageProvider);
  return storage.read(key: 'auth_token');
});

// Dio interceptor
class AuthInterceptor extends Interceptor {
  final Ref ref;
  
  AuthInterceptor(this.ref);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await ref.read(tokenProvider.future);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
```

---

## Summary: Why This Architecture Works Better

### Simplicity
- ✅ Less boilerplate (no MobX codegen for most cases)
- ✅ Standard Flutter patterns (Riverpod is Flutter-native)
- ✅ Easier to understand for new developers

### Maintainability
- ✅ Clear feature-based structure
- ✅ Easy to test (provider overrides)
- ✅ Less magic, more explicit

### Performance
- ✅ Efficient rebuilds (Riverpod optimization)
- ✅ Automatic disposal
- ✅ Better web compatibility

### Developer Experience
- ✅ Faster builds (less code generation)
- ✅ Better error messages
- ✅ Hot reload works reliably
- ✅ Type-safe routing with GoRouter

---

**Recommendation:** Use this v2 architecture for regenerating the app. It addresses all the issues encountered in v1 while maintaining clean architecture principles.

**Estimated Migration Time:** 8-10 sprints (16-20 weeks) for complete rebuild

**Next Steps:**
1. Set up project structure
2. Implement authentication feature (reference implementation)
3. Implement other features following the pattern
4. Test thoroughly
5. Deploy

---

**Document Owner:** Engineering Team  
**Last Updated:** November 18, 2025  
**Status:** Recommended for Production
