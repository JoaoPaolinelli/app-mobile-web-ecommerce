import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../presentation/controllers/cart_controller.dart';
import '../../presentation/controllers/home_controller.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/home_page/banner_widget.dart';
import '../widgets/home_page/product_section.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.md),
            child: IconButton(
              icon: const Icon(Icons.notifications),
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
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                child: BannerWidget(banner: controller.banner),
              ),
              const SizedBox(height: AppSizes.lg),
              ProductSection(
                title: 'Mais pedidos',
                onTap: () => controller.navIndex.value = 1,
                products: controller.mostOrdered,
              ),
              const SizedBox(height: AppSizes.lg),
              ProductSection(
                title: 'Favoritos da região',
                onTap: () => controller.navIndex.value = 1,
                products: controller.favorites,
              ),
              const SizedBox(height: AppSizes.lg),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.sm),
          child: AppBottomNav(
            currentIndex: controller.navIndex.value,
            onTap: (i) => controller.navIndex.value = i,
          ),
        );
      }),
    );
  }
}
