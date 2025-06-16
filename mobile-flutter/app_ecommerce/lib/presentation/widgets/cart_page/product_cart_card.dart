// lib/presentation/widgets/product_cart_card.dart

import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/core/constants/app_sizes.dart';
import 'package:app_ecommerce/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

// lib/presentation/widgets/product_cart_card.dart

import 'package:flutter/material.dart';

class ProductCartCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCartCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // padding interno mais enxuto
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem menor
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius / 2),
              child: Image.network(
                imageUrl,
                width: AppSizes.defaultControlHeight, // de 1.2x para 1x
                height: AppSizes.defaultControlHeight,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            // Texto compacto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.productName.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    description,
                    style: AppTextStyles.productSub.copyWith(fontSize: 8),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    'R\$ ${price.toStringAsFixed(2)}',
                    style: AppTextStyles.productPrice.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.sm),

            // Botão de quantidade compacto
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.xs,
                vertical: AppSizes.xs / 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.purchaseButton,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(
                      Icons.remove,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.xs,
                    ),
                    child: Text(
                      quantity.toString(),
                      style: AppTextStyles.productPrice.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onAdd,
                    child: const Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
