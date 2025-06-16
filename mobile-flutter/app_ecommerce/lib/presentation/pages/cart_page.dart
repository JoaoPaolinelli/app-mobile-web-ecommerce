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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CartAppBar(
              onBack: () => Get.back(),
              onClear: cartController.clearCart,
            ),
            const SizedBox(height: 8),
            const DeliveryInfoCard(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.symmetric(horizontal: 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cupom', style: AppTextStyles.cartCouponTitle),
                  const SizedBox(height: 6),
                  const Text(
                    'Você precisa entrar ou criar uma conta para adicionar um cupom',
                    style: AppTextStyles.cartCouponSubtitle,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 400,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD9D9D9).withOpacity(0.7),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Entrar ou fazer cadastro",
                        style: AppTextStyles.cartLoginButton,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Produtos selecionados',
                  style: AppTextStyles.cartProductsTitle,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: cartController.cartItems.length,
                  padding: const EdgeInsets.only(bottom: 8),
                  itemBuilder: (context, index) {
                    final item = cartController.cartItems[index];
                    return Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      margin: EdgeInsets.symmetric(horizontal: 32),
                      child: ProductCartCard(
                        imageUrl: item.imageUrl,
                        title: item.title,
                        description: item.description,
                        price: item.price,
                        quantity: item.quantity,
                        onAdd: () => cartController.increaseQuantity(index),
                        onRemove: () => cartController.decreaseQuantity(index),
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => CheckoutSection(
                total: cartController.total,
                onCheckout: () => Get.toNamed(AppRoutes.phoneNumber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
