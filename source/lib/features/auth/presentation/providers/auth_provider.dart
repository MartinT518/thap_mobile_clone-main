import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thap/features/auth/domain/entities/user.dart';
import 'package:thap/features/auth/domain/repositories/auth_repository.dart';
import 'package:thap/features/auth/data/providers/auth_repository_provider.dart';

part 'auth_provider.freezed.dart';

/// Authentication state
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}

/// Authentication notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    // Try to restore session on initialization
    _tryRestoreSession();
  }

  /// Try to restore session from stored token
  Future<void> _tryRestoreSession() async {
    state = const AuthState.loading();
    try {
      final success = await _repository.tryRestoreSession();
      if (success) {
        final user = await _repository.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    try {
      final user = await _repository.signInWithGoogle();
      
      // Check if user needs to register
      final isRegistered = await _repository.isRegistered(user.email);
      if (!isRegistered) {
        // User needs to register - for now, we'll auto-register with defaults
        // In a real app, you might want to show a registration screen
        final token = await _repository.register(
          email: user.email,
          name: user.name,
          language: 'en',
          country: 'US',
        );
        
        if (token != null) {
          final registeredUser = user.copyWith(token: token);
          state = AuthState.authenticated(registeredUser);
        } else {
          state = const AuthState.error('Registration failed');
        }
      } else {
        state = AuthState.authenticated(user);
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = const AuthState.loading();
    try {
      await _repository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Refresh user data
  Future<void> refreshUser() async {
    final currentState = state;
    if (currentState is _Authenticated) {
      try {
        final user = await _repository.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      } catch (e) {
        state = AuthState.error(e.toString());
      }
    }
  }
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
