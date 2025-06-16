// lib/presentation/widgets/payment_page/full_price_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class TotalPagarWidget extends StatelessWidget {
  const TotalPagarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final total = cartController.cartItems.fold<double>(
        0.0,
        (soma, item) => soma + item.price * item.quantity,
      );

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total a pagar",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
            Text(
              "R\$ ${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      );
    });
  }
}
