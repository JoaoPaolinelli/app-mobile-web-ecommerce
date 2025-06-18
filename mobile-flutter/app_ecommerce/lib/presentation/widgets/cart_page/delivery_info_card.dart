// delivery_info_card.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x1A0828C9), // cor com 10% opacidade
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_bike, size: 28, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              'Entrega entre 5 - 7 dias',
              style: AppTextStyles.cartDeliveryInfo,
            ),
          ],
        ),
      ),
    );
  }
}
