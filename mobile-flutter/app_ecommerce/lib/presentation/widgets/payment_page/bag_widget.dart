import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SacolaWidget extends StatelessWidget {
  const SacolaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sacola',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(
                  controller.isBagExpanded.value
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 16,
                ),
                onPressed: controller.toggleBag,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Você possui ${controller.produtos.length} itens adicionados',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
          const Divider(color: Color(0x4D000000)),
          if (controller.isBagExpanded.value)
            ...controller.produtos.map((produto) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(produto['nome']),
                  subtitle: Text("R\$ ${produto['preco']}"),
                  trailing: Text("x${produto['quantidade']}"),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
