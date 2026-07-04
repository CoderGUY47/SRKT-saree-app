import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  String _selectedRole = 'client'; // 'client' or 'admin'
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shopController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim().toLowerCase();
      final password = _passwordController.text.trim();
      final shopName = _shopController.text.trim();

      AppState.registerUser(
        email: email,
        name: name,
        password: password,
        role: _selectedRole,
        businessName: _selectedRole == 'admin' ? shopName : null,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_selectedRole[0].toUpperCase()}${_selectedRole.substring(1)} account created successfully for $name!',
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
    _nameController.dispose();
    _shopController.dispose();
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
                    // Signup Card Container matching screenshot design (rounded 24px)
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

                          // Header Text
                          Text(
                            'Create Account',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF700D28),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Register for wholesale benefits',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xFF7A6F6F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Role Selector Tab (Client / Admin)
                          _buildRoleSelector(),

                          // Form fields matching user's screenshot
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Full name field
                                TextFormField(
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                    hintText: 'Enter full name',
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
                                if (_selectedRole == 'admin') ...[
                                  const SizedBox(height: 16),
                                  // Shop / Business Name field
                                  TextFormField(
                                    controller: _shopController,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter shop/business name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.store_outlined,
                                        color: Color(0xFF7A6F6F),
                                        size: 22,
                                      ),
                                      hintText: 'Enter shop / business name',
                                      hintStyle: GoogleFonts.manrope(
                                        color: const Color(0xFFB0A8A8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      filled: false,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
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
                                ],
                                const SizedBox(height: 16),

                                // Mobile number / email field
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Please enter mobile number or email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.mail_outline_rounded,
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
                                      borderRadius: BorderRadius.circular(8.0),
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

                                // Password field
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
                                    final hasLowercase = value.contains(RegExp(r'[a-z]'));
                                    final hasDigits = value.contains(RegExp(r'[0-9]'));
                                    final hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                                    if (!hasUppercase || !hasLowercase || !hasDigits || !hasSpecialCharacters) {
                                      return 'Must contain A-Z, a-z, 0-9, and special char';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                    hintText: 'Create a password',
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
                                      borderRadius: BorderRadius.circular(8.0),
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
                                _buildPasswordStrengthIndicator(),
                                const SizedBox(height: 24),

                                // Register Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: _handleRegister,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF700D28),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // 8px button border radius
                                      ),
                                    ),
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.manrope(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Login navigation link
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: GoogleFonts.manrope(
                                        color: const Color(0xFF7A6F6F),
                                        fontSize: 13,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Login",
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

  Widget _buildRoleSelector() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F7F7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E5E5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = 'client';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedRole == 'client'
                      ? const Color(0xFF700D28)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Client',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _selectedRole == 'client'
                          ? Colors.white
                          : const Color(0xFF7A6F6F),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRole = 'admin';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedRole == 'admin'
                      ? const Color(0xFF700D28)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Admin',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _selectedRole == 'admin'
                          ? Colors.white
                          : const Color(0xFF7A6F6F),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final password = _passwordController.text;
    if (password.isEmpty) return const SizedBox.shrink();

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    final isAtLeast8 = password.length >= 8;

    int criteriaMet = 0;
    if (hasUppercase) criteriaMet++;
    if (hasLowercase) criteriaMet++;
    if (hasDigits) criteriaMet++;
    if (hasSpecialCharacters) criteriaMet++;
    if (isAtLeast8) criteriaMet++;

    String strengthText = 'Low';
    Color strengthColor = const Color(0xFFE53935);
    int activeSegments = 1;

    if (criteriaMet == 5) {
      strengthText = 'Super Strong (s.strong)';
      strengthColor = const Color(0xFF1E88E5);
      activeSegments = 4;
    } else if (criteriaMet == 4) {
      strengthText = 'Strong';
      strengthColor = const Color(0xFF43A047);
      activeSegments = 3;
    } else if (criteriaMet == 3) {
      strengthText = 'Medium';
      strengthColor = const Color(0xFFFB8C00);
      activeSegments = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: activeSegments >= 1 ? strengthColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: activeSegments >= 2 ? strengthColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: activeSegments >= 3 ? strengthColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: activeSegments >= 4 ? strengthColor : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Strength: $strengthText (Must be 8+ chars, uppercase, lowercase, number, special char)',
          style: GoogleFonts.manrope(
            fontSize: 11,
            color: strengthColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
