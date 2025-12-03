# Union Shop - Flutter E-commerce Application

A comprehensive e-commerce Flutter application built to demonstrate mobile-first design, state management with Provider, and full-stack features including shopping cart, authentication, search, and product personalization.

## ✨ Features

### Basic Features
- **Homepage**: Hero section, featured collections, and sale products
- **Collections**: Browse all product categories with dynamic grid layout
- **Collection Detail**: View products filtered by collection
- **Product Pages**: Detailed product information with image gallery, variant selection (size/color), stock status, and add-to-cart
- **About Page**: Static information about the store
- **Navigation**: Responsive navbar with search, cart badge, and account access
- **Footer**: Links and copyright information

### Intermediate Features
- **Shopping Cart**: 
  - Add/remove items with quantity controls
  - Price calculations (subtotal, 10% tax, total)
  - Cart persistence using SharedPreferences
  - Real-time cart badge updates
- **Authentication**:
  - Sign up, login, forgot password flows
  - Mock authentication service (Firebase-ready)
  - Account dashboard with profile and order history
  - Session persistence
- **Sale Collection**: Dedicated view for discounted products
- **Responsive Design**: Mobile-first with tablet and desktop breakpoints

### Advanced Features
- **Search & Filtering**:
  - Full-text product search
  - Sort by name and price
  - Filter by stock availability
  - Client-side filtering for performance
- **Print Shack (Personalisation)**:
  - Custom text input
  - Font selection
  - Color picker
  - Live preview
  - Add personalized items to cart
- **Checkout**: Simulated order placement with confirmation

### Software Development Practices
- **Testing**:
  - Unit tests for cart service
  - Unit tests for price calculations
  - Widget test for app initialization
- **CI/CD**: GitHub Actions workflow for automated testing and builds
- **Code Quality**:
  - Null safety throughout
  - Provider state management
  - Proper directory structure
  - Error handling with user-friendly messages
- **Git**: Conventional commits with feature branch workflow

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10+ 
- Dart 3.10+
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd flutter_application_1
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web (Chrome)
   flutter run -d chrome
   
   # For mobile emulator
   flutter run
   ```

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Run with coverage
```bash
flutter test --coverage
```

### Run analyzer
```bash
flutter analyze
```

## 📁 Project Structure

```
lib/
├── config/          # App configuration (theme, routes, etc.)
├── models/          # Data models (Product, Collection, CartItem, User, Order)
├── services/        # Business logic (ProductService, CartService, AuthService, SearchService)
├── providers/       # Provider state management
├── pages/           # Full-page screens
│   └── auth/        # Authentication pages
├── widgets/         # Reusable UI components
├── utils/           # Constants and utilities
└── main.dart        # App entry point

test/
├── unit/            # Unit tests
└── widget/          # Widget tests

assets/
├── data/            # Mock JSON data
└── images/          # Product and collection images
```

## 🎨 State Management

This app uses **Provider** for state management with the following providers:

- **ProductProvider**: Manages products and collections data
- **CartProvider**: Handles shopping cart operations 
- **AuthProvider**: Manages authentication state
- **SearchProvider**: Controls search and filter state

## 🔐 Authentication

The app includes a mock authentication service that can be easily replaced with Firebase Auth:

- **Current**: Mock auth using SharedPreferences for local development
- **Production-ready**: Uncomment Firebase configuration in `AppConstants.useFirebase`

To enable Firebase:
1. Add your `firebase_options.dart`
2. Set `AppConstants.useFirebase = true` in `lib/utils/constants.dart`
3. Run `flutter pub get`

## 💾 Data Persistence

- **Cart**: SharedPreferences for local storage
- **Auth**: Mock user data in SharedPreferences
- **Products**: Loaded from `assets/data/products.json`
- **Collections**: Loaded from `assets/data/collections.json`

## 📦 Mock Data

The app includes 20 mock products across 6 collections:
- New Arrivals
- Best Sellers
- Sale
- T-Shirts
- Hoodies
- Accessories

Edit `assets/data/products.json` and `assets/data/collections.json` to customize.

## 🎯 Features Checklist

### Basic (✅ Complete)
- [x] Homepage with hero section
- [x] Collections page
- [x] Collection detail page
- [x] Product page with variants
- [x] About page
- [x] Navbar and Footer
- [x] Routing with deep links

### Intermediate (✅ Complete)
- [x] Shopping cart with persistence
- [x] Add/remove/update quantities
- [x] Price calculations
- [x] Authentication flows (signup/login/forgot password)
- [x] Account dashboard
- [x] Responsive design  

### Advanced (✅ Complete)
- [x] Search with filtering and sorting
- [x] Personalisation page with live preview
- [x] Checkout flow
- [x] Sale collection

###Software Development Practices (⚠️ In Progress)
- [x] Unit tests for cart and pricing
- [x] Basic widget test
- [x] GitHub Actions CI
- [ ] Widget tests for Product and Cart pages (to be completed)
- [x] Clean git history  
- [ ] Complete README with screenshots

## 🐛 Known Limitations

- **Images**: Placeholder image paths are included but actual images need to be added to `assets/images/`
- **Firebase**: Mock authentication is used by default - Firebase setup Required for production
- **Widget Tests**: Additional widget tests needed for complete coverage
- **Order History**: Currently shows empty state - backend integration needed

## 🔧 Configuration

Key configuration in `lib/utils/constants.dart`:
-  `taxrate`: 10% (0.10)
- `maxCartQuantity`: 10 items per product
- `useFirebase`: false (set to true when Firebase configured)
- Responsive breakpoints: Mobile (600px), Tablet (900px), Desktop (1200px)

## 📸 Screenshots

*To be added: Screenshots showing mobile and desktop views*

## 🚧 Roadmap

- [ ] Add actual product images to assets
- [ ] Implement complete widget test suite
- [ ] Add order history backend integration
- [ ] Implement Firebase authentication
- [ ] Add payment gateway integration
- [ ] Implement product reviews and ratings
- [ ] Add user wishlists
- [ ] Implement push notifications

## 👥 Contributing

This is a coursework project. For production use:
1. Replace mock data with real backend API
2. Configure Firebase for authentication
3. Add actual product images  
4. Implement payment processing
5. Add comprehensive error logging

## 📄 License

This project is for educational purposes.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Provider package for state management
- GoRouter for declarative routing
- Material Design 3 for UI components

---

**Note**: This app is fully functional with mock data and ready for local development. For production deployment, configure Firebase and replace mock data with real backend services.
