import 'package:flutter/material.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/random_images.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Usa a URL do model se existir, senão sorteia uma asset
    final imageWidget =
        (product.imageUrl.isNotEmpty)
            ? Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) =>
                      Image.asset(RandomImage.next(), fit: BoxFit.cover),
            )
            : Image.asset(RandomImage.next(), fit: BoxFit.cover);

    return SizedBox(
      width: 140,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        child: Column(
          children: [
            // Imagem com badge de desconto se houver
            Stack(
              children: [
                AspectRatio(aspectRatio: 1, child: imageWidget),
                if (product.hasDiscount && product.discountValue > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bannerButtonBg,
                        borderRadius: BorderRadius.circular(
                          AppSizes.buttonRadius,
                        ),
                      ),
                      child: Text(
                        '-${(product.discountValue * 100).toInt()}%',
                        style: AppTextStyles.sectionLink.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Conteúdo textual
            Padding(
              padding: const EdgeInsets.all(AppSizes.cardSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do produto
                  Text(
                    product.name,
                    style: AppTextStyles.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Categoria (no lugar de subtitle)
                  Text(
                    product.category,
                    style: AppTextStyles.productSub,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Preço e botão
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'R\$ ${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.productPrice,
                        ),
                      ),
                      InkWell(
                        onTap: () {}, // adicionar ao carrinho
                        borderRadius: BorderRadius.circular(
                          AppSizes.buttonRadius,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.purchaseButton,
                            borderRadius: BorderRadius.circular(
                              AppSizes.buttonRadius,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: AppSizes.iconSize,
                            color: AppColors.purchaseIcon,
                          ),
                        ),
                      ),
                    ],
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
