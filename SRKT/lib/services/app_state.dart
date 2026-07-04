import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String color;
  final String moq;
  final int price;
  final String originalPrice;
  final String badge;
  final dynamic badgeColor;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.color,
    required this.moq,
    required this.price,
    required this.originalPrice,
    required this.badge,
    required this.badgeColor,
    required this.image,
    this.quantity = 1,
  });
}

class AppState {
  // --------------- Cart ---------------
  static final List<CartItem> cart = [];
  static final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  static void addToCart({
    required String name,
    required String color,
    required String moq,
    required int price,
    required String originalPrice,
    required String badge,
    required dynamic badgeColor,
    required String image,
  }) {
    final existingIndex =
        cart.indexWhere((item) => item.name == name && item.color == color);
    if (existingIndex >= 0) {
      cart[existingIndex].quantity += 1;
    } else {
      cart.add(CartItem(
        name: name,
        color: color,
        moq: moq,
        price: price,
        originalPrice: originalPrice,
        badge: badge,
        badgeColor: badgeColor,
        image: image,
        quantity: 1,
      ));
    }
    _updateCartCount();

    // Fire a real notification
    addNotification(
      title: 'Added to Cart',
      desc: '"$name" (Color: $color) was added to your wholesale cart.',
      type: 'CART',
    );
  }

  static void removeFromCart(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      _updateCartCount();
    }
  }

  static void updateCartQuantity(int index, int newQty) {
    if (index >= 0 && index < cart.length && newQty > 0) {
      cart[index].quantity = newQty;
      _updateCartCount();
    }
  }

  static void clearCart() {
    cart.clear();
    _updateCartCount();
  }

  static void _updateCartCount() {
    int total = 0;
    for (final item in cart) {
      total += item.quantity;
    }
    cartCountNotifier.value = total;
  }

  // --------------- Wishlist ---------------
  static final List<Map<String, dynamic>> wishlist = [];
  static final ValueNotifier<int> wishlistCountNotifier = ValueNotifier<int>(0);

  /// Returns true if item was added, false if removed.
  static bool toggleWishlist(Map<String, dynamic> item) {
    final name = item['name'] as String;
    final idx = wishlist.indexWhere((e) => e['name'] == name);
    if (idx >= 0) {
      wishlist.removeAt(idx);
      wishlistCountNotifier.value = wishlist.length;
      addNotification(
        title: 'Removed from Wishlist',
        desc: '"$name" was removed from your saved collection.',
        type: 'WISHLIST',
      );
      return false;
    } else {
      wishlist.add(Map<String, dynamic>.from(item));
      wishlistCountNotifier.value = wishlist.length;
      addNotification(
        title: 'Added to Wishlist',
        desc: '"$name" was saved to your collection.',
        type: 'WISHLIST',
      );
      return true;
    }
  }

  static bool isWishlisted(String name) {
    return wishlist.any((e) => e['name'] == name);
  }

  // --------------- Notifications ---------------
  // Starts EMPTY — only real user-action messages appear
  static final List<Map<String, String>> notifications = [];
  static final ValueNotifier<int> notificationCountNotifier =
      ValueNotifier<int>(0);

  static void addNotification({
    required String title,
    required String desc,
    required String type,
  }) {
    notifications.insert(0, {
      'title': title,
      'desc': desc,
      'time': 'Just now',
      'type': type,
    });
    notificationCountNotifier.value = notifications.length;
  }

  // --------------- Registered Users Map ---------------
  static final Map<String, Map<String, String>> registeredUsers = {};

  static void registerUser({
    required String email,
    required String name,
    required String password,
    required String role, // 'client' or 'admin'
    String? businessName,
  }) {
    final cleanEmail = email.toLowerCase().trim();
    final cleanName = name.toLowerCase().trim();
    final userData = {
      'email': email.trim(),
      'name': name.trim(),
      'password': password.trim(),
      'role': role,
      'businessName': businessName ?? '',
    };
    registeredUsers[cleanEmail] = userData;
    registeredUsers[cleanName] = userData;
  }

  // --------------- Logged In User State ---------------
  static final ValueNotifier<String> loggedInUserEmailNotifier = ValueNotifier<String>('admingmail.com');
  static final ValueNotifier<String> loggedInUserNameNotifier = ValueNotifier<String>('Nexus Admin');
  static final ValueNotifier<String> loggedInUserAvatarNotifier = ValueNotifier<String>('assets/images/ui/admin.png');
  static final ValueNotifier<String> loggedInUserPhoneNotifier = ValueNotifier<String>('+91 98765 43210');
  static final ValueNotifier<String> loggedInUserBusinessNameNotifier = ValueNotifier<String>('Nexus Saree Emporium');

  /// Called after login succeeds so the notification page shows the login event
  static void recordLogin(String email) {
    final cleanEmail = email.toLowerCase().trim();
    
    if (registeredUsers.containsKey(cleanEmail)) {
      final user = registeredUsers[cleanEmail]!;
      final userEmail = user['email'] ?? '';
      final isDigitsOnly = RegExp(r'^\+?[0-9\s\-]+$').hasMatch(userEmail);
      
      if (isDigitsOnly) {
        loggedInUserPhoneNotifier.value = userEmail;
        loggedInUserEmailNotifier.value = 'Not Provided';
      } else {
        loggedInUserEmailNotifier.value = userEmail;
        loggedInUserPhoneNotifier.value = 'Not Provided';
      }
      
      loggedInUserNameNotifier.value = user['name'] ?? 'User';
      loggedInUserBusinessNameNotifier.value = user['businessName'] ?? 'No Business Name';
      
      if (user['role'] == 'admin') {
        loggedInUserAvatarNotifier.value = 'assets/images/ui/admin.png';
      } else {
        loggedInUserAvatarNotifier.value = 'placeholder'; // Fails asset load to trigger user placeholder icon!
      }
    } else {
      loggedInUserEmailNotifier.value = cleanEmail;
      if (cleanEmail.contains('admin')) {
        loggedInUserNameNotifier.value = 'Nexus Admin';
        loggedInUserPhoneNotifier.value = '+91 98765 43210';
        loggedInUserBusinessNameNotifier.value = 'Nexus Saree Emporium';
        loggedInUserAvatarNotifier.value = 'assets/images/ui/admin.png';
      } else {
        loggedInUserNameNotifier.value = 'Ananya';
        loggedInUserPhoneNotifier.value = '+91 98765 43210';
        loggedInUserBusinessNameNotifier.value = 'Ananya Boutique';
        loggedInUserAvatarNotifier.value = 'assets/images/ui/user-1.jpg';
      }
    }
    
    addNotification(
      title: 'Login Successful',
      desc: 'You signed in as $cleanEmail.',
      type: 'SECURITY',
    );
  }

  // --------------- Profile Image ---------------
  static final ValueNotifier<String> profileImageNotifier =
      ValueNotifier<String>('assets/images/ui/user-1.jpg');

  static void updateProfileImage(String newPathOrUrl) {
    if (newPathOrUrl.trim().isNotEmpty) {
      profileImageNotifier.value = newPathOrUrl.trim();
    }
  }

  // --------------- WhatsApp Settings ---------------
  static final ValueNotifier<String> whatsAppNumberNotifier =
      ValueNotifier<String>('919876543210');

  static void updateWhatsAppNumber(String newNumber) {
    if (newNumber.trim().isNotEmpty) {
      whatsAppNumberNotifier.value = newNumber.trim();
    }
  }
}
