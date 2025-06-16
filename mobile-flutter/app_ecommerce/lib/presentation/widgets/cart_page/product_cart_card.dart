// product_cart_card.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';

class ProductCartCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCartCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 76,
              height: 74,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 230,
            height: 74,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cartProductName),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.cartProductDescription,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                Text(
                  'R\$ ${price.toStringAsFixed(2)}',
                  style: AppTextStyles.cartProductPrice,
                ),
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 58,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    quantity > 1 ? Icons.remove : Icons.delete_outline,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text('$quantity', style: AppTextStyles.cartProductQuantity),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: onAdd,
                child: Container(
                  width: 58,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.add, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
