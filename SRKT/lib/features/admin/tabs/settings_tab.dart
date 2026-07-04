import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTab extends StatefulWidget {
  final TextEditingController whatsappController;
  final Function() onSaveSettings;

  const SettingsTab({
    super.key,
    required this.whatsappController,
    required this.onSaveSettings,
  });

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final _pdfLinkController = TextEditingController(text: 'https://srktcollection.com/catalogue-2026.pdf');

  @override
  void dispose() {
    _pdfLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand Configurations',
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Configure global customer actions and wholesale numbers.',
            style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 12),
          ),
          const SizedBox(height: 20),

          // Active WhatsApp contact number input
          Text(
            'Active WhatsApp Contact Number',
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.whatsappController,
            decoration: InputDecoration(
              hintText: 'e.g., 919876543210',
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
            ),
          ),
          const SizedBox(height: 16),

          // Change catalog download PDF path
          Text(
            'Wholesale PDF Catalogue Link',
            style: GoogleFonts.manrope(
              color: const Color(0xFF4A0516),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _pdfLinkController,
            decoration: InputDecoration(
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
            ),
          ),
          const SizedBox(height: 12),

          // Upload catalogue button
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'PDF Catalog updated successfully!',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color(0xFF700D28),
                ),
              );
            },
            icon: const Icon(Icons.upload_file_rounded, size: 16),
            label: Text(
              'Upload & Update Catalogue PDF',
              style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF700D28),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: widget.onSaveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF700D28),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Save Settings',
                style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
