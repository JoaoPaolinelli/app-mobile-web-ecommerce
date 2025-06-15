// lib/presentation/pages/search_page.dart
import 'package:app_ecommerce/models/product_model.dart';
import 'package:app_ecommerce/presentation/delegate/product_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../presentation/widgets/app_nav_bar.dart';
import '../../presentation/widgets/product_card.dart';
import '../controllers/search_controller.dart';
import '../controllers/home_controller.dart'; // só para navIndex

class SearchPage extends StatelessWidget {
  // Controller de busca
  final SearchControllers sc = Get.put(SearchControllers());
  // Controller apenas para o BottomNav
  final HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(height: AppSizes.padding),

          // 🔎 Search Bar clicável
          GestureDetector(
            onTap: () => _openDelegate(context),
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
                border: Border.all(color: Colors.black26),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                  Icon(Icons.search, size: AppSizes.iconSize),
                  SizedBox(width: 8),
                  Text('Buscar produtos'),
                  // style: AppTextStyles.sectionTitle),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 🔄 Observa os resultados reativos
          Expanded(
            child: Obx(() {
              final results = sc.results;
              // if (sc.isLoading.value) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              if (results.isEmpty) {
                return Center(
                  child: Text(
                    'Digite algo para buscar',
                    style: AppTextStyles.productSub,
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.65,
                ),
                itemCount: results.length,
                itemBuilder: (ctx, i) => ProductCard(product: results[i]),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => AppBottomNav(
          currentIndex: hc.navIndex.value,
          onTap: (i) => hc.navIndex.value = i,
        ),
      ),
    );
  }

  void _openDelegate(BuildContext context) async {
    final selected = await showSearch(
      context: context,
      delegate: ProductSearchDelegate(),
    );
    if (selected is ProductModel) {
      // Se quiser navegar ao detalhe:
      // Get.toNamed(AppRoutes.productDetails, arguments: selected.id);
    }
  }
}
