import 'package:flutter/material.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cupom',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        const Text(
          'Você precisa entrar ou criar uma conta para adicionar um cupom',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 333,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xB3D9D9D9), // 70%
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              'Entrar ou fazer cadastro',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
