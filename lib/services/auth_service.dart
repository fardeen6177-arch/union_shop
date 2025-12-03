// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';

/// Authentication service with mock implementation
/// Can be replaced with Firebase Auth when credentials are available
class AuthService {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Initialize auth service and restore session
  Future<void> initialize() async {
    await _loadMockUser();
  }

  /// Sign in with email and password (mock implementation)
  Future<AppUser> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Create mock user
    _currentUser = AppUser(
      id: 'user_${email.hashCode}',
      email: email,
      displayName: email.split('@')[0],
      createdAt: DateTime.now(),
    );

    await _saveMockUser();
    return _currentUser!;
  }

  /// Sign up with email and password (mock implementation)
  Future<AppUser> signUp(String email, String password, String displayName) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock validation
    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      throw Exception('All fields are required');
    }

    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Create mock user
    _currentUser = AppUser(
      id: 'user_${email.hashCode}',
      email: email,
      displayName: displayName,
      createdAt: DateTime.now(),
    );

    await _saveMockUser();
    return _currentUser!;
  }

  /// Sign out
  Future<void> signOut() async {
    _currentUser = null;
    await _clearMockUser();
  }

  /// Reset password (mock implementation)
  Future<void> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Invalid email address');
    }

    // In a real implementation, this would send a password reset email
    // For mock, we just simulate success
  }

  /// Save mock user to SharedPreferences
  Future<void> _saveMockUser() async {
    if (_currentUser == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.mockUserIdKey, _currentUser!.id);
    await prefs.setString(AppConstants.mockUserEmailKey, _currentUser!.email);
    await prefs.setString(AppConstants.mockUserNameKey, _currentUser!.displayName);
  }

  /// Load mock user from SharedPreferences
  Future<void> _loadMockUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(AppConstants.mockUserIdKey);
    final userEmail = prefs.getString(AppConstants.mockUserEmailKey);
    final userName = prefs.getString(AppConstants.mockUserNameKey);

    if (userId != null && userEmail != null && userName != null) {
      _currentUser = AppUser(
        id: userId,
        email: userEmail,
        displayName: userName,
        createdAt: DateTime.now(),
      );
    }
  }

  /// Clear mock user from SharedPreferences
  Future<void> _clearMockUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.mockUserIdKey);
    await prefs.remove(AppConstants.mockUserEmailKey);
    await prefs.remove(AppConstants.mockUserNameKey);
  }
}
