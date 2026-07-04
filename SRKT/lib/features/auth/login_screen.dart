import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim().toLowerCase();
      final password = _passwordController.text.trim();

      // Check default credentials: "user@gmail.com", "admingmail.com", and password "1234"
      final isValidUser = (email == 'user@gmail.com' || email == 'user@gamil' || email == 'user@gmail');
      final isValidAdmin = (email == 'admingmail.com' || email == 'admin@gmail.com' || email == 'admin@gmail');

      bool loginSuccess = false;
      bool isAdmin = false;

      if ((isValidUser || isValidAdmin) && password == '1234') {
        loginSuccess = true;
        isAdmin = isValidAdmin;
      } else if (AppState.registeredUsers.containsKey(email)) {
        final registered = AppState.registeredUsers[email]!;
        if (registered['password'] == password) {
          loginSuccess = true;
          isAdmin = (registered['role'] == 'admin');
        }
      }

      if (loginSuccess) {
        AppState.recordLogin(email);
        _showReactToast(context, 'Login Successful!', isSuccess: true);
        if (isAdmin) {
          Navigator.pushReplacementNamed(context, '/admin');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        _showReactToast(context, 'Invalid credentials. Please try again.', isSuccess: false);
      }
    }
  }

  void _showReactToast(BuildContext context, String message, {required bool isSuccess}) {
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
              color: isSuccess ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
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
                Icon(
                  isSuccess ? Icons.check_circle_outline_rounded : Icons.error_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background cover image matching user's screenshot
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
                    // Login Card Container matching screenshot design (rounded 24px)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0), // Rounded corners matching mockup
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
                        children: [
                          // Brand Monogram Logo
                          Image.asset(
                            'assets/images/ui/logo.png',
                            height: 80,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.filter_vintage_outlined,
                              color: Color(0xFFC59B27),
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'SRKT',
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF700D28),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            'COLLECTION',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF7A6F6F),
                              fontSize: 10,
                              letterSpacing: 3.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Welcome Back Header
                          Text(
                            'Welcome Back',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF700D28),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Login to continue shopping',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xFF7A6F6F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Username input
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your email or mobile';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                    hintText: 'Enter your mobile number / email',
                                    hintStyle: GoogleFonts.manrope(
                                      color: const Color(0xFFB0A8A8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    filled: false,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0), // 8px border-radius
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
                                const SizedBox(height: 16),

                                // Password input
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                    hintText: 'Enter your password',
                                    hintStyle: GoogleFonts.manrope(
                                      color: const Color(0xFFB0A8A8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    filled: false,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                        color: const Color(0xFF7A6F6F),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible = !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0), // 8px border-radius
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
                                const SizedBox(height: 12),

                                // Forgot Password Link
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/forgot-password');
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFF700D28),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF700D28),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // 8px button border radius
                                      ),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Create Account Link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "New here? ",
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFF7A6F6F),
                                        fontSize: 13,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      child: Text(
                                        "Create an account",
                                        style: GoogleFonts.manrope(
                                          color: const Color(0xFF700D28),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
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
