import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  void _showImageUpdateDialog(BuildContext context) {
    final controller = TextEditingController(text: AppState.loggedInUserAvatarNotifier.value);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFAF6F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          'Update Profile Photo',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Image URL or asset path:',
              style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'https://example.com/image.jpg',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F))),
          ),
          ElevatedButton(
            onPressed: () {
              AppState.loggedInUserAvatarNotifier.value = controller.text;
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF700D28),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Save', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6), // Warm off-white background
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
        backgroundColor: const Color(0xFFFDF9F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF700D28), size: 26),
                onPressed: () => Navigator.pushNamed(context, '/notifications'),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC62828), // Notification red badge dot
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Background watermark pattern
          Positioned.fill(
            child: Image.asset(
              'assets/images/ui/welcome-screen.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.03),
            ),
          ),
          // Scrollable layout content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // 1. Profile Avatar & User Details
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: AppState.loggedInUserAvatarNotifier,
                            builder: (context, imagePath, _) {
                              final isNetwork = imagePath.startsWith('http') || imagePath.startsWith('https');
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF700D28).withOpacity(0.2), width: 1),
                                ),
                                child: ClipOval(
                                  child: isNetwork
                                      ? Image.network(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            color: const Color(0xFFFCEFF1),
                                            child: const Icon(Icons.person_rounded, color: Color(0xFF700D28), size: 50),
                                          ),
                                        )
                                      : Image.asset(
                                          imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            color: const Color(0xFFFCEFF1),
                                            child: const Icon(Icons.person_rounded, color: Color(0xFF700D28), size: 50),
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => _showImageUpdateDialog(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: Color(0xFF700D28),
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<String>(
                        valueListenable: AppState.loggedInUserNameNotifier,
                        builder: (context, name, _) {
                          return Text(
                            'Hello, $name',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF4A0516),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      // Decorative gold divider graphic
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 40, height: 1, color: const Color(0xFFC59B27).withOpacity(0.5)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Icon(Icons.star_rounded, color: Color(0xFFC59B27), size: 10),
                          ),
                          Container(width: 40, height: 1, color: const Color(0xFFC59B27).withOpacity(0.5)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Contact info rows matching mockup layout
                      ValueListenableBuilder<String>(
                        valueListenable: AppState.loggedInUserEmailNotifier,
                        builder: (context, email, _) {
                          if (email == 'Not Provided') return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.mail_outline_rounded, color: Color(0xFFC59B27), size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  email,
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF7A6F6F),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: AppState.loggedInUserPhoneNotifier,
                        builder: (context, phone, _) {
                          if (phone == 'Not Provided') return const SizedBox.shrink();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.phone_outlined, color: Color(0xFFC59B27), size: 16),
                              const SizedBox(width: 8),
                              Text(
                                phone,
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF7A6F6F),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // 2. My Orders Status Card
                Container(
                  width: double.infinity,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Orders',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF4A0516),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/cart'),
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.manrope(
                                    color: const Color(0xFF700D28),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.chevron_right_rounded, color: Color(0xFF700D28), size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildOrderStatusIcon(Icons.shopping_bag_outlined, 'All Orders'),
                          _buildOrderStatusIcon(Icons.widgets_outlined, 'Processing'),
                          _buildOrderStatusIcon(Icons.local_shipping_outlined, 'Shipped'),
                          _buildOrderStatusIcon(Icons.assignment_turned_in_outlined, 'Delivered'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 3. User Accounts Option List
                Container(
                  width: double.infinity,
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
                    children: [
                      _buildOptionTile(context, Icons.person_outline_rounded, 'Personal Information', onTap: () {}),
                      _buildOptionTile(context, Icons.location_on_outlined, 'Address Book', onTap: () {}),
                      _buildOptionTile(context, Icons.credit_card_outlined, 'Payment Methods', onTap: () {}),
                      _buildOptionTile(context, Icons.favorite_border_rounded, 'Wishlist', onTap: () {
                        Navigator.pushNamed(context, '/wishlist');
                      }),
                      _buildOptionTile(context, Icons.notifications_none_rounded, 'Notifications', onTap: () {
                        Navigator.pushNamed(context, '/notifications');
                      }),
                      _buildOptionTile(context, Icons.headset_mic_outlined, 'Help & Support', isLast: true, onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // 4. Logout Link Button (Centered at the bottom)
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, color: Color(0xFF700D28), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF700D28),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
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

  Widget _buildOrderStatusIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFFFDF4EE), // Beige tint circle
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF700D28), size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: const Color(0xFF7A6F6F),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    IconData icon,
    String title, {
    bool isLast = false,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(icon, color: const Color(0xFFC59B27), size: 20), // Gold icons
          title: Text(
            title,
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFB0A8A8), size: 18),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Color(0xFFF2EFEF), height: 1),
          ),
      ],
    );
  }
}
