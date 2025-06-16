import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/presentation/controllers/confirmar_pagamento_controller.dart';
import 'package:app_ecommerce/presentation/controllers/notification_controller.dart';
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/widgets/confirmacao_pedido/complemento.dart';
import 'package:app_ecommerce/presentation/widgets/confirmacao_pedido/info_tile.dart';
import 'package:app_ecommerce/presentation/widgets/confirmacao_pedido/total_pagar.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/full_price_widget.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmacaoPedidoPage extends StatelessWidget {
  const ConfirmacaoPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.find<PaymentController>();
    final confirmacaoController = Get.put(ConfirmacaoController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => ListView(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Confirmação do pedido',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                InfoTile(
                  icon: Icons.location_on,
                  title: 'Endereço de entrega',
                  subtitle: paymentController.endereco.value,
                ),
                Divider(),

                InfoTile(
                  icon: Icons.date_range,
                  title: 'Data da entrega',
                  subtitle: 'Entre os dias 12/06 e 20/06',
                ),
                Divider(),

                InfoTile(
                  icon: Icons.payment,
                  title: 'Pagamento',
                  subtitle: paymentController.metodoPagamento.value,
                  iconColor: Colors.green,
                ),
                Divider(),

                const InfoTile(
                  icon: Icons.card_giftcard,
                  title: 'Cupom',
                  subtitle: 'Nenhum código promocional em uso',
                ),
                Divider(),

                const InfoTile(
                  icon: Icons.delivery_dining,
                  title: 'Frete',
                  subtitle: 'Nenhuma entrega gratuita em uso',
                ),
                Divider(),

                const SizedBox(height: 16),
                const ComplementoInput(),
                const SizedBox(height: 24),
                TotalPagarWidget(),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: PrimaryButton(
                    text: 'Confirmar pedido',
                    onPressed: () async {
                      confirmacaoController.confirmarPedidoSimulado();
                      Get.find<NotificationController>().ring();
                      await Future.delayed(const Duration(milliseconds: 100));
                      final bc = Get.find<NotificationController>();
                      bc.ring();
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double calcularTotal(List<dynamic> produtos) {
  double total = 0.0;
  for (var produto in produtos) {
    final preco = double.tryParse(produto['price'].toString()) ?? 0.0;
    final quantidade = produto['quantidade'] ?? 1;
    total += preco * quantidade;
  }
  return total;
}
