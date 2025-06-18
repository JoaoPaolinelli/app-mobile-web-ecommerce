import 'package:flutter/material.dart';
import '../../../core/constants/app_text_styles.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32), // espaçamento acima do título
        Text(title, style: AppTextStyles.sectionTitleProfile),
        const SizedBox(height: 12),
        const Divider(
          thickness: 1,
          height: 1,
          color: Color(0xFFE0E0E0), // cinza leve, ajustável
        ),
        const SizedBox(height: 16), // espaçamento abaixo da linha
      ],
    );
  }
}
