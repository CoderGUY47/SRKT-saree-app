import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnquiriesTab extends StatelessWidget {
  final List<Map<String, dynamic>> enquiries;

  const EnquiriesTab({
    super.key,
    required this.enquiries,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: enquiries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final enq = enquiries[index];
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
                    enq['name'],
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF4A0516),
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    enq['date'],
                    style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Shop: ${enq['shop']}',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF700D28),
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                enq['message'],
                style: GoogleFonts.manrope(
                  color: const Color(0xFF7A6F6F),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
