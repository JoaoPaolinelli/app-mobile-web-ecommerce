import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';

class ProfileItemTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ProfileItemTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ), // <-- mais espaçamento vertical
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16), // <-- mais espaçamento horizontal
          Expanded(child: Text(label, style: AppTextStyles.itemLabelProfile)),
        ],
      ),
    );
  }
}
