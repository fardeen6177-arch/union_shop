// lib/utils/constants.dart
class AppConstants {
  // App Info
  static const String appName = 'Union Shop';
  static const String appVersion = '1.0.0';

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Layout
  static const double maxContentWidth = 1400;
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 8.0;

  // Cart
  static const double taxRate = 0.10; // 10% tax
  static const int maxCartQuantity = 10;

  // Firebase Collection Names (if using Firebase)
  static const String productsCollection = 'products';
  static const String collectionsCollection = 'collections';
  static const String usersCollection = 'users';
  static const String cartsCollection = 'carts';
  static const String ordersCollection = 'orders';

  // Local Storage Keys
  static const String cartStorageKey = 'cart_items';
  static const String authModeKey = 'auth_mode';
  static const String mockUserIdKey = 'mock_user_id';
  static const String mockUserEmailKey = 'mock_user_email';
  static const String mockUserNameKey = 'mock_user_name';

  // Feature Flags
  static const bool useFirebase = false; // Set to true when Firebase is configured
  static const bool enableMockData = true;
}
