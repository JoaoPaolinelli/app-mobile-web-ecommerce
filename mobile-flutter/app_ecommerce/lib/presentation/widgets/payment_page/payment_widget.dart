// lib/presentation/widgets/payment_page/payment_widget.dart
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagamentoWidget extends StatelessWidget {
  const PagamentoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pagamento",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.payments, size: 20),
            title: Text(
              controller.metodoPagamento.value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _mostrarOpcoesPagamento(context, controller),
            ),
          ),
        ),
        const Divider(color: Color(0x4D000000)),
      ],
    );
  }

  void _mostrarOpcoesPagamento(
    BuildContext context,
    PaymentController controller,
  ) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("PIX"),
                onTap: () {
                  controller.salvarMetodoPagamento("PIX");
                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Cartão de Crédito"),
                onTap: () {
                  controller.salvarMetodoPagamento("Cartão de Crédito");
                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Boleto Bancário"),
                onTap: () {
                  controller.salvarMetodoPagamento("Boleto Bancário");
                  Get.back();
                },
              ),
            ],
          ),
    );
  }
}
