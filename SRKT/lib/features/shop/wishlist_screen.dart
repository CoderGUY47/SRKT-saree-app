import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Map<String, dynamic>> get _savedItems => AppState.wishlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFBFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _savedItems.isEmpty
              ? 'My Wishlist'
              : 'My Wishlist (${_savedItems.length})',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          // Live cart count badge
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
          const SizedBox(width: 8),
        ],
      ),
      body: _savedItems.isEmpty ? _buildEmptyState(context) : _buildList(),
      bottomNavigationBar: _savedItems.isEmpty
          ? _buildBottomNav()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sticky Footer only when items exist
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCEFF1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Color(0xFF700D28),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_savedItems.length} Items Saved',
                                style: GoogleFonts.playfairDisplay(
                                  color: const Color(0xFF4A0516),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Ready for wholesale order',
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF7A6F6F),
                                  fontSize: 9.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                        icon: const Icon(Icons.shopping_cart_outlined, size: 14),
                        label: Text(
                          'Move All to Cart',
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF700D28),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBottomNav(),
              ],
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Stack(
      children: [
        // Subtle floral background pattern
        Positioned.fill(
          child: Opacity(
            opacity: 0.04,
            child: Image.asset(
              'assets/images/ui/admin.png',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox(),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sparkly heart icon in circles
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5EBE0).withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0DED0).withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDD5C4).withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: Color(0xFF7A6F6F),
                        size: 36,
                      ),
                    ),
                    // Sparkle dots
                    const Positioned(
                        top: 10, left: 22,
                        child: Icon(Icons.diamond_outlined, color: Color(0xFFC59B27), size: 10)),
                    const Positioned(
                        top: 10, right: 22,
                        child: Icon(Icons.diamond_outlined, color: Color(0xFFC59B27), size: 8)),
                    const Positioned(
                        bottom: 16, left: 14,
                        child: Icon(Icons.diamond_outlined, color: Color(0xFFC59B27), size: 6)),
                    const Positioned(
                        bottom: 16, right: 14,
                        child: Icon(Icons.diamond_outlined, color: Color(0xFFC59B27), size: 9)),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  'Your wishlist is empty',
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xFF700D28),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Gold divider with diamond
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 1, color: const Color(0xFFC59B27)),
                    const SizedBox(width: 8),
                    const Icon(Icons.diamond_outlined, color: Color(0xFFC59B27), size: 10),
                    const SizedBox(width: 8),
                    Container(width: 40, height: 1, color: const Color(0xFFC59B27)),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Save your favorite sarees\nto buy them later.',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF7A6F6F),
                    fontSize: 14,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/categories'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF700D28),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Explore Now',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gold saved-collection header card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0E2CA)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9F3E8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFC59B27),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Saved Collection',
                          style: GoogleFonts.playfairDisplay(
                            color: const Color(0xFF4A0516),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_savedItems.length} premium sarees ready for your next order.',
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

          // Wishlist Cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _savedItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = _savedItems[index];
              final badgeColor = item['badgeColor'] ?? const Color(0xFFC59B27);
              return Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.asset(
                            item['image'] ?? 'assets/images/products/dress-1.png',
                            width: 110,
                            height: 130,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              width: 110,
                              height: 130,
                              color: const Color(0xFFF5EBE0),
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
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['badge'] ?? 'NEW',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 7.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFF4A0516),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Color: ${item['color'] ?? ''}   MOQ: ${item['moq'] ?? ''}',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF7A6F6F),
                                fontSize: 10.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  item['price'] ?? '',
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF700D28),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  item['originalPrice'] ?? '',
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFFB0A8A8),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E7D32),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'In Stock',
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF2E7D32),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 12.0, top: 12.0, bottom: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              AppState.toggleWishlist(item);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFCEFF1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFF700D28),
                                size: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded,
                                color: Color(0xFF7A6F6F), size: 18),
                            onPressed: () {
                              AppState.toggleWishlist(item);
                              setState(() {});
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 2,
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
    );
  }
}
