import 'package:flutter/material.dart';
import '../../core/constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text('Ver mais', style: AppTextStyles.sectionLink),
        ),
      ],
    );
  }
}
