import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nexus_b2b_app/services/app_state.dart';

class DashboardTab extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final List<Map<String, dynamic>> users;
  final Function(int) onApprovePayment;
  final Function(int) onRejectPayment;

  const DashboardTab({
    super.key,
    required this.orders,
    required this.users,
    required this.onApprovePayment,
    required this.onRejectPayment,
  });

  @override
  Widget build(BuildContext context) {
    int pendingOrders = orders.where((o) => o['status'] == 'Pending Verification').length;
    int pendingUsers = users.where((u) => u['status'] == 'Pending').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Active Logged-in User Session Header
          ValueListenableBuilder<String>(
            valueListenable: AppState.loggedInUserNameNotifier,
            builder: (context, userName, _) {
              return ValueListenableBuilder<String>(
                valueListenable: AppState.loggedInUserAvatarNotifier,
                builder: (context, userAvatar, _) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE8E5E5)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            userAvatar,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              width: 48,
                              height: 48,
                              color: const Color(0xFF700D28),
                              child: const Icon(Icons.person_rounded, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Logged In Session:',
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF7A6F6F),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                userName,
                                style: GoogleFonts.manrope(
                                  color: const Color(0xFF4A0516),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF700D28).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'ADMIN',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF700D28),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          // B2B Stats Cards Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('Wholesale Sales', '₹1,03,750', Icons.payments_rounded, const Color(0xFF700D28)),
              _buildStatCard('Active Retailers', '${users.length} Shops', Icons.storefront_rounded, const Color(0xFFC59B27)),
              _buildStatCard('Pending Payments', '$pendingOrders Orders', Icons.hourglass_top_rounded, const Color(0xFF2E7D32)),
              _buildStatCard('Pending Retailers', '$pendingUsers Accounts', Icons.people_outline_rounded, const Color(0xFFC62828)),
            ],
          ),

          // Pie Graph Section (Distribution Card)
          const SizedBox(height: 24),
          Text(
            'Operational Distribution',
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8E5E5)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                // Custom Paint Pie Chart
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CustomPaint(
                    painter: PieChartPainter(
                      values: [55.0, 25.0, 20.0], // 55% Sales, 25% Users/Retailers, 20% Saree Products
                      colors: const [
                        Color(0xFF700D28), // Wholesale Sales
                        Color(0xFFC59B27), // Active Retailers
                        Color(0xFF2E7D32), // Saree Products
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Legends breakdown list
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem('Wholesale Sales', '₹1,03,750', const Color(0xFF700D28), '55%'),
                      const SizedBox(height: 10),
                      _buildLegendItem('Active Retailers', '${users.length} Shops', const Color(0xFFC59B27), '25%'),
                      const SizedBox(height: 10),
                      _buildLegendItem('Saree Catalog', '3 Products', const Color(0xFF2E7D32), '20%'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Order Payment Approvals list header
          Text(
            'Order Payment Verifications',
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Order verification cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              final isPending = order['status'] == 'Pending Verification';

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order['shop'],
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF4A0516),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          order['status'],
                          style: GoogleFonts.manrope(
                            color: isPending ? const Color(0xFFE65100) : const Color(0xFF2E7D32),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Items: ${order['items']}', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
                    Text('Amount: ${order['amount']}', style: GoogleFonts.manrope(color: const Color(0xFF700D28), fontSize: 13, fontWeight: FontWeight.bold)),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.phone_iphone_rounded, size: 14, color: Color(0xFF7A6F6F)),
                        const SizedBox(width: 4),
                        Text(order['mobile'], style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 11)),
                        const SizedBox(width: 16),
                        const Icon(Icons.receipt_rounded, size: 14, color: Color(0xFF7A6F6F)),
                        const SizedBox(width: 4),
                        Text('Txn ID: ${order['txnId']}', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 11)),
                      ],
                    ),
                    if (isPending) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => onApprovePayment(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Approve', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => onRejectPayment(index),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFC62828)),
                                foregroundColor: const Color(0xFFC62828),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('Reject', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.manrope(color: const Color(0xFF4A0516), fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 9.5),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, String val, Color color, String percent) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF4A0516),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                val,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF7A6F6F),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
        Text(
          percent,
          style: GoogleFonts.manrope(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  PieChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    double total = values.fold(0.0, (sum, item) => sum + item);
    if (total == 0.0) return;

    double startAngle = -3.1415926535 / 2; // start from top
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (int i = 0; i < values.length; i++) {
      double sweepAngle = (values[i] / total) * 2 * 3.1415926535;
      paint.color = colors[i];
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
