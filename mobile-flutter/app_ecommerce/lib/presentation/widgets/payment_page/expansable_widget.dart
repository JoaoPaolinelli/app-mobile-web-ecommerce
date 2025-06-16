// lib/presentation/widgets/common/expandable_section.dart

import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/core/constants/app_sizes.dart';
import 'package:app_ecommerce/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ExpandableSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget child;

  const ExpandableSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isExpanded,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          // Header clicável
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
              child: Row(
                children: [
                  // Título e subtítulo
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: AppSizes.xs),
                        Text(
                          subtitle,
                          style: AppTextStyles.cartProductDescription.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Ícone que gira
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.expand_more, color: AppColors.surface),
                  ),
                ],
              ),
            ),
          ),

          // Conteúdo expansível
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: AppSizes.sm),
              child: child,
            ),
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
