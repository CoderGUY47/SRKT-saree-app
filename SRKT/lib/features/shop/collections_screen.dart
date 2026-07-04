import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final List<Map<String, dynamic>> _collections = [
    {
      'name': 'Bridal Collection',
      'count': '120+ Items',
      'desc': 'Exquisite bridal sarees for the perfect wedding day.',
      'image': 'assets/images/products/dress-1.png',
      'badge': 'TRENDING',
      'badgeColor': Color(0xFF700D28),
      'price': '₹4,850',
    },
    {
      'name': 'Festive Edit',
      'count': '95+ Items',
      'desc': 'Vibrant and elegant choices for every celebration.',
      'image': 'assets/images/products/dress-2.png',
      'badge': 'NEW',
      'badgeColor': Color(0xFFC59B27),
      'price': '₹3,250',
    },
    {
      'name': 'Party Wear',
      'count': '140+ Items',
      'desc': 'Statement sarees to turn heads at any party.',
      'image': 'assets/images/products/dress-3.png',
      'badge': 'BESTSELLER',
      'badgeColor': Color(0xFF700D28),
      'price': '₹2,950',
    },
    {
      'name': 'Casual Sarees',
      'count': '80+ Items',
      'desc': 'Comfortable, everyday elegance for modern women.',
      'image': 'assets/images/products/dress-4.png',
      'badge': 'NEW',
      'badgeColor': Color(0xFFC59B27),
      'price': '₹1,850',
    },
    {
      'name': 'Silk Heritage',
      'count': '160+ Items',
      'desc': 'Classic silk sarees celebrating Indian textile tradition.',
      'image': 'assets/images/products/dress-5.png',
      'badge': 'TRENDING',
      'badgeColor': Color(0xFF700D28),
      'price': '₹5,250',
    },
    {
      'name': 'Cotton Luxe',
      'count': '70+ Items',
      'desc': 'Premium cotton with luxurious craftsmanship.',
      'image': 'assets/images/products/dress-6.png',
      'badge': 'NEW',
      'badgeColor': Color(0xFFC59B27),
      'price': '₹2,150',
    },
    {
      'name': 'Designer Studio',
      'count': '55+ Items',
      'desc': 'Curated designer pieces for the discerning buyer.',
      'image': 'assets/images/products/dress-7.png',
      'badge': 'EXCLUSIVE',
      'badgeColor': Color(0xFF700D28),
      'price': '₹6,450',
    },
    {
      'name': 'Premium Range',
      'count': '90+ Items',
      'desc': 'Top-tier wholesale collection for premium buyers.',
      'image': 'assets/images/products/dress-8.png',
      'badge': 'PREMIUM',
      'badgeColor': Color(0xFFC59B27),
      'price': '₹3,950',
    },
    {
      'name': 'Embroidery Edit',
      'count': '65+ Items',
      'desc': 'Hand-embroidered masterpieces for special occasions.',
      'image': 'assets/images/products/dress-1.png',
      'badge': 'HANDCRAFTED',
      'badgeColor': Color(0xFF700D28),
      'price': '₹4,150',
    },
    {
      'name': 'Wedding Season',
      'count': '110+ Items',
      'desc': 'Everything you need for the wedding season.',
      'image': 'assets/images/products/dress-2.png',
      'badge': 'SEASON',
      'badgeColor': Color(0xFFC59B27),
      'price': '₹3,750',
    },
  ];

  final String _selectedFilter = 'All';

  void _showToast(String message) {
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
                Text(
                  message,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 2200), () => entry.remove());
  }

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
          'Collections',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          // Wishlist badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.wishlistCountNotifier,
            builder: (context, wishlistCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border_rounded,
                        color: Color(0xFF7A6F6F), size: 24),
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
          // Cart badge
          ValueListenableBuilder<int>(
            valueListenable: AppState.cartCountNotifier,
            builder: (context, cartCount, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Color(0xFF7A6F6F), size: 24),
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
      body: CustomScrollView(
        slivers: [
          // Header Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF700D28), Color(0xFF9C1A3C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Curated Collections',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Premium wholesale sarees, handpicked for your boutique.',
                            style: GoogleFonts.manrope(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 11.5,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC59B27),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${_collections.length} Collections Available',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/products/dress-1.png',
                        width: 90,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 90,
                          height: 100,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Collections Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final col = _collections[index];
                  final isWishlisted = AppState.isWishlisted(col['name']);
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/product-details'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                                            color: Color(0xFFC59B27), size: 32),
                                      ),
                                    ),
                                  ),
                                ),
                                // Badge
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
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                                ),
                                // Wishlist
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      AppState.toggleWishlist({
                                        'name': col['name'],
                                        'color': 'Multi',
                                        'moq': 'MOQ: 5 Pieces',
                                        'price': col['price'],
                                        'priceInt': 2850,
                                        'originalPrice': '₹4,200',
                                        'badge': col['badge'],
                                        'badgeColor': col['badgeColor'],
                                        'image': col['image'],
                                      });
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
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    col['name'],
                                    style: GoogleFonts.playfairDisplay(
                                      color: const Color(0xFF4A0516),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    col['count'],
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFF7A6F6F),
                                      fontSize: 9.5,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        col['price'],
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFF700D28),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          AppState.addToCart(
                                            name: col['name'],
                                            color: 'Multi',
                                            moq: 'MOQ: 5 Pieces',
                                            price: 2850,
                                            originalPrice: '₹4,200',
                                            badge: col['badge'],
                                            badgeColor: col['badgeColor'],
                                            image: col['image'],
                                          );
                                          setState(() {});
                                          _showToast('${col['name']} added to cart!');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF700D28),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                      ),
                                    ],
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
                childCount: _collections.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.62,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
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
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/categories');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/wishlist');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/cart');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/account');
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              activeIcon: Icon(Icons.favorite),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person),
              label: 'Account'),
        ],
      ),
    );
  }
}
