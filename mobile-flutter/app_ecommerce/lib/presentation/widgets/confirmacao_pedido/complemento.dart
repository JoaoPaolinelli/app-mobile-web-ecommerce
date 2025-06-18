// lib/presentation/widgets/confirmacao_pedido/complemento.dart
import 'package:app_ecommerce/presentation/controllers/confirmar_pagamento_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplementoInput extends StatelessWidget {
  const ComplementoInput({
    super.key,
    required String initialComplement,
    required String initialInstructions,
    required Function(dynamic val) onComplementChanged,
    required Function(dynamic val) onInstructionsChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Usa Get.find pois o controller já foi injetado na página
    final confirmCtrl = Get.find<ConfirmacaoPedidoController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complemento',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: confirmCtrl.complementoController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Número, apartamento, bloco etc.',
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Instruções de entrega',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: confirmCtrl.instrucoesController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Mensagem ao entregador',
          ),
        ),
      ],
    );
  }
}
