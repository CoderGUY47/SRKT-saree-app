import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Success Shopping Bag Checkmark Illustration
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F3E8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    // Draw shopping bag base
                    Positioned(
                      bottom: 40,
                      child: Container(
                        width: 120,
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8D6E63), // Brown bag color
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    // Draw shopping bag handles
                    Positioned(
                      top: 40,
                      child: Container(
                        width: 60,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF5D4037), width: 3),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    // Checkmark badge in front
                    Positioned(
                      bottom: 30,
                      right: 40,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFC59B27), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF8D6E63),
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // 2. Title
                Text(
                  'Order Placed\nSuccessfully!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xFF4A0516),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Message
                Text(
                  'Your order #96C123456 has been\nplaced successfully.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF7A6F6F),
                    fontSize: 14.5,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You will receive an update shortly.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF7A6F6F),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                // 4. Action Button Continue Shopping ->
                SizedBox(
                  width: double.infinity,
                  height: 52,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue Shopping',
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Underlined View Order Details
                InkWell(
                  onTap: () {
                    // Show a toast or go to cart
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Displaying details for Nexus Order #96C123456',
                          style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
                        ),
                        backgroundColor: const Color(0xFF700D28),
                      ),
                    );
                  },
                  child: Text(
                    'View Order Details',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF700D28),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
