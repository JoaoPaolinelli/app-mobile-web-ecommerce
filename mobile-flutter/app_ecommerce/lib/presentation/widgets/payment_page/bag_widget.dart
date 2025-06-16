import 'package:flutter/material.dart';

class SacolaWidget extends StatelessWidget {
  const SacolaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Sacola',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Você possui 6 itens adicionados',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 2,
          ),
        ),
        const Divider(color: Color(0x4D000000)),
      ],
    );
  }
}
