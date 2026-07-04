import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Cart items come from global AppState — not a local list
  List<CartItem> get _cartItems => AppState.cart;

  final List<Map<String, dynamic>> _frequentSuggestions = [
    {
      'name': 'Paithani Silk Saree',
      'price': '₹2,799',
      'image': 'assets/images/products/dress-5.png',
    },
    {
      'name': 'Organza Silk Saree',
      'price': '₹1,999',
      'image': 'assets/images/products/dress-7.png',
    },
    {
      'name': 'Tussar Silk Saree',
      'price': '₹2,199',
      'image': 'assets/images/products/dress-6.png',
    },
  ];

  void _increaseQty(int index) {
    AppState.updateCartQuantity(index, _cartItems[index].quantity + 1);
    setState(() {});
  }

  void _decreaseQty(int index) {
    if (_cartItems[index].quantity > 1) {
      AppState.updateCartQuantity(index, _cartItems[index].quantity - 1);
    } else {
      AppState.removeFromCart(index);
    }
    setState(() {});
  }

  int get subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get discount {
    return (subtotal * 0.1).round();
  }

  int get total {
    return subtotal - discount;
  }

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
          'My Cart (${_cartItems.length})',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
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
          const SizedBox(width: 8),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Ready for Wholesale Order Header
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
                        Icons.shopping_bag_outlined,
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
                            'Ready for Wholesale Order',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF4A0516),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_cartItems.length} premium saree collections selected for checkout.',
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

            // Cart Items List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _cartItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Image and Badge
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image.asset(
                              item.image,
                              width: 110,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: item.badgeColor is Color
                                    ? item.badgeColor as Color
                                    : const Color(0xFFC59B27),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.badge,
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
                      // Details Section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.name,
                                      style: GoogleFonts.playfairDisplay(
                                        color: const Color(0xFF4A0516),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AppState.removeFromCart(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.delete_outline_rounded,
                                        color: Colors.red.shade800,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Color: ${item.color}   MOQ: ${item.moq}',
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
                                    '₹${item.price}',
                                    style: GoogleFonts.manrope(
                                      color: const Color(0xFF700D28),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item.originalPrice,
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
                              // Quantity selector & stock
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F6F5),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.grey.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => _decreaseQty(index),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            child: Icon(Icons.remove, size: 12, color: Color(0xFF7A6F6F)),
                                          ),
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: GoogleFonts.manrope(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF4A0516),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _increaseQty(index),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            child: Icon(Icons.add, size: 12, color: Color(0xFF7A6F6F)),
                                          ),
                                        ),
                                      ],
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
                );
              },
            ),

            const SizedBox(height: 16),
            // Apply Coupon widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8E5E5)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_offer_outlined, color: Color(0xFFC59B27), size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Apply Coupon',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF4A0516),
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Save more on wholesale orders',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF7A6F6F),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: Color(0xFF7A6F6F), size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Order Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: GoogleFonts.playfairDisplay(
                        color: const Color(0xFF4A0516),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 40,
                      height: 2,
                      color: const Color(0xFFC59B27),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal (${_cartItems.length} Items)', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
                        Text('₹$subtotal', style: GoogleFonts.manrope(color: const Color(0xFF4A0516), fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping Charges', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
                        Text('Free', style: GoogleFonts.manrope(color: const Color(0xFF2E7D32), fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Wholesale Discount', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
                        Text('-₹$discount', style: GoogleFonts.manrope(color: const Color(0xFF700D28), fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('GST Included', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
                            const SizedBox(width: 4),
                            const Icon(Icons.info_outline_rounded, color: Color(0xFFB0A8A8), size: 12),
                          ],
                        ),
                        Text('Included', style: GoogleFonts.manrope(color: const Color(0xFF4A0516), fontWeight: FontWeight.w600, fontSize: 12)),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(color: Color(0xFFE8E5E5)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount', style: GoogleFonts.playfairDisplay(color: const Color(0xFF4A0516), fontWeight: FontWeight.bold, fontSize: 15)),
                        Text('₹$total', style: GoogleFonts.manrope(color: const Color(0xFF700D28), fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Frequently Bought Together Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Frequently Bought Together',
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFF4A0516),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'View All >',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF700D28),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal suggestions
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _frequentSuggestions.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final sugg = _frequentSuggestions[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/product-details'),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image.asset(
                                    sugg['image'],
                                    width: 120,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Color(0xFF700D28),
                                      size: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sugg['name'],
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xFF4A0516),
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sugg['price'],
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFF700D28),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        AppState.addToCart(
                                          name: sugg['name'],
                                          color: 'Multi',
                                          moq: '5 Pieces',
                                          price: 2199,
                                          originalPrice: '₹3,199',
                                          badge: 'NEW',
                                          badgeColor: const Color(0xFF700D28),
                                          image: sugg['image'],
                                        );
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: const Color(0xFF700D28)),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'Add',
                                          style: GoogleFonts.manrope(
                                            color: const Color(0xFF700D28),
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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

            const SizedBox(height: 24),
            // Secure Wholesale Checkout Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F4),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E7E2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, color: Color(0xFF2E7D32), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Secure Wholesale Checkout',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF1B5E20),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Safe payments, verified products, and trusted delivery.',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF557F57),
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.vpn_key_outlined, color: Color(0xFF557F57), size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 120), // Space for footer
          ],
        ),
      ),
      bottomNavigationBar: _cartItems.isEmpty
          ? BottomNavigationBar(
              currentIndex: 3,
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
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          // Checkout Sticky Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF7A6F6F),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '₹$total',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF700D28),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Including wholesale savings',
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF2E7D32),
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF700D28),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: GoogleFonts.manrope(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Navigation Bottom Bar
          BottomNavigationBar(
            currentIndex: 3,
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
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sparkly Shopping Cart Graphic
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF7F2),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBECE2),
                    shape: BoxShape.circle,
                  ),
                ),
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF700D28),
                  size: 72,
                ),
                const Positioned(
                  top: 24,
                  right: 28,
                  child: Icon(Icons.star_rounded, color: Color(0xFFC59B27), size: 18),
                ),
                const Positioned(
                  bottom: 30,
                  left: 20,
                  child: Icon(Icons.star_rounded, color: Color(0xFFC59B27), size: 14),
                ),
                const Positioned(
                  top: 50,
                  left: 36,
                  child: Icon(Icons.star_rounded, color: Color(0xFFC59B27), size: 16),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Text(
              'Your cart is empty',
              style: GoogleFonts.playfairDisplay(
                color: const Color(0xFF4A0516),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Looks like you haven't added\nanything yet.",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: const Color(0xFF7A6F6F),
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF700D28),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Shop Now',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
