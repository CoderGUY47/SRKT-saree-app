import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;
  int _selectedColorIndex = 0;
  bool _isWishlisted = false;

  final List<String> _detailImages = [
    'assets/images/products/dress-1.png',
    'COMING_SOON',
  ];

  final List<Color> _availableColors = [
    const Color(0xFF700D28), // Maroon
    const Color(0xFF1B5E20), // Green
    const Color(0xFF4A148C), // Purple
    const Color(0xFFC59B27), // Gold
    const Color(0xFF0D47A1), // Blue
  ];

  void _showReactToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
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
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  message,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      entry.remove();
    } else {
      Future.delayed(const Duration(milliseconds: 5000), () {
        entry.remove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Image Hero PageView Section
                Stack(
                  children: [
                    SizedBox(
                      height: 380,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: _detailImages.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          if (_detailImages[index] == 'COMING_SOON') {
                            return Container(
                              color: const Color(0xFFF9F6F0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Color(0xFFC59B27),
                                      size: 48,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'More Angles Coming Soon',
                                      style: GoogleFonts.playfairDisplay(
                                        color: const Color(0xFF4A0516),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Stay tuned for detailed close-ups.',
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFF7A6F6F),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Image.asset(
                            _detailImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, err, stack) {
                              return Container(
                                color: const Color(0xFF700D28),
                                child: const Center(
                                  child: Icon(Icons.image_outlined, color: Colors.white, size: 50),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Indicator Dots & Index Number
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_detailImages.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentImageIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentImageIndex + 1}/${_detailImages.length}',
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // 2. Product Information
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gold Bestseller Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC59B27),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.stars_rounded, color: Colors.white, size: 10),
                            const SizedBox(width: 4),
                            Text(
                              'BESTSELLER',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Banarasi Silk Saree',
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF4A0516),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Rating & Reviews
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFC59B27), size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '4.8 Rating',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF4A0516),
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•  125 Reviews',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF7A6F6F),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Price & Discount tags
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹2,499',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF700D28),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '₹3,499',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFFB0A8A8),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCEFF1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '29% OFF',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF700D28),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // MOQ & Stock
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MOQ: 5 Pieces',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF4A0516),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2E7D32),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'In Stock',
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF2E7D32),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(color: Color(0xFFE8E5E5)),
                      ),

                      // About This Saree
                      Text(
                        'About This Saree',
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF4A0516),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Beautiful Banarasi silk saree with rich weaving and elegant traditional craftsmanship. Designed for weddings, festive occasions, and premium retail collections.',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF7A6F6F),
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Specs Grid (Occasion, Blouse, Fabric, Weaving)
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 2.8,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildSpecCard(Icons.grid_on_outlined, 'Fabric', 'Silk'),
                          _buildSpecCard(Icons.straighten_rounded, 'Length', '6.3 m'),
                          _buildSpecCard(Icons.checkroom_rounded, 'Blouse', 'Included'),
                          _buildSpecCard(Icons.palette_outlined, 'Color', 'Maroon'),
                          _buildSpecCard(Icons.precision_manufacturing_outlined, 'Weaving', 'Handcrafted'),
                          _buildSpecCard(Icons.favorite_outline_rounded, 'Occasion', 'Wedding'),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Available Colors
                      Text(
                        'Available Colors',
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF4A0516),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(_availableColors.length, (index) {
                          final isSelected = _selectedColorIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF700D28)
                                      : Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: _availableColors[index],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),
                      // Wholesale Benefits gold tinted card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFF0E2CA)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wholesale Benefits',
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFF4A0516),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildBenefitRow('MOQ Available'),
                            const SizedBox(height: 8),
                            _buildBenefitRow('Bulk Pricing Support'),
                            const SizedBox(height: 8),
                            _buildBenefitRow('Fast Dispatch'),
                            const SizedBox(height: 8),
                            _buildBenefitRow('Premium Packaging'),
                            const SizedBox(height: 8),
                            _buildBenefitRow('Direct Manufacturer Supply'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      // Authentic Quality Assured
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDFBF9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFF5EFEB)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars_rounded, color: Color(0xFFC59B27), size: 36),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Authentic Quality Assured',
                                    style: GoogleFonts.playfairDisplay(
                                      color: const Color(0xFF4A0516),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Every saree is quality checked before dispatch.',
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFF7A6F6F),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100), // space for bottom footer
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Top Translucent Actions (Back, Share, Heart, Cart)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _buildCircleNavButton(
                  Icons.arrow_back_rounded,
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                _buildCircleNavButton(
                  Icons.share_outlined,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                _buildCircleNavButton(
                  _isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  iconColor: _isWishlisted ? const Color(0xFF700D28) : const Color(0xFF4A0516),
                  onPressed: () {
                    setState(() {
                      _isWishlisted = !_isWishlisted;
                    });
                    AppState.toggleWishlist({
                      'name': 'Banarasi Silk Saree',
                      'color': 'Maroon',
                      'moq': 'MOQ: 5 Pieces',
                      'price': '₹2,499',
                      'priceInt': 2499,
                      'originalPrice': '₹3,499',
                      'badge': 'BESTSELLER',
                      'badgeColor': const Color(0xFFC59B27),
                      'image': 'assets/images/products/dress-1.png',
                    });
                    _showReactToast(
                      context,
                      _isWishlisted ? 'Added to Wishlist!' : 'Removed from Wishlist!',
                    );
                  },
                ),
                const SizedBox(width: 8),
                // Cart icon with live badge
                ValueListenableBuilder<int>(
                  valueListenable: AppState.cartCountNotifier,
                  builder: (context, cartCount, _) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildCircleNavButton(
                          Icons.shopping_cart_outlined,
                          onPressed: () => Navigator.pushNamed(context, '/cart'),
                        ),
                        if (cartCount > 0)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Color(0xFF700D28),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7.5,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // 4. Sticky Bottom Action Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isWishlisted = !_isWishlisted;
                        });
                        AppState.toggleWishlist({
                          'name': 'Banarasi Silk Saree',
                          'color': 'Maroon',
                          'moq': 'MOQ: 5 Pieces',
                          'price': '₹2,499',
                          'priceInt': 2499,
                          'originalPrice': '₹3,499',
                          'badge': 'BESTSELLER',
                          'badgeColor': const Color(0xFFC59B27),
                          'image': 'assets/images/products/dress-1.png',
                        });
                        _showReactToast(
                          context,
                          _isWishlisted ? 'Added to Wishlist!' : 'Removed from Wishlist!',
                        );
                      },
                      icon: Icon(
                        _isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 16,
                      ),
                      label: Text(
                        'Add to Wishlist',
                        style: GoogleFonts.manrope(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF700D28),
                        side: const BorderSide(color: Color(0xFF700D28)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        AppState.addToCart(
                          name: 'Banarasi Silk Saree',
                          color: _selectedColorName(),
                          moq: 'MOQ: 5 Pieces',
                          price: 2499,
                          originalPrice: '₹3,499',
                          badge: 'BESTSELLER',
                          badgeColor: const Color(0xFFC59B27),
                          image: 'assets/images/products/dress-1.png',
                        );
                        setState(() {});
                        _showReactToast(context, 'Added to Cart!');
                      },
                      icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                      label: Text(
                        'Add to Cart',
                        style: GoogleFonts.manrope(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF700D28),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _selectedColorName() {
    const colorNames = ['Maroon', 'Green', 'Purple', 'Gold', 'Blue'];
    if (_selectedColorIndex >= 0 && _selectedColorIndex < colorNames.length) {
      return colorNames[_selectedColorIndex];
    }
    return 'Maroon';
  }

  Widget _buildCircleNavButton(IconData icon, {Color? iconColor, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? const Color(0xFF4A0516), size: 20),
        onPressed: onPressed,
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  Widget _buildSpecCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8E5E5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFC59B27), size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFFB0A8A8),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF4A0516),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(String label) {
    return Row(
      children: [
        const Icon(Icons.check_circle_outline_rounded, color: Color(0xFFC59B27), size: 14),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: const Color(0xFF4A0516),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
