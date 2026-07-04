import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersTab extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final Function(int) onApproveUser;
  final Function(int) onRejectUser;

  const UsersTab({
    super.key,
    required this.users,
    required this.onApproveUser,
    required this.onRejectUser,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: users.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = users[index];
        final isPending = user['status'] == 'Pending';

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
                    user['name'],
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF4A0516),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPending ? const Color(0xFFFFF2E2) : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      user['status'],
                      style: GoogleFonts.manrope(
                        color: isPending ? const Color(0xFFE65100) : const Color(0xFF2E7D32),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Shop: ${user['shop']}',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF4A0516),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Email: ${user['email']}', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
              Text('Mobile: ${user['mobile']}', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12)),
              if (isPending) ...[
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onApproveUser(index),
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
                        onPressed: () => onRejectUser(index),
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
    );
  }
}
