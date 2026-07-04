import 'package:flutter/material.dart';
import 'features/auth/welcome_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/auth/forgot_password_screen.dart';
import 'features/shop/home_screen.dart';
import 'features/shop/categories_screen.dart';
import 'features/shop/products_screen.dart';
import 'features/shop/notifications_screen.dart';
import 'features/shop/wishlist_screen.dart';
import 'features/shop/product_details_screen.dart';
import 'features/shop/account_screen.dart';
import 'features/shop/collections_screen.dart';
import 'features/checkout/cart_screen.dart';
import 'features/checkout/checkout_screen.dart';
import 'features/checkout/order_success_screen.dart';
import 'features/admin/admin_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Srkt Collection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF700D28)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/products': (context) => const ProductsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/cart': (context) => const CartScreen(),
        '/product-details': (context) => const ProductDetailsScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/order-success': (context) => const OrderSuccessScreen(),
        '/account': (context) => const AccountScreen(),
        '/collections': (context) => const CollectionsScreen(),
        '/signup': (context) => const SignupScreen(),
        '/admin': (context) => const AdminDashboardScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}
