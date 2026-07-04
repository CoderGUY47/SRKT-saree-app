import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      final contact = _contactController.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'OTP sent successfully to $contact!',
            style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF700D28),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background cover image matching signin and signup pages
          Positioned.fill(
            child: Image.asset(
              'assets/images/ui/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Back Button positioned absolutely
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF700D28),
                size: 28,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Scrollable content area
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Forgot Password Card Container matching login/signup designs (rounded 24px)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0), // Cohesive rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Heading
                          Text(
                            'Forgot Password?',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF700D28),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Subheading
                          Text(
                            'Enter your registered mobile number or email address',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xFF7A6F6F),
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Input Field (designed like mockup image 2)
                                TextFormField(
                                  controller: _contactController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your mobile number or email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.contact_mail_outlined, // Badge / identity card icon from mockup
                                      color: Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                    hintText: 'Enter mobile number / email',
                                    hintStyle: GoogleFonts.manrope(
                                      color: const Color(0xFFB0A8A8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    filled: false,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0), // 8px border radius
                                      borderSide: const BorderSide(color: Color(0xFFE8E5E5)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(color: Color(0xFFE8E5E5)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(color: Color(0xFF700D28), width: 1.5),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Send OTP Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: _handleSendOtp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF700D28), // Burgundy matching design
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // 8px border-radius
                                      ),
                                    ),
                                    child: Text(
                                      'Send OTP',
                                      style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 28),

                                // Padlock Illustration Centered under the Send OTP button (mockup 1st image)
                                Center(
                                  child: Image.asset(
                                    'assets/images/ui/forgot-password-lock.jpg',
                                    height: 180,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) => Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFAF6F0),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.lock_reset_rounded,
                                        size: 70,
                                        color: Color(0xFF700D28),
                                      ),
                                    ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
