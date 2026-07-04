import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  // Wishlist state for each product in the grid
  final List<bool> _wishlistState = List.generate(6, (_) => false);

  final List<Map<String, dynamic>> _sarees = [
    {
      'image': 'assets/images/products/dress-1.png',
      'name': 'Banarasi Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,499',
      'originalPrice': '₹3,499',
      'badge': 'BESTSELLER',
      'badgeColor': const Color(0xFFC59B27),
    },
    {
      'image': 'assets/images/products/dress-2.png',
      'name': 'Kanjivaram Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,399',
      'originalPrice': '₹3,299',
      'badge': 'TRENDING',
      'badgeColor': const Color(0xFF2E7D32),
    },
    {
      'image': 'assets/images/products/dress-3.png',
      'name': 'Mysore Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,299',
      'originalPrice': '₹3,199',
      'badge': 'PREMIUM',
      'badgeColor': const Color(0xFF700D28),
    },
    {
      'image': 'assets/images/products/dress-4.png',
      'name': 'Paithani Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,799',
      'originalPrice': '₹3,699',
      'badge': 'EXCLUSIVE',
      'badgeColor': const Color(0xFF1565C0),
    },
    {
      'image': 'assets/images/products/dress-5.png',
      'name': 'Tussar Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹2,199',
      'originalPrice': '₹2,999',
      'badge': 'NEW',
      'badgeColor': const Color(0xFFE65100),
    },
    {
      'image': 'assets/images/products/dress-6.png',
      'name': 'Organza Silk Saree',
      'moq': 'MOQ: 5 Pieces',
      'price': '₹1,999',
      'originalPrice': '₹2,799',
      'badge': 'LIMITED',
      'badgeColor': const Color(0xFF37474F),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0), // Premium cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF6F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Silk Sarees',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF7A6F6F), size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded, color: Color(0xFF7A6F6F), size: 26),
            onPressed: () {},
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF7A6F6F), size: 26),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF700D28),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Breadcrumbs: Home > Categories > Silk Sarees
                  Row(
                    children: [
                      Text(
                        'Home',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFFB0A8A8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0A8A8), size: 14),
                      Text(
                        'Categories',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFFB0A8A8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0A8A8), size: 14),
                      Text(
                        'Silk Sarees',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF7A6F6F),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Header title section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Banarasi Silk Collection',
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFF4A0516),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '80+ premium designs available',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF7A6F6F),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Premium Collection Badge
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFC59B27), width: 1),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.stars_rounded, color: Color(0xFFC59B27), size: 20),
                            const SizedBox(height: 2),
                            Text(
                              'PREMIUM',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFFC59B27),
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Filter / Sort Row
                  Row(
                    children: [
                      _buildDropdownButton(label: 'Sort'),
                      const SizedBox(width: 8),
                      _buildDropdownButton(label: 'Filter'),
                      const SizedBox(width: 8),
                      _buildDropdownButton(label: 'Color'),
                      const SizedBox(width: 8),
                      _buildDropdownButton(label: 'Price'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Products Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.56,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _sarees.length,
                    itemBuilder: (context, index) {
                      final saree = _sarees[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/product-details'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Saree image + badges
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      saree['image'],
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
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: saree['badgeColor'],
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        saree['badge'],
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Wishlist Icon
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _wishlistState[index] = !_wishlistState[index];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          _wishlistState[index]
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
                                    saree['name'],
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
                                    saree['moq'],
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
                                        saree['price'],
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFF700D28),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        saree['originalPrice'],
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFFB0A8A8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  // In Stock checkmark
                                  Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 12),
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
                                  const SizedBox(height: 10),
                                  // Add to Cart Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                      ),);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // 5. WhatsApp Section at bottom
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: const Color(0xFFE8E5E5), width: 1),
              ),
            ),
            child: Row(
              children: [
                // WhatsApp Icon from assets
                Image.asset(
                  'assets/images/ui/whatsapp.png',
                  width: 38,
                  height: 38,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Need Bulk Order Assistance?',
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF4A0516),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Get MOQ, pricing, and collection details instantly.',
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
                // Chat Now button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF075E54), // Dark WhatsApp green
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.chat_bubble_outline_rounded, size: 12),
                      const SizedBox(width: 6),
                      Text(
                        'Chat Now',
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildDropdownButton({required String label}) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8E5E5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: const Color(0xFF4A0516),
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF7A6F6F), size: 16),
          ],
        ),
      ),
    );
  }
}
