import 'package:flutter/material.dart';

class TotalPagarWidget extends StatelessWidget {
  final String valor;
  const TotalPagarWidget({super.key, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total a pagar',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.26,
          ),
        ),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.26,
          ),
        ),
      ],
    );
  }
}
