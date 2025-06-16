// main_cart_page.dart
import 'package:app_ecommerce/presentation/controllers/cart_controller.dart';
import 'package:app_ecommerce/presentation/widgets/cart_page/cart_app_bar.dart';
import 'package:app_ecommerce/presentation/widgets/cart_page/checkout_section.dart';
import 'package:app_ecommerce/presentation/widgets/cart_page/delivery_info_card.dart';
import 'package:app_ecommerce/presentation/widgets/cart_page/product_cart_card.dart';
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_sizes.dart';

class CartPage extends StatelessWidget {
  final CartController cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CartAppBar(onBack: Get.back, onClear: cart.clearCart),
            const SizedBox(height: AppSizes.sm),
            const DeliveryInfoCard(),
            const SizedBox(height: AppSizes.lg),

            // Cupom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cupom', style: AppTextStyles.cartCouponTitle),
                  const SizedBox(height: AppSizes.xs),
                  const Text(
                    'Você precisa entrar ou criar uma conta para adicionar um cupom',
                    style: AppTextStyles.cartCouponSubtitle,
                  ),
                  const SizedBox(height: AppSizes.lg),
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.defaultControlHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purchaseButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Entrar ou fazer cadastro",
                        style: AppTextStyles.cartContinueButton,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.lg),
            const Padding(
              padding: EdgeInsets.only(left: AppSizes.lg),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Produtos selecionados',
                  style: AppTextStyles.cartProductsTitle,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.xs),

            // Lista de itens (só essa parte é reativa)
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cart.cartItems.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.lg,
                    vertical: AppSizes.xs,
                  ),
                  itemBuilder: (ctx, i) {
                    final item = cart.cartItems[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.xs,
                      ),
                      child: ProductCartCard(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        description: item.description,
                        price: item.price,
                        quantity: item.quantity,
                        onAdd: () => cart.increaseQuantity(i),
                        onRemove: () => cart.decreaseQuantity(i),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Seção de checkout (título + botão)
            Obx(
              () => CheckoutSection(
                total: cart.total,
                onCheckout: () => Get.toNamed(AppRoutes.phoneNumber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
