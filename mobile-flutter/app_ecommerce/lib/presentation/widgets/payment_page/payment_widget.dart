import 'dart:ui';

import 'package:flutter/material.dart';

class PagamentoWidget extends StatelessWidget {
  const PagamentoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pagamento',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.26,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.pix),
            // Image.asset('assets/icons/pix.png', width: 20, height: 20),
            const SizedBox(width: 10),
            const Text(
              'PIX',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.26,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
        const Divider(color: Color(0x4D000000)),
      ],
    );
  }
}
