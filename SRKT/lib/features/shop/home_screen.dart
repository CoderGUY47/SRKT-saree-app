import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // WhatsApp Bottom Banner State
  bool _showWhatsAppBanner = true;
  double _whatsAppBannerOpacity = 1.0;
  Timer? _whatsAppBannerTimer;

  // Banner Carousel State
  int _currentBannerIndex = 0;
  PageController? _pageController;
  Timer? _carouselTimer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Page controller for the banner slider (starts at 1000 for infinite loop scrolling)
    _pageController = PageController(initialPage: 1000);

    // Auto-scroll the banner slider every 5 seconds
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController != null && _pageController!.hasClients) {
        _pageController!.nextPage(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        );
      }
    });

    _whatsAppBannerTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _whatsAppBannerOpacity = 0.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _whatsAppBannerTimer?.cancel();
    _pageController?.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  // Sample product data
  final List<Map<String, dynamic>> _products = [
    {
      'image': 'assets/images/products/dress-1.png',
      'name': 'Banarasi Silk Saree',
      'color': 'Maroon',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,850',
      'priceInt': 2850,
      'originalPrice': '₹3,950',
      'badge': 'NEW',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-2.png',
      'name': 'Kanjeevaram Silk Saree',
      'color': 'Green',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,650',
      'priceInt': 2650,
      'originalPrice': '₹3,650',
      'badge': 'TRENDING',
      'badgeColor': const Color(0xFF700D28),
    },
    {
      'image': 'assets/images/products/dress-3.png',
      'name': 'Organza Designer Saree',
      'color': 'Purple',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,950',
      'priceInt': 2950,
      'originalPrice': '₹4,150',
      'badge': 'BESTSELLER',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-4.png',
      'name': 'Georgette Party Saree',
      'color': 'Blue',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,750',
      'priceInt': 2750,
      'originalPrice': '₹3,850',
      'badge': 'NEW',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-5.png',
      'name': 'Mysore Silk Saree',
      'color': 'Gold',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,850',
      'priceInt': 2850,
      'originalPrice': '₹3,950',
      'badge': 'TRENDING',
      'badgeColor': const Color(0xFF700D28),
    },
    {
      'image': 'assets/images/products/dress-6.png',
      'name': 'Bandhani Cotton Saree',
      'color': 'Maroon',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,650',
      'priceInt': 2650,
      'originalPrice': '₹3,650',
      'badge': 'BESTSELLER',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-7.png',
      'name': 'Patola Designer Saree',
      'color': 'Green',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,950',
      'priceInt': 2950,
      'originalPrice': '₹4,150',
      'badge': 'NEW',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-8.png',
      'name': 'Chanderi Cotton Saree',
      'color': 'Blue',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,750',
      'priceInt': 2750,
      'originalPrice': '₹3,850',
      'badge': 'TRENDING',
      'badgeColor': const Color(0xFF700D28),
    },
  ];

  // Collections row data (horizontal slider)
  final List<Map<String, dynamic>> _collections = [
    {'image': 'assets/images/products/dress-1.png', 'name': 'Bridal Collection'},
    {'image': 'assets/images/products/dress-2.png', 'name': 'Festive Edit'},
    {'image': 'assets/images/products/dress-3.png', 'name': 'Party Wear'},
    {'image': 'assets/images/products/dress-4.png', 'name': 'Casual Sarees'},
    {'image': 'assets/images/products/dress-5.png', 'name': 'Silk Heritage'},
    {'image': 'assets/images/products/dress-6.png', 'name': 'Cotton Luxe'},
    {'image': 'assets/images/products/dress-7.png', 'name': 'Designer Studio'},
    {'image': 'assets/images/products/dress-8.png', 'name': 'Premium Range'},
  ];

  // Category data
  final List<Map<String, String>> _categories = [
    {'name': 'Silk Sarees', 'image': 'assets/images/products/dress-1.png'},
    {'name': 'Cotton Sarees', 'image': 'assets/images/products/dress-2.png'},
    {'name': 'Designer Sarees', 'image': 'assets/images/products/dress-3.png'},
    {'name': 'Party Wear', 'image': 'assets/images/products/dress-4.png'},
    {'name': 'New Arrivals', 'image': 'assets/images/products/dress-5.png'},
  ];

  void _showToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => Positioned(
        top: 60,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(message,
                    style: GoogleFonts.manrope(
                        color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 2500), () => entry.remove());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFFAF6F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF6F0),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.notes_rounded, color: Color(0xFF700D28), size: 28), // Unique offset hamburger menu icon
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/ui/logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const Icon(
                Icons.filter_vintage_outlined,
                color: Color(0xFFC59B27),
                size: 28,
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SRKT',
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xFF700D28),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'COLLECTION',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF7A6F6F),
                    fontSize: 7.5,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          // Search
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF7A6F6F), size: 26),
            onPressed: () {},
          ),
          // Notification — no badge count shown
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF7A6F6F), size: 26),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          // Wishlist — reactive badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.wishlistCountNotifier,
            builder: (context, wishlistCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded, color: Color(0xFF7A6F6F), size: 26),
                    onPressed: () => Navigator.pushNamed(context, '/wishlist'),
                  ),
                  if (wishlistCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF700D28),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '$wishlistCount',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // Cart — reactive badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.cartCountNotifier,
            builder: (context, cartCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF7A6F6F), size: 26),
                    onPressed: () => Navigator.pushNamed(context, '/cart'),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF700D28),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Banner Slider
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1774 / 887,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentBannerIndex = index % 5;
                          });
                        },
                        itemBuilder: (context, index) {
                          final slideIndex = index % 5;
                          return _buildBannerSlide(
                            imagePath: 'assets/images/ui/banner-${slideIndex + 1}.png',
                          );
                        },
                      ),
                      // Dot indicator on the left side
                      Positioned(
                        left: 16,
                        bottom: 20,
                        child: Row(
                          children: List.generate(5, (index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 6),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentBannerIndex == index
                                    ? const Color(0xFFC59B27)
                                    : Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Horizontal Categories list
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return GestureDetector(
                    onTap: () {
                      if (category['name'] == 'Silk Sarees') {
                        Navigator.pushNamed(context, '/products');
                      } else {
                        Navigator.pushNamed(context, '/categories');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFC59B27),
                                width: 1.5,
                              ),
                              image: DecorationImage(
                                image: AssetImage(category['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name']!,
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF4A0516),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 3. Popular Picks Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Picks',
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFF4A0516),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/categories'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF700D28),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF700D28),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 4. Product Grid (8 items) — wired Add to Cart & Wishlist
            ValueListenableBuilder<int>(
              valueListenable: AppState.wishlistCountNotifier,
              builder: (context, _, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    final isWishlisted = AppState.isWishlisted(product['name']);
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/product-details'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 16,
                              spreadRadius: 2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image & Badges
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      product['image'],
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Badge
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: product['badgeColor'],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        product['badge'],
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Wishlist Heart
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        AppState.toggleWishlist(product);
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isWishlisted
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border_rounded,
                                          color: const Color(0xFF700D28),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Details
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: GoogleFonts.playfairDisplay(
                                      color: const Color(0xFF4A0516),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    product['moq'],
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFF7A6F6F),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        product['price'],
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFF700D28),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        product['originalPrice'],
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFFB0A8A8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Add to Cart Button — wired to AppState
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        AppState.addToCart(
                                          name: product['name'],
                                          color: product['color'],
                                          moq: product['moq'],
                                          price: product['priceInt'],
                                          originalPrice: product['originalPrice'],
                                          badge: product['badge'],
                                          badgeColor: product['badgeColor'],
                                          image: product['image'],
                                        );
                                        setState(() {});
                                        _showToast(context,
                                            '${product['name']} added to cart!');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF700D28),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.shopping_cart_outlined, size: 14),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Add to Cart',
                                            style: GoogleFonts.manrope(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 28),

            // 5. Collections Section — horizontal image slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Collections',
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFF4A0516),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/categories'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF700D28),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Color(0xFF700D28), size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _collections.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final col = _collections[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/product-details'),
                    child: Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 14,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.asset(
                              col['image'],
                              width: 140,
                              height: 155,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                width: 140,
                                height: 155,
                                color: const Color(0xFFF5EBE0),
                                child: const Icon(Icons.image_outlined,
                                    color: Color(0xFFC59B27), size: 36),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              col['name'],
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFF4A0516),
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 6. WhatsApp Section at bottom (vanishes after 5 seconds)
            if (_showWhatsAppBanner)
              AnimatedOpacity(
                opacity: _whatsAppBannerOpacity,
                duration: const Duration(milliseconds: 500),
                onEnd: () {
                  if (_whatsAppBannerOpacity == 0.0) {
                    setState(() {
                      _showWhatsAppBanner = false;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/ui/whatsapp.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Need Help or Have Questions?',
                                style: GoogleFonts.playfairDisplay(
                                  color: const Color(0xFF4A0516),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Chat with us for product details, MOQ, and bulk orders.',
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF7A6F6F),
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF075E54),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Chat on WhatsApp',
                                style: GoogleFonts.manrope(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right_rounded, size: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<String>(
        valueListenable: AppState.whatsAppNumberNotifier,
        builder: (context, whatsAppNum, _) {
          return FloatingActionButton.small(
            onPressed: () async {
              final whatsappUrl = Uri.parse(
                  'https://wa.me/$whatsAppNum?text=Hello%20SRKT%20Collection%2C%20I%20have%20a%20query%20about%20your%20products.');
              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(whatsappUrl, mode: LaunchMode.platformDefault);
              }
            },
            backgroundColor: Colors.transparent,
            elevation: 4,
            highlightElevation: 0,
            child: Container(
              padding: const EdgeInsets.all(4), // White circle wrapper padding
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/ui/whatsapp.png',
                width: 36,
                height: 36,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFAF6F0),
        child: Column(
          children: [
            // Drawer Header
            ValueListenableBuilder<String>(
              valueListenable: AppState.loggedInUserAvatarNotifier,
              builder: (context, imagePath, _) {
                final isNetwork = imagePath.startsWith('http') || imagePath.startsWith('https');
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xFF700D28),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFC59B27), width: 1.5),
                        ),
                        child: ClipOval(
                          child: isNetwork
                              ? Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(Icons.person, color: Colors.white, size: 36),
                                )
                              : Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(Icons.person, color: Colors.white, size: 36),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ValueListenableBuilder<String>(
                              valueListenable: AppState.loggedInUserNameNotifier,
                              builder: (context, name, _) {
                                return Text(
                                  name,
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable: AppState.loggedInUserEmailNotifier,
                              builder: (context, email, _) {
                                if (email == 'Not Provided') {
                                  return ValueListenableBuilder<String>(
                                    valueListenable: AppState.loggedInUserPhoneNotifier,
                                    builder: (context, phone, _) {
                                      return Text(
                                        phone,
                                        style: GoogleFonts.manrope(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 11,
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Text(
                                  email,
                                  style: GoogleFonts.manrope(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 11,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC59B27),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Wholesale Member',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Navigation items list
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.home_rounded, color: Color(0xFF700D28)),
                    title: Text(
                      'Home',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF4A0516),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.grid_view_rounded, color: Color(0xFF700D28)),
                    title: Text('Categories', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/categories');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.filter_vintage_rounded, color: Color(0xFF700D28)),
                    title: Text('Collections', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/collections');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_rounded, color: Color(0xFF700D28)),
                    title: Text('Wishlist', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/wishlist');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_rounded, color: Color(0xFF700D28)),
                    title: Text('My Cart / Orders', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard_rounded, color: Color(0xFF700D28)),
                    title: Text('Admin Dashboard', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/admin');
                    },
                  ),
                  const Divider(color: Color(0xFFE8E5E5)),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: Color(0xFF700D28)),
                    title: Text('Logout', style: GoogleFonts.manrope(color: const Color(0xFF4A0516))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF700D28),
        unselectedItemColor: const Color(0xFF7A6F6F),
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/categories');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/wishlist');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/account');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSlide({required String imagePath}) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF700D28),
              child: const Center(
                child: Icon(Icons.image_outlined, color: Colors.white, size: 40),
              ),
            );
          },
        ),
        // Shop Now button — bottom-right
        Positioned(
          right: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/categories'),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF420210),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Shop Now',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
