// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isInitialized = false;

  AppUser? get currentUser => _authService.currentUser;
  bool get isLoggedIn => _authService.isLoggedIn;
  bool get isInitialized => _isInitialized;

  /// Initialize auth service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _authService.initialize();
    _isInitialized = true;
    notifyListeners();
  }

  /// Sign in
  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Sign up
  Future<void> signUp(String email, String password, String displayName) async {
    try {
      await _authService.signUp(email, password, displayName);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _authService.signOut();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }
}
