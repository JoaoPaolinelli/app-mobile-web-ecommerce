// lib/presentation/widgets/payment_page/full_price_widget.dart
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalPagarWidget extends StatelessWidget {
  const TotalPagarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Obx(() {
      double total = controller.produtos.fold<double>(
        0.0,
        (soma, produto) =>
            soma + (produto['preco'] as num) * (produto['quantidade'] as num),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total a pagar",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          Text(
            "R\$ ${total.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ],
      );
    });
  }
}
