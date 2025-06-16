import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntregaWidget extends StatelessWidget {
  const EntregaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();

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
          () => Row(
            children: [
              const Icon(Icons.person, size: 25),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Identificação no pedido',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.cpf.value,
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
                onPressed:
                    () => _editarCampo(
                      context,
                      'CPF',
                      controller.cpf.value,
                      controller.salvarCpf,
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Endereço
        Obx(
          () => Row(
            children: [
              const Icon(Icons.location_city, size: 25),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Endereço de entrega',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.endereco.value,
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
                onPressed:
                    () => _editarCampo(
                      context,
                      'Endereço',
                      controller.endereco.value,
                      controller.salvarEndereco,
                    ),
              ),
            ],
          ),
        ),

        const Divider(color: Color(0x4D000000)),
      ],
    );
  }

  void _editarCampo(
    BuildContext context,
    String label,
    String valorAtual,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: valorAtual);
    Get.dialog(
      AlertDialog(
        title: Text('Editar $label'),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Get.back();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
