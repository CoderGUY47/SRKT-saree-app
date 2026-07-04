import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/products_tab.dart';
import 'tabs/users_tab.dart';
import 'tabs/enquiries_tab.dart';
import 'tabs/settings_tab.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  // Global Mock States
  final List<Map<String, dynamic>> _orders = [
    {
      'shop': 'Maya Saree Boutique',
      'items': 'Kanjivaram Silk Saree (5 Pcs)',
      'amount': '₹14,250',
      'mobile': '+91 98765 11223',
      'txnId': 'TXN8732194625',
      'status': 'Pending Verification',
      'date': 'Today, 11:20 AM',
    },
    {
      'shop': 'Vastra Wholesale Emporium',
      'items': 'Designer Organza Collection (10 Pcs)',
      'amount': '₹28,500',
      'mobile': '+91 91234 56789',
      'txnId': 'TXN9182736450',
      'status': 'Verified',
      'date': 'Yesterday, 4:45 PM',
    },
    {
      'shop': 'Anjali Wedding Saree House',
      'items': 'Bridal Banarasi Silk Saree (8 Pcs)',
      'amount': '₹38,800',
      'mobile': '+91 98123 45678',
      'txnId': 'TXN4738291054',
      'status': 'Pending Verification',
      'date': 'Yesterday, 1:15 PM',
    },
  ];

  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Rajesh Kumar',
      'shop': 'Kumar Textiles & Fabrics',
      'email': 'rajesh@kumartextiles.com',
      'mobile': '+91 99887 76655',
      'status': 'Pending',
    },
    {
      'name': 'Priya Sharma',
      'shop': 'Priya Fashion Boutique',
      'email': 'priya@boutique.com',
      'mobile': '+91 98765 43210',
      'status': 'Approved',
    },
    {
      'name': 'Amit Patel',
      'shop': 'Patel Wholesale Sarees',
      'email': 'amit@patelsarees.com',
      'mobile': '+91 90123 45678',
      'status': 'Pending',
    },
  ];

  final List<Map<String, dynamic>> _enquiries = [
    {
      'name': 'Sunita Sen',
      'shop': 'Sunita Designer Studio',
      'message': 'Looking for wholesale pricing on Banarasi silk sarees. Need 20 pieces.',
      'date': 'Today, 10:00 AM',
    },
    {
      'name': 'Vikram Rao',
      'shop': 'Rao & Sons Saree Hub',
      'message': 'Do you offer customized designs for bulk orders above 50 pieces?',
      'date': 'Yesterday',
    },
  ];

  // Store catalog mock
  final List<Map<String, dynamic>> _catalogProducts = [
    {'name': 'Kanjivaram Silk Saree', 'moq': '5 Pieces', 'price': '₹2,850', 'image': 'assets/images/products/saree-1.png'},
    {'name': 'Designer Organza Saree', 'moq': '5 Pieces', 'price': '₹1,990', 'image': 'assets/images/products/saree-2.png'},
    {'name': 'Bridal Banarasi Silk Saree', 'moq': '5 Pieces', 'price': '₹4,850', 'image': 'assets/images/products/saree-3.png'},
  ];

  final List<String> _categories = ['Silk Sarees', 'Organza Collection', 'Banarasi Silk', 'Linen Sarees'];

  late TextEditingController _whatsappController;

  @override
  void initState() {
    super.initState();
    _whatsappController = TextEditingController(text: AppState.whatsAppNumberNotifier.value);
  }

  @override
  void dispose() {
    _whatsappController.dispose();
    super.dispose();
  }

  void _verifyOrderPayment(int index) {
    setState(() {
      _orders[index]['status'] = 'Verified';
    });
    AppState.addNotification(
      title: 'Payment Approved ✅',
      desc: 'Wholesale order for ${_orders[index]['shop']} is now approved.',
      type: 'SECURITY',
    );
    _showToast('Payment verified successfully!');
  }

  void _rejectOrderPayment(int index) {
    setState(() {
      _orders[index]['status'] = 'Rejected';
    });
    _showToast('Order payment rejected.');
  }

  void _approveUser(int index) {
    setState(() {
      _users[index]['status'] = 'Approved';
    });
    AppState.addNotification(
      title: 'User Approved 👤',
      desc: 'Wholesale access granted to ${_users[index]['shop']}.',
      type: 'SECURITY',
    );
    _showToast('User approved for wholesale!');
  }

  void _rejectUser(int index) {
    setState(() {
      _users[index]['status'] = 'Rejected';
    });
    _showToast('User application rejected.');
  }

  void _addCategory(String name) {
    setState(() {
      _categories.add(name);
    });
    _showToast('Category "$name" added.');
  }

  void _deleteCategory(int index) {
    final catName = _categories[index];
    setState(() {
      _categories.removeAt(index);
    });
    _showToast('Category "$catName" removed.');
  }

  void _saveSettings() {
    AppState.updateWhatsAppNumber(_whatsappController.text);
    _showToast('WhatsApp number updated successfully!');
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF700D28),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF6F0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF700D28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Admin Portal',
          style: GoogleFonts.manrope(
            color: const Color(0xFF4A0516),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 1. Dashboard Tab View
          DashboardTab(
            orders: _orders,
            users: _users,
            onApprovePayment: _verifyOrderPayment,
            onRejectPayment: _rejectOrderPayment,
          ),

          // 2. Products Tab View
          ProductsTab(
            products: _catalogProducts,
            categories: _categories,
            onAddCategory: _addCategory,
            onDeleteCategory: _deleteCategory,
            onAddProduct: (newProd) {
              setState(() {
                _catalogProducts.add(newProd);
              });
              _showToast('Product added successfully!');
            },
            onEditProduct: (idx, updatedProd) {
              setState(() {
                _catalogProducts[idx] = updatedProd;
              });
              _showToast('Product details updated!');
            },
            onDeleteProduct: (idx) {
              setState(() {
                _catalogProducts.removeAt(idx);
              });
              _showToast('Product deleted from catalog.');
            },
          ),

          // 3. Users Tab View
          UsersTab(
            users: _users,
            onApproveUser: _approveUser,
            onRejectUser: _rejectUser,
          ),

          // 4. Enquiries Tab View
          EnquiriesTab(
            enquiries: _enquiries,
          ),

          // 5. Settings Tab View
          SettingsTab(
            whatsappController: _whatsappController,
            onSaveSettings: _saveSettings,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF700D28),
          unselectedItemColor: const Color(0xFF7A6F6F),
          selectedLabelStyle: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: GoogleFonts.manrope(fontSize: 11),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Users'),
            BottomNavigationBarItem(icon: Icon(Icons.question_answer_rounded), label: 'Enquiries'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
