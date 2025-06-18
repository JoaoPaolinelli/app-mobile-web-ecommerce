// lib/presentation/pages/confirmacao_pedido_page.dart
import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/presentation/controllers/confirmar_pagamento_controller.dart';
import 'package:app_ecommerce/presentation/controllers/notification_controller.dart';
import 'package:app_ecommerce/presentation/controllers/order_controller.dart';
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/widgets/confirmacao_pedido/complemento.dart';
import 'package:app_ecommerce/presentation/widgets/confirmacao_pedido/info_tile.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/full_price_widget.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmacaoPedidoPage extends StatelessWidget {
  const ConfirmacaoPedidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.find<PaymentController>();
    final confirmController = Get.put(ConfirmacaoPedidoController());
    final notificationCtrl = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => ListView(
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Confirmação do pedido',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Agrupamento visual elegante
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      children: [
                        InfoTile(
                          icon: Icons.location_on,
                          title: 'Endereço de entrega',
                          subtitle: paymentController.endereco.value,
                        ),
                        _divider(),
                        InfoTile(
                          icon: Icons.date_range,
                          title: 'Data da entrega',
                          subtitle: 'Entre os dias 12/06 e 20/06',
                        ),
                        _divider(),
                        InfoTile(
                          icon: Icons.payment,
                          title: 'Pagamento',
                          subtitle: paymentController.metodoPagamento.value,
                          iconColor: AppColors.bannerButtonBg,
                        ),
                        _divider(),
                        const InfoTile(
                          icon: Icons.card_giftcard,
                          title: 'Cupom',
                          subtitle: 'Nenhum código promocional em uso',
                        ),
                        _divider(),
                        const InfoTile(
                          icon: Icons.delivery_dining,
                          title: 'Frete',
                          subtitle: 'Nenhuma entrega gratuita em uso',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ComplementoInput com parâmetros originais
                ComplementoInput(
                  initialComplement:
                      confirmController.complementoController.text,
                  initialInstructions:
                      confirmController.instrucoesController.text,
                  onComplementChanged:
                      (val) =>
                          confirmController.complementoController.text = val,
                  onInstructionsChanged:
                      (val) =>
                          confirmController.instrucoesController.text = val,
                ),

                const SizedBox(height: 24),
                const TotalPagarWidget(),
                const SizedBox(height: 24),

                // Botão de confirmar, bloqueado quando loading
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: PrimaryButton(
                    text:
                        confirmController.isLoading.value
                            ? 'Enviando...'
                            : 'Confirmar pedido',
                    onPressed: () {
                      if (confirmController.isLoading.value) return;
                      confirmController.confirmarPedido().then((_) {
                        // disparar notificações
                        notificationCtrl.ring();
                        Get.find<OrderController>().fetchHistory();
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          notificationCtrl.ring();
                        });
                      });
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

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
  );
}
