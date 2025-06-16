// lib/presentation/pages/category_products_page.dart
import 'package:app_ecommerce/presentation/controllers/category_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/app_nav_bar.dart';
import 'package:app_ecommerce/presentation/widgets/home_page/product_card.dart';
import '../controllers/home_controller.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryProductsController cpc = Get.put(CategoryProductsController());
  final HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    // Decodifica nome da categoria (caso venha codificado na URL)
    final categoryTitle = Uri.decodeComponent(cpc.category);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(categoryTitle, style: AppTextStyles.sectionTitle),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Obx(() {
        if (cpc.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cpc.products.isEmpty) {
          return Center(
            child: Text(
              'Nenhum produto em "$categoryTitle"',
              style: AppTextStyles.sectionTitle,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: GridView.builder(
            itemCount: cpc.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.md,
              mainAxisSpacing: AppSizes.md,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, i) {
              final product = cpc.products[i];
              return ProductCard(product: product);
            },
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () => AppBottomNav(
          currentIndex: hc.navIndex.value,
          onTap: (i) => hc.navIndex.value = i,
        ),
      ),
    );
  }
}
