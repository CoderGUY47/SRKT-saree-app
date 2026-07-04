import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/ui/welcome-screen.png',
              fit: BoxFit.cover,
            ),
          ),

          // Button Overlay placed at the bottom
          Positioned(
            left: 24,
            right: 24,
            bottom: 60, // Placed below the "for every occasion" text area
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to login screen
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF700D28), // Premium burgundy matching logo
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0xFF700D28).withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // 10px border radius
                      ),
                    ),
                    child: Text(
                      'Get started -->',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
