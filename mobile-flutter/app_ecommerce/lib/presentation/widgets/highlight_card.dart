// lib/presentation/widgets/highlight_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class HighlightCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final Color stripeColor;
  final VoidCallback onTap;

  const HighlightCard({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.stripeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card apenas com imagem + faixa
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
            // A imagem ocupa todo o espaço interno
            child: Column(
              children: [
                Image.asset(
                  imageAsset,
                  height: 136, // defina em AppSizes
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Faixa colorida
                // Container(
                //   height: 5,
                //   width: double.infinity,
                //   color: stripeColor,
                // ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Título abaixo do card
        SizedBox(
          width: double.infinity,
          child: Text(
            title,
            style: AppTextStyles.productName.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
