import 'package:app_ecommerce/core/utils/random_images_service.dart';
import 'package:app_ecommerce/presentation/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/random_images.dart';
import '../../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    // Imagem ou placeholder
    final imageWidget =
        product.imageUrl.isNotEmpty
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
          mainAxisSize: MainAxisSize.min, // <-- minimiza vertical
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Imagem com proporção fixa
            AspectRatio(aspectRatio: 1, child: imageWidget),

            // 2) Conteúdo textual e botões
            Padding(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min, // <-- minimiza vertical
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome e categoria
                  Text(
                    product.name,
                    style: AppTextStyles.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    product.category,
                    style: AppTextStyles.productSub,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.sm),

                  // Preço + botão ou controles de quantidade
                  Row(
                    children: [
                      // Preço ocupa o que puder
                      Expanded(
                        child: Text(
                          'R\$ ${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.productPrice,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Controle de adicionar/remover
                      Obx(() {
                        final idx = cartController.cartItems.indexWhere(
                          (i) =>
                              i.title == product.name &&
                              i.description == (product.description ?? ''),
                        );
                        if (idx >= 0) {
                          final qty = cartController.cartItems[idx].quantity;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.xs,
                              vertical: AppSizes.xs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.purchaseButton,
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Botão “–”
                                GestureDetector(
                                  onTap:
                                      () =>
                                          cartController.decreaseQuantity(idx),
                                  child: const Icon(
                                    Icons.remove,
                                    size: AppSizes.iconSize,
                                    color: AppColors.purchaseIcon,
                                  ),
                                ),
                                // Quantidade
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.xs,
                                  ),
                                  child: Text(
                                    qty.toString(),
                                    style: AppTextStyles.productPrice.copyWith(
                                      color: Colors.white, // faz o texto branco
                                      fontWeight:
                                          FontWeight.bold, // deixa em negrito
                                    ),
                                  ),
                                ),
                                // Botão “+”
                                GestureDetector(
                                  onTap:
                                      () =>
                                          cartController.increaseQuantity(idx),
                                  child: const Icon(
                                    Icons.add,
                                    size: AppSizes.iconSize,
                                    color: AppColors.purchaseIcon,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Estado inicial: só o “+”
                        return GestureDetector(
                          onTap: () {
                            cartController.addToCart(
                              CartItem(
                                imageUrl: RandomImageService.getImageFor(
                                  product.name,
                                ),
                                title: product.name,
                                description: product.description ?? '',
                                price: product.price.toDouble(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.xs),
                            decoration: BoxDecoration(
                              color: AppColors.purchaseButton,
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: AppSizes.iconSize,
                              color: AppColors.purchaseIcon,
                            ),
                          ),
                        );
                      }),
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
