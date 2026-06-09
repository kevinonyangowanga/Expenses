import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/auth/services/auth_service.dart';

final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationServiceProvider).firebaseAuth.authStateChanges();
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authenticationServiceProvider);
  return AuthNotifier(authService);
});

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  AuthState(this.status, {this.errorMessage});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationService _authService;

  AuthNotifier(this._authService) : super(AuthState(AuthStatus.initial));

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = AuthState(AuthStatus.loading);
    final user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      state = AuthState(AuthStatus.authenticated);
    } else {
      state = AuthState(AuthStatus.error, errorMessage: 'Invalid credentials');
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    state = AuthState(AuthStatus.loading);
    final user = await _authService.createUserWithEmailAndPassword(email, password);
    if (user != null) {
      state = AuthState(AuthStatus.authenticated);
    } else {
      state = AuthState(AuthStatus.error, errorMessage: 'Registration failed');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = AuthState(AuthStatus.unauthenticated);
  }

  Future<void> authenticateWithBiometrics() async {
    final isAuthenticated = await _authService.authenticateWithBiometrics();
    if (isAuthenticated) {
      final credentials = await _authService.getSavedCredentials();
      if (credentials['email'] != null && credentials['password'] != null) {
        await signInWithEmailAndPassword(
            credentials['email']!, credentials['password']!);
      }
    }
  }
}
