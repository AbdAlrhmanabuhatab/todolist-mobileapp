/// State management provider for authentication.
///
/// Simulates login, registration, and logout flows with artificial
/// delays. Replace the simulated logic with real API calls when
/// connecting to a backend.
library;

import 'package:flutter/foundation.dart';
import 'package:todolist/features/auth/data/models/user_model.dart';

/// Provides reactive authentication state to the widget tree.
///
/// Usage with `provider`:
/// ```dart
/// ChangeNotifierProvider(
///   create: (_) => AuthProvider(),
///   child: const MyApp(),
/// )
/// ```
class AuthProvider extends ChangeNotifier {
  // ─── State ──────────────────────────────────────────────────────────

  UserModel? _currentUser;
  bool _isLoading = false;

  // ─── Public Getters ─────────────────────────────────────────────────

  /// The currently authenticated user, or `null` if not signed in.
  UserModel? get currentUser => _currentUser;

  /// Whether an authentication operation is in progress.
  bool get isLoading => _isLoading;

  /// Whether a user is currently signed in.
  bool get isAuthenticated => _currentUser != null;

  // ─── Authentication Methods ─────────────────────────────────────────

  /// Attempts to sign in with the given [email] and [password].
  ///
  /// Returns `true` on success. The simulated delay mimics a network
  /// round-trip; replace with a real API call in production.
  Future<bool> login(String email, String password) async {
    _setLoading(true);

    try {
      // Simulate network latency.
      await Future<void>.delayed(const Duration(seconds: 1));

      // Accept any non-empty credentials for demonstration purposes.
      if (email.isEmpty || password.isEmpty) {
        return false;
      }

      _currentUser = UserModel(
        name: _displayNameFromEmail(email),
        email: email,
      );

      notifyListeners();
      return true;
    } finally {
      _setLoading(false);
    }
  }

  /// Registers a new account and signs the user in automatically.
  ///
  /// Returns `true` on success. As with [login], the delay is simulated.
  Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    _setLoading(true);

    try {
      // Simulate network latency.
      await Future<void>.delayed(const Duration(seconds: 1));

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        return false;
      }

      _currentUser = UserModel(
        name: name,
        email: email,
      );

      notifyListeners();
      return true;
    } finally {
      _setLoading(false);
    }
  }

  /// Signs the current user out and clears session state.
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // ─── Internal Helpers ───────────────────────────────────────────────

  /// Updates the loading flag and notifies listeners.
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Derives a display name from an email address.
  ///
  /// Example: `jane.doe@example.com` → `Jane Doe`.
  static String _displayNameFromEmail(String email) {
    final localPart = email.split('@').first;
    return localPart
        .split(RegExp(r'[._-]'))
        .map((word) =>
            word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}
