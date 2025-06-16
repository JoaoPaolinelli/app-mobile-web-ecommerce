import 'package:flutter/material.dart';

class TotalPagarRow extends StatelessWidget {
  final String valor;

  const TotalPagarRow({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Total a pagar', style: TextStyle(fontSize: 16)),
        Text(
          valor,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
