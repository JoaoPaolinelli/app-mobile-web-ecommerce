import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16),
          Text(label, style: AppTextStyles.sectionTitle),
        ],
      ),
    );
  }
}
