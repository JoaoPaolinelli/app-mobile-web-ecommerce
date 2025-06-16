// lib/presentation/pages/category_products_page.dart

import 'package:app_ecommerce/presentation/widgets/app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../controllers/category_product_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_page/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  // Controllers
  final CategoryProductsController cpc = Get.put(CategoryProductsController());
  final HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    // Decodifica eventuais parâmetros de URL
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.md,
              mainAxisSpacing: AppSizes.md,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, i) => ProductCard(product: cpc.products[i]),
          ),
        );
      }),
      // Não envolve em Obx — o próprio AppBottomNav já é reativo
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
