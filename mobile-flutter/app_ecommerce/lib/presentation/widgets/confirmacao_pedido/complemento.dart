import 'package:app_ecommerce/presentation/controllers/confirmar_pagamento_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ComplementoInput extends StatelessWidget {
  final String initialValue;

  const ComplementoInput({super.key, this.initialValue = '208'});

  @override
  Widget build(BuildContext context) {
    final confirmacaoController = Get.put(ConfirmacaoController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complemento',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: confirmacaoController.complementoController,
          decoration: const InputDecoration(border: UnderlineInputBorder()),
        ),
        const SizedBox(height: 16),
        const Text(
          'Instruções de entrega',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: confirmacaoController.instrucoesController,
          decoration: const InputDecoration(hintText: 'Mensagem ao entregador'),
        ),
      ],
    );
  }
}
