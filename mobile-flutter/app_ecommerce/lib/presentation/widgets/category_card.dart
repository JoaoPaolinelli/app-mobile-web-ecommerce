// lib/presentation/widgets/category_card.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Card de categoria com ícone vetorial e título abaixo
class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final gap = AppSizes.md;
    final horizontalPadding = AppSizes.md * 2;
    final itemWidth = (totalWidth - horizontalPadding - gap * 2) / 3;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Card clicável com ícone
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          child: Container(
            height: itemWidth,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            padding: const EdgeInsets.all(AppSizes.sm),
            child: Center(
              child: FaIcon(
                icon,
                size: AppSizes.xl * 1.2,
                color: AppColors.purchaseButton,
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSizes.sm),

        // Título abaixo do ícone
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: AppTextStyles.sectionTitle.copyWith(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
