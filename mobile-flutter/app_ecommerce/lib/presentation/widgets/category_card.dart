// lib/presentation/widgets/category_card.dart
import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Card de categoria sem contagem, só imagem e título abaixo
class CategoryCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card com imagem clicável
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              imageAsset,
              height: 136, // mesma altura do destaque
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Título abaixo da imagem
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
