//NEW ONE
// lib/presentation/pages/home_page.dart

import 'package:app_ecommerce/presentation/controllers/notification_controller.dart';
import 'package:app_ecommerce/presentation/pages/product_list_page.dart';
// import 'package:app_ecommerce/presentation/widgets/notification_widget.dart';
import 'package:app_ecommerce/presentation/widgets/notification_widget.dart';
// import 'package:app_ecommerce/presentation/widgets/notification_panel.dart';
// import 'package:app_ecommerce/presentation/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';

import '../widgets/home_page/banner_widget.dart';
import '../widgets/home_page/section_header.dart';
import '../widgets/home_page/product_section.dart';
import '../widgets/app_nav_bar.dart';
import '../../models/product_model.dart';
import '../widgets/home_page/product_card.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CartController cartController = Get.find<CartController>();
  final NotificationController nc = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // retiramos o appBar estático e passamos tudo para o CustomScrollView
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            floating: false,
            snap: false,
            pinned: false,
            toolbarHeight: 112,
            leadingWidth: 160,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.md),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: NotificationIcon(),
                ),
              ),
            ],
          ),

          // Todo o resto do corpo vira um único SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner
                  SizedBox(
                    height: 180,
                    child: BannerWidget(banner: controller.banner),
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Seção "Mais Pedidos"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: SectionHeader(
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
                  ),
                  ProductSection(
                    title: 'Mais pedidos',
                    onTap: () {},
                    products: controller.mostOrdered,
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Seção "Favoritos da Região"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: SectionHeader(
                      title: 'Favoritos da Região',
                      onTap: () {
                        Get.to(
                          () => GenericListingPage<ProductModel>(
                            title: 'Favoritos da Região',
                            items: controller.favorites,
                            itemBuilder: (p) => ProductCard(product: p),
                          ),
                        );
                      },
                    ),
                  ),
                  ProductSection(
                    title: 'Favoritos da região',
                    onTap: () => controller.navIndex.value = 1,
                    products: controller.favorites,
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Seção "Todos os Produtos"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: SectionHeader(
                      title: 'Todos os Produtos',
                      onTap: () {
                        Get.to(
                          () => GenericListingPage<ProductModel>(
                            title: 'Todos os Produtos',
                            items: controller.favorites,
                            itemBuilder: (p) => ProductCard(product: p),
                          ),
                        );
                      },
                    ),
                  ),

                  // ProductSection(
                  //   title: 'Todos os Produtos',
                  //   onTap: () => controller.navIndex.value = 1,
                  //   products: controller.allProducts,
                  // ),
                  // const SizedBox(height: AppSizes.lg),
                  ProductSection(
                    title: 'Todos os Produtos',
                    onTap: () => controller.navIndex.value = 1,
                    products: controller.favorites,
                  ),
                ],
              );
            }),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.sm),
        child: AppBottomNav(),
      ),
    );
  }
}
