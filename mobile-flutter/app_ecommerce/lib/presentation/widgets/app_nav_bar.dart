import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Lista de pares [assetName, rota]
    final items = [
      ['home.png', '/home'],
      ['category.png', '/category'],
      ['search.png', '/search'],
      ['profile.png', '/profile'],
      ['cart.png', '/cart'],
    ];

    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        // margin: const EdgeInsets.all(AppSizes.padding / 2),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,

          // vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius * 1.5),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final asset = 'assets/icons/${items[i][0]}';
            final route = items[i][1];
            final isActive = i == currentIndex;
            return GestureDetector(
              onTap: () {
                if (currentIndex != i) {
                  onTap(i);
                  Get.offNamed(route);
                }
              },
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  isActive
                      ? AppColors.bannerButtonBg
                      : AppColors.textSecondary.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  asset,
                  width: AppSizes.iconSize,
                  height: AppSizes.iconSize,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
