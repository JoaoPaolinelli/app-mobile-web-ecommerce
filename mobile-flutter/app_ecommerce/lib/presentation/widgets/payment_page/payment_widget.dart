// lib/presentation/widgets/payment_page/payment_widget.dart
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagamentoWidget extends StatelessWidget {
  const PagamentoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentCtrl = Get.find<PaymentController>();
    final userCtrl = Get.find<UserController>();

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
              paymentCtrl.metodoPagamento.value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed:
                  () => _mostrarOpcoesPagamento(context, paymentCtrl, userCtrl),
            ),
          ),
        ),
        const Divider(color: Color(0x4D000000)),
      ],
    );
  }

  void _mostrarOpcoesPagamento(
    BuildContext context,
    PaymentController paymentCtrl,
    UserController userCtrl,
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
                  paymentCtrl.salvarMetodoPagamento("PIX");
                  userCtrl.updatePaymentMethod("PIX");
                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Cartão de Crédito"),
                onTap: () {
                  paymentCtrl.salvarMetodoPagamento("CREDIT_CARD");
                  userCtrl.updatePaymentMethod("CREDIT_CARD");

                  Get.back();
                },
              ),
              ListTile(
                title: const Text("Boleto Bancário"),
                onTap: () {
                  paymentCtrl.salvarMetodoPagamento("BOLETO");
                  userCtrl.updatePaymentMethod("BOLETO");
                  Get.back();
                },
              ),
            ],
          ),
    );
  }
}
