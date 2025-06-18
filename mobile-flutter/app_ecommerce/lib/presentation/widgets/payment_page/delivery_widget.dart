// lib/presentation/widgets/payment_page/delivery_widget.dart
import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntregaWidget extends StatelessWidget {
  const EntregaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentCtrl = Get.find<PaymentController>();
    final userCtrl = Get.find<UserController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Entrega',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),

        // CPF
        Obx(
          () => _buildRow(
            icon: Icons.person,
            label: 'Identificação no pedido',
            value: paymentCtrl.cpf.value,
            onEdit:
                () => _editarCampo(
                  context: context,
                  title: 'CPF',
                  initial: paymentCtrl.cpf.value,
                  onSave: (val) async {
                    await paymentCtrl.salvarCpf(val);
                    userCtrl.updateIdentification(val);
                  },
                ),
          ),
        ),

        const SizedBox(height: 16),

        // Endereço
        Obx(
          () => _buildRow(
            icon: Icons.location_city,
            label: 'Endereço de entrega',
            value: paymentCtrl.endereco.value,
            onEdit:
                () => _editarCampo(
                  context: context,
                  title: 'Endereço',
                  initial: paymentCtrl.endereco.value,
                  onSave: (val) async {
                    await paymentCtrl.salvarEndereco(val);
                    userCtrl.updateAddress(val);
                  },
                ),
          ),
        ),

        const Divider(color: Color(0x4D000000)),
      ],
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Row(
      children: [
        Icon(icon, size: 25),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.26,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: onEdit,
        ),
      ],
    );
  }

  void _editarCampo({
    required BuildContext context,
    required String title,
    required String initial,
    required Future<void> Function(String) onSave,
  }) {
    final fieldCtrl = TextEditingController(text: initial);
    Get.dialog(
      AlertDialog(
        title: Text('Editar $title'),
        content: TextField(
          controller: fieldCtrl,
          decoration: InputDecoration(hintText: title),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purchaseButton,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final val = fieldCtrl.text.trim();
              await onSave(val);
              Get.back();
            },
            child: const Text(
              'Salvar',
              style: TextStyle(color: AppColors.background, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
