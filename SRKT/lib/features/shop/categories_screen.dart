import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // Category items list
  final List<Map<String, String>> _categories = const [
    {
      'name': 'Silk Sarees',
      'count': '150+ Items',
      'image': 'assets/images/products/dress-1.png',
      'route': '/products',
    },
    {
      'name': 'Cotton Sarees',
      'count': '95+ Items',
      'image': 'assets/images/products/dress-2.png',
      'route': '',
    },
    {
      'name': 'Designer Sarees',
      'count': '180+ Items',
      'image': 'assets/images/products/dress-3.png',
      'route': '',
    },
    {
      'name': 'Party Wear Sarees',
      'count': '110+ Items',
      'image': 'assets/images/products/dress-4.png',
      'route': '',
    },
    {
      'name': 'Printed Sarees',
      'count': '90+ Items',
      'image': 'assets/images/products/dress-5.png',
      'route': '',
    },
    {
      'name': 'Festive Collection',
      'count': '130+ Items',
      'image': 'assets/images/products/dress-6.png',
      'route': '',
    },
  ];

  // Occasions list
  final List<Map<String, dynamic>> _occasions = const [
    {'name': 'Wedding\nCollection', 'icon': Icons.favorite_border_rounded},
    {'name': 'Festival\nCollection', 'icon': Icons.wb_sunny_outlined},
    {'name': 'Office\nWear', 'icon': Icons.business_center_outlined},
    {'name': 'Casual\nWear', 'icon': Icons.checkroom_outlined},
    {'name': 'Traditional\nWear', 'icon': Icons.filter_vintage_outlined},
    {'name': 'Reception\nCollection', 'icon': Icons.restaurant_menu_outlined},
    {'name': 'Puja\nCollection', 'icon': Icons.temple_hindu_outlined},
  ];

  // Fabrics list
  final List<Map<String, String>> _fabrics = const [
    {
      'name': 'Banarasi Silk',
      'count': '120+ Items',
      'image': 'assets/images/products/dress-7.png'
    },
    {
      'name': 'Kanjivaram Silk',
      'count': '110+ Items',
      'image': 'assets/images/products/dress-8.png'
    },
    {
      'name': 'Chiffon',
      'count': '90+ Items',
      'image': 'assets/images/products/dress-1.png'
    },
    {
      'name': 'Organza',
      'count': '85+ Items',
      'image': 'assets/images/products/dress-2.png'
    },
    {
      'name': 'Georgette',
      'count': '95+ Items',
      'image': 'assets/images/products/dress-3.png'
    },
    {
      'name': 'Linen Cotton',
      'count': '80+ Items',
      'image': 'assets/images/products/dress-4.png'
    },
  ];

  // Collections — only first 6 shown, rest accessible via Show More
  final List<Map<String, dynamic>> _collections = const [
    {
      'name': 'Bridal Collection',
      'count': '120+ Items',
      'image': 'assets/images/products/dress-1.png',
      'badgeColor': Color(0xFF700D28),
      'badge': 'TRENDING',
    },
    {
      'name': 'Festive Edit',
      'count': '95+ Items',
      'image': 'assets/images/products/dress-2.png',
      'badgeColor': Color(0xFFC59B27),
      'badge': 'NEW',
    },
    {
      'name': 'Party Wear',
      'count': '140+ Items',
      'image': 'assets/images/products/dress-3.png',
      'badgeColor': Color(0xFF700D28),
      'badge': 'BESTSELLER',
    },
    {
      'name': 'Casual Sarees',
      'count': '80+ Items',
      'image': 'assets/images/products/dress-4.png',
      'badgeColor': Color(0xFFC59B27),
      'badge': 'NEW',
    },
    {
      'name': 'Silk Heritage',
      'count': '160+ Items',
      'image': 'assets/images/products/dress-5.png',
      'badgeColor': Color(0xFF700D28),
      'badge': 'TRENDING',
    },
    {
      'name': 'Cotton Luxe',
      'count': '70+ Items',
      'image': 'assets/images/products/dress-6.png',
      'badgeColor': Color(0xFFC59B27),
      'badge': 'NEW',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF6F0),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Categories',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF7A6F6F), size: 26),
            onPressed: () {},
          ),
          // Wishlist badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.wishlistCountNotifier,
            builder: (context, wishlistCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded,
                        color: Color(0xFF7A6F6F), size: 26),
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
                        constraints:
                            const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '$wishlistCount',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // Cart badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.cartCountNotifier,
            builder: (context, cartCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Color(0xFF7A6F6F), size: 26),
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
                        constraints:
                            const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold),
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
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: Color(0xFF7A6F6F)),
                  hintText: 'Search for sarees, collections, fabrics...',
                  hintStyle: GoogleFonts.manrope(
                    color: const Color(0xFFB0A8A8),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE8E5E5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE8E5E5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF700D28), width: 1.5),
                  ),
                ),
              ),
            ),

            // Categories Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return GestureDetector(
                  onTap: () {
                    if (category['route']!.isNotEmpty) {
                      Navigator.pushNamed(context, category['route']!);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Image.asset(
                          category['image']!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          bottom: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name']!,
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                category['count']!,
                                style: GoogleFonts.manrope(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
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
            ),
            const SizedBox(height: 24),

            // Shop by Occasion
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Shop by Occasion',
                style: GoogleFonts.playfairDisplay(
                  color: const Color(0xFF4A0516),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _occasions.length,
                itemBuilder: (context, index) {
                  final occasion = _occasions[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE8E5E5)),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            occasion['icon'] as IconData,
                            color: const Color(0xFFC59B27),
                            size: 26,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            occasion['name'] as String,
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF4A0516),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Popular Fabrics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Fabrics',
                style: GoogleFonts.playfairDisplay(
                  color: const Color(0xFF4A0516),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _fabrics.length,
                itemBuilder: (context, index) {
                  final fabric = _fabrics[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.asset(
                              fabric['image']!,
                              height: 80,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fabric['name']!,
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xFF4A0516),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  fabric['count']!,
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF7A6F6F),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
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
              ),
            ),
            const SizedBox(height: 28),

            // ──────────── Collections Section ────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Collections',
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFF4A0516),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/collections'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Show More',
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
            const SizedBox(height: 12),

            // 6 Collection cards in 2-column grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: _collections.length, // exactly 6
              itemBuilder: (context, index) {
                final col = _collections[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/product-details'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image.asset(
                                  col['image'],
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    color: const Color(0xFFF5EBE0),
                                    child: const Center(
                                      child: Icon(Icons.image_outlined,
                                          color: Color(0xFFC59B27), size: 28),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: col['badgeColor'] as Color,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    col['badge'],
                                    style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Name & count
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  col['name'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xFF4A0516),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  col['count'],
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF7A6F6F),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Show More Button below the 6 cards
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/collections'),
                  icon: const Icon(Icons.grid_view_rounded, size: 16),
                  label: Text(
                    'Show More Collections',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF700D28),
                    side: const BorderSide(color: Color(0xFF700D28), width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Premium Quality Assured Banner
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE8E5E5)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: Color(0xFFC59B27),
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Premium Quality Assured',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF4A0516),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Authentic craftsmanship and carefully selected collections.',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF7A6F6F),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF700D28),
        unselectedItemColor: const Color(0xFF7A6F6F),
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
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
}
