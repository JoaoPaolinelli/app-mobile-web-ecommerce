// lib/presentation/widgets/app_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/cart_controller.dart';
import '../controllers/navigation_controller.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.find<NavigationController>();
    final cartController = Get.find<CartController>();
    // Mesma lista de ícones
    final items = [
      'home.png',
      'category.png',
      'search.png',
      'profile.png',
      'cart.png',
    ];

    return SafeArea(
      top: false,
      child: Container(
        height: 64,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius * 1.5),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Obx(() {
          // Sempre recalcula o índice a partir da rota
          final current = Get.currentRoute;
          final idxFromRoute = nav.pages.indexWhere(
            (r) => current.startsWith(r),
          );
          if (idxFromRoute != -1 && idxFromRoute != nav.currentIndex.value) {
            nav.currentIndex.value = idxFromRoute;
          }

          final cartCount = cartController.cartItems.fold<int>(
            0,
            (sum, item) => sum + item.quantity,
          );
          final badgeText = cartCount > 9 ? '9+' : '$cartCount';

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final asset = 'assets/icons/${items[i]}';
              final isActive = i == nav.currentIndex.value;

              Widget icon = ColorFiltered(
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
              );

              // badge no carrinho
              if ((i == 4 && 0 < cartCount) && cartCount <= 9) {
                icon = Stack(
                  clipBehavior: Clip.none,
                  children: [
                    icon,
                    Positioned(
                      top: -20,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.purchaseButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1.5,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (i == 4 && cartCount > 9) {
                icon = Stack(
                  clipBehavior: Clip.none,
                  children: [
                    icon,
                    Positioned(
                      top: -20,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.purchaseButton,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.surface,
                            width: 1.5,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return GestureDetector(onTap: () => nav.setPage(i), child: icon);
            }),
          );
        }),
      ),
    );
  }
}
