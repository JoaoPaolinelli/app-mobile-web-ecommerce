import 'package:app_ecommerce/presentation/controllers/cart_controller.dart';
import 'package:app_ecommerce/presentation/widgets/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/theme/app_theme.dart';
import '../controllers/home_controller.dart';
import '../widgets/banner_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 112,
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Image.asset(
            'assets/images/logo.png',
            // height: 160,
            // width: 160 * 1.5,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.notification_add),
              iconSize: 24,

              onPressed: () {},
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner com altura fixa
              SizedBox(
                height: 180,
                child: BannerWidget(banner: controller.banner),
              ),
              const SizedBox(height: 24),

              // Mais pedidos
              SectionHeader(
                title: 'Mais pedidos',
                onTap: () => controller.navIndex.value = 1,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.mostOrdered.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder:
                      (_, i) => ProductCard(product: controller.mostOrdered[i]),
                ),
              ),
              const SizedBox(height: 32),

              // Favoritos
              SectionHeader(
                title: 'Favoritos da região',
                onTap: () => controller.navIndex.value = 1,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favorites.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder:
                      (_, i) => ProductCard(product: controller.favorites[i]),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AppBottomNav(
            currentIndex: controller.navIndex.value,
            onTap: (i) => controller.navIndex.value = i,
          ),
        );
      }),
    );
  }
}
