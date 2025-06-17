// lib/presentation/widgets/home_page/product_section.dart
import 'package:flutter/material.dart';
import 'product_card.dart';
import 'section_header.dart';
import '../../../core/constants/app_sizes.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final List products;

  const ProductSection({
    required this.title,
    required this.onTap,
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SectionHeader(title: title),
        SizedBox(height: AppSizes.md),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSizes.md),
            itemBuilder: (_, i) => ProductCard(product: products[i]),
          ),
        ),
      ],
    );
  }
}
