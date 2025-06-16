// lib/presentation/widgets/payment_page/bag_widget.dart
import 'package:app_ecommerce/presentation/widgets/cart_page/product_cart_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/payment_controller.dart';

class SacolaWidget extends StatelessWidget {
  const SacolaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();

    return Obx(() {
      final items = cartController.cartItems;
      final totalItems = items.fold<int>(0, (sum, i) => sum + i.quantity);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Sacola',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text('Você possui $totalItems itens adicionados'),
            trailing: IconButton(
              icon: Icon(
                paymentController.isBagExpanded.value
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              onPressed: paymentController.toggleBag,
            ),
          ),

          // Listagem condicionada
          if (paymentController.isBagExpanded.value)
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ProductCartCard(
                  imageUrl: item.imageUrl,
                  title: item.title,
                  description: item.description,
                  price: item.price,
                  quantity: item.quantity,
                  onAdd: () {
                    cartController.increaseQuantity(
                      cartController.cartItems.indexOf(item),
                    );
                  },
                  onRemove: () {
                    final idx = cartController.cartItems.indexOf(item);
                    cartController.decreaseQuantity(idx);
                  },
                ),
              ),
            ),
        ],
      );
    });
  }
}
