import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../presentation/widgets/app_nav_bar.dart';
import '../widgets/home_page/product_card.dart';
import '../widgets/home_page/section_header.dart';
import '../controllers/search_controller.dart';
import '../controllers/home_controller.dart';

class SearchPage extends StatelessWidget {
  final SearchControllers sc = Get.put(SearchControllers());
  final HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (sc.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final all = sc.allProducts;

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const SizedBox(height: AppSizes.padding),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: TextField(
                  onChanged: sc.search,
                  decoration: InputDecoration(
                    hintText: 'Buscar produtos',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius,
                      ),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Seções horizontais
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: SectionHeader(
                  title: 'Dia dos namorados no E-Buy',
                  onTap: () {},
                ),
              ),
              _buildHorizontalList(all),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: SectionHeader(
                  title: 'Produtos com Desconto',
                  onTap: () {},
                ),
              ),
              _buildHorizontalList(all.where((p) => p.hasDiscount).toList()),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: SectionHeader(title: 'Saúde e Fit', onTap: () {}),
              ),
              _buildHorizontalList(all),
            ],
          );
        }),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }

  /// 🔄 Lista horizontal com ProductCard
  Widget _buildHorizontalList(List products) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (ctx, i) => ProductCard(product: products[i]),
      ),
    );
  }
}
