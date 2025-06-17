import 'package:app_ecommerce/models/product_model.dart';
import 'package:app_ecommerce/presentation/controllers/notification_controller.dart';
import 'package:app_ecommerce/presentation/pages/product_list_page.dart';
import 'package:app_ecommerce/presentation/widgets/home_page/product_card.dart';
import 'package:app_ecommerce/presentation/widgets/home_page/section_header.dart';
import 'package:app_ecommerce/presentation/widgets/notification_widget.dart';
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
  final nc = Get.put(NotificationController());

  // final bc = Get.find<NotificationController>();

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
            // Aqui trocamos o IconButton por BellIcon
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: SizedBox(width: 64, height: 64, child: NotificationIcon()),
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
              SectionHeader(
                title: 'Mais Pedidos',
                onTap: () {
                  Get.to(
                    () => GenericListingPage<ProductModel>(
                      title: 'Mais Pedidos',
                      items: controller.mostOrdered,
                      itemBuilder: (p) => ProductCard(product: p),
                    ),
                  );
                },
              ),
              ProductSection(
                title: 'Mais pedidos',
                onTap: () => {},
                products: controller.favorites,
              ),
              const SizedBox(height: AppSizes.lg),
              SectionHeader(
                title: 'Favoritos da Região',
                onTap: () {
                  Get.to(
                    () => GenericListingPage<ProductModel>(
                      title: 'Favoritos da Região',
                      items: controller.mostOrdered,
                      itemBuilder: (p) => ProductCard(product: p),
                    ),
                  );
                },
              ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.sm),
        child: AppBottomNav(),
      ),
    );
  }
}
