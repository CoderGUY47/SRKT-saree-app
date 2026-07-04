import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _txnIdController = TextEditingController();

  String _selectedMethod = 'WHATSAPP';

  final List<Map<String, dynamic>> _methods = [
    {
      'id': 'WHATSAPP',
      'title': 'WhatsApp Pay [Available]',
      'desc': 'Pay via WhatsApp Chat & confirm order',
      'icon': Icons.chat_rounded,
      'enabled': true,
    },
    {
      'id': 'UPI',
      'title': 'UPI',
      'desc': 'Temporarily unavailable',
      'icon': Icons.account_balance_wallet_outlined,
      'enabled': false,
    },
    {
      'id': 'COD',
      'title': 'Cash on Delivery',
      'desc': 'Temporarily unavailable',
      'icon': Icons.local_shipping_outlined,
      'enabled': false,
    },
    {
      'id': 'CARD',
      'title': 'Credit / Debit Card',
      'desc': 'Temporarily unavailable',
      'icon': Icons.credit_card_outlined,
      'enabled': false,
    },
    {
      'id': 'NETBANK',
      'title': 'Net Banking',
      'desc': 'Temporarily unavailable',
      'icon': Icons.account_balance_outlined,
      'enabled': false,
    },
  ];

  @override
  void dispose() {
    _accountController.dispose();
    _txnIdController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp() async {
    final accountNum = _accountController.text.trim();
    final txnId = _txnIdController.text.trim();

    // Construct WhatsApp URL with custom message containing payment details
    final message = 'Hello SRKT Collection,\n\n'
        'I would like to complete my saree order.\n'
        'Here are my payment details:\n'
        '• Account/Mobile Number: $accountNum\n'
        '• Sent Money Transaction ID: $txnId\n\n'
        'Please verify my payment and process the order.';

    final whatsAppNum = AppState.whatsAppNumberNotifier.value;
    final whatsappUrl = Uri.parse(
        'https://wa.me/$whatsAppNum?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Fallback to web link if app is not available
      await launchUrl(whatsappUrl, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Payment Method',
          style: GoogleFonts.playfairDisplay(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment methods selection list
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _methods.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final method = _methods[index];
                        final isEnabled = method['enabled'] as bool;
                        final isSelected = _selectedMethod == method['id'];

                        return GestureDetector(
                          onTap: isEnabled
                              ? () {
                                  setState(() {
                                    _selectedMethod = method['id']!;
                                  });
                                }
                              : null,
                          child: Opacity(
                            opacity: isEnabled ? 1.0 : 0.5,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF700D28)
                                      : const Color(0xFFE8E5E5),
                                  width: isSelected ? 1.5 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFFCEFF1)
                                          : const Color(0xFFF7F6F5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      method['icon'] as IconData,
                                      color: isSelected
                                          ? const Color(0xFF700D28)
                                          : const Color(0xFF7A6F6F),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          method['title']!,
                                          style: GoogleFonts.playfairDisplay(
                                            color: const Color(0xFF4A0516),
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          method['desc']!,
                                          style: GoogleFonts.manrope(
                                            color: const Color(0xFF7A6F6F),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isEnabled)
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked_rounded
                                          : Icons.radio_button_off_rounded,
                                      color: const Color(0xFF700D28),
                                    )
                                  else
                                    const Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xFFB0A8A8),
                                      size: 18,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // WhatsApp Payment Details Form Section
                    if (_selectedMethod == 'WHATSAPP') ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFF0E2CA)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.info_outline_rounded,
                                    color: Color(0xFFC59B27), size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Payment Instruction',
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xFF4A0516),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please complete the transaction first, then share the details below. Our team will verify and confirm your order on WhatsApp.',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF7A6F6F),
                                fontSize: 11.5,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Account/Mobile input field
                            Text(
                              'Your Account / Mobile Number',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF4A0516),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _accountController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your account or mobile number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'e.g., +91 98765 43210',
                                hintStyle: GoogleFonts.manrope(
                                  color: const Color(0xFFB0A8A8),
                                  fontSize: 13,
                                ),
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
                                  borderSide: const BorderSide(
                                      color: Color(0xFF700D28), width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Sent Money Transaction ID input field
                            Text(
                              'Sent Money Transaction ID',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF4A0516),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _txnIdController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter the transaction ID';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'e.g., TXN123456789',
                                hintStyle: GoogleFonts.manrope(
                                  color: const Color(0xFFB0A8A8),
                                  fontSize: 13,
                                ),
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
                                  borderSide: const BorderSide(
                                      color: Color(0xFF700D28), width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Sticky footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Clear the cart
                      AppState.clearCart();
                      // Launch WhatsApp with details
                      await _launchWhatsApp();
                      // Navigate to success page
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, '/order-success');
                      }
                    }
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
                    'Place Order',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
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
