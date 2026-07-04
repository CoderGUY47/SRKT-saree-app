import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final notifications = AppState.notifications;

    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFBFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8F0),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF0E2CA), width: 2),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xFFC59B27),
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No notifications yet',
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFF4A0516),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Activities like login, cart updates\nand wishlist changes will appear here.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF7A6F6F),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = notifications[index];
                final type = item['type'] ?? 'INFO';

                Color typeColor = const Color(0xFF700D28);
                IconData typeIcon = Icons.info_outline_rounded;

                switch (type) {
                  case 'CART':
                    typeColor = const Color(0xFF700D28);
                    typeIcon = Icons.shopping_cart_outlined;
                    break;
                  case 'WISHLIST':
                    typeColor = const Color(0xFFC59B27);
                    typeIcon = Icons.favorite_border_rounded;
                    break;
                  case 'SECURITY':
                    typeColor = const Color(0xFF2E7D32);
                    typeIcon = Icons.verified_user_outlined;
                    break;
                  default:
                    typeColor = const Color(0xFF700D28);
                    typeIcon = Icons.notifications_outlined;
                }

                return Container(
                  padding: const EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: typeColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(typeIcon, color: typeColor, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: GoogleFonts.playfairDisplay(
                                color: const Color(0xFF4A0516),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['desc']!,
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF7A6F6F),
                                fontSize: 11.5,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['time']!,
                              style: GoogleFonts.manrope(
                                color: const Color(0xFFB0A8A8),
                                fontSize: 10,
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
    );
  }
}
