import 'package:flutter/material.dart';

class PaymentTitleWidget extends StatelessWidget {
  const PaymentTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => {}),
        const Expanded(
          child: Text(
            'Pagamento',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              color: Color(0xFF060606),
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}
