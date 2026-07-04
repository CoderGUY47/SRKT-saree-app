import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsTab extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final List<String> categories;
  final Function(String) onAddCategory;
  final Function(int) onDeleteCategory;
  final Function(Map<String, dynamic>) onAddProduct;
  final Function(int, Map<String, dynamic>) onEditProduct;
  final Function(int) onDeleteProduct;

  const ProductsTab({
    super.key,
    required this.products,
    required this.categories,
    required this.onAddCategory,
    required this.onDeleteCategory,
    required this.onAddProduct,
    required this.onEditProduct,
    required this.onDeleteProduct,
  });

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final _newCategoryController = TextEditingController();

  @override
  void dispose() {
    _newCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Categories',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF4A0516),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF700D28)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFFFAF6F0),
                      title: Text(
                        'Add New Category',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF4A0516),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: TextFormField(
                        controller: _newCategoryController,
                        decoration: InputDecoration(
                          hintText: 'e.g. Cotton Sarees',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                        ElevatedButton(
                          onPressed: () {
                            final text = _newCategoryController.text.trim();
                            if (text.isNotEmpty) {
                              widget.onAddCategory(text);
                              _newCategoryController.clear();
                              Navigator.pop(ctx);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF700D28)),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: widget.categories.asMap().entries.map((entry) {
              int idx = entry.key;
              String cat = entry.value;
              return Chip(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFFE8E5E5)),
                ),
                label: Text(cat, style: GoogleFonts.manrope(color: const Color(0xFF4A0516), fontSize: 12)),
                onDeleted: () => widget.onDeleteCategory(idx),
                deleteIconColor: const Color(0xFFC62828),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Products Catalog
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wholesale Catalog',
                style: GoogleFonts.manrope(
                  color: const Color(0xFF4A0516),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  final nameController = TextEditingController();
                  final moqController = TextEditingController(text: '5 Pieces');
                  final priceController = TextEditingController(text: '₹2,500');
                  final imgController = TextEditingController(text: 'assets/images/products/saree-1.png');

                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFFFAF6F0),
                      title: Text(
                        'Add New Saree Product',
                        style: GoogleFonts.manrope(
                          color: const Color(0xFF4A0516),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(labelText: 'Saree Name'),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: moqController,
                              decoration: const InputDecoration(labelText: 'Wholesale MOQ'),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: priceController,
                              decoration: const InputDecoration(labelText: 'Wholesale Price'),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: imgController,
                              decoration: const InputDecoration(labelText: 'Manage Product Image (Asset Path)'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                        ElevatedButton(
                          onPressed: () {
                            if (nameController.text.trim().isNotEmpty) {
                              widget.onAddProduct({
                                'name': nameController.text.trim(),
                                'moq': moqController.text.trim(),
                                'price': priceController.text.trim(),
                                'image': imgController.text.trim(),
                              });
                              Navigator.pop(ctx);
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF700D28)),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.add_circle_outline_rounded, size: 16),
                label: Text('Add Product', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF700D28),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.products.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final prod = widget.products[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE8E5E5)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        prod['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.image,
                          size: 40,
                          color: Color(0xFF7A6F6F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prod['name'],
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF4A0516),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('MOQ: ${prod['moq']}', style: GoogleFonts.manrope(color: const Color(0xFF7A6F6F), fontSize: 11)),
                              const SizedBox(width: 12),
                              Text('Price: ${prod['price']}', style: GoogleFonts.manrope(color: const Color(0xFF700D28), fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_note_rounded, color: Color(0xFFC59B27)),
                      onPressed: () {
                        final nameController = TextEditingController(text: prod['name']);
                        final moqController = TextEditingController(text: prod['moq']);
                        final priceController = TextEditingController(text: prod['price']);
                        final imgController = TextEditingController(text: prod['image']);

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: const Color(0xFFFAF6F0),
                            title: Text(
                              'Edit Product Details',
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF4A0516),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    decoration: const InputDecoration(labelText: 'Saree Name'),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: moqController,
                                    decoration: const InputDecoration(labelText: 'Wholesale MOQ'),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: priceController,
                                    decoration: const InputDecoration(labelText: 'Wholesale Price'),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: imgController,
                                    decoration: const InputDecoration(labelText: 'Manage Product Image (Asset Path)'),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                              ElevatedButton(
                                onPressed: () {
                                  widget.onEditProduct(index, {
                                    'name': nameController.text.trim(),
                                    'moq': moqController.text.trim(),
                                    'price': priceController.text.trim(),
                                    'image': imgController.text.trim(),
                                  });
                                  Navigator.pop(ctx);
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF700D28)),
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFC62828)),
                      onPressed: () {
                        widget.onDeleteProduct(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
