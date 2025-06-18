import 'package:app_ecommerce/core/constants/app_text_styles.dart';
import 'package:app_ecommerce/models/product_model.dart';
import 'package:app_ecommerce/presentation/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
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

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              const SizedBox(height: AppSizes.padding),

              // 🔍 Campo de busca
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

              // 🔁 Condicional: mostrando resultados filtrados ou seções padrão
              if (sc.searchActive.value)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resultados da busca:',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 16),

                      // GridView dentro de SizedBox para scroll vertical
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sc.results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.65,
                            ),
                        itemBuilder:
                            (ctx, i) => ProductCard(product: sc.results[i]),
                      ),
                    ],
                  ),
                )
              else ...[
                // 🩷 Sessão: Dia dos Namorados
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SectionHeader(
                    title: 'Produtos Importados',
                    onTap: () {
                      Get.to(
                        () => GenericListingPage<ProductModel>(
                          title: 'Produtos Importados',
                          items: hc.mostOrdered,
                          itemBuilder: (p) => ProductCard(product: p),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                _buildHorizontalList(sc.allProducts),

                const SizedBox(height: 24),

                // 💸 Sessão: Produtos com Desconto
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                  ),
                  child: SectionHeader(
                    title: 'Produtos com Desconto',
                    onTap: () {
                      Get.to(
                        () => GenericListingPage<ProductModel>(
                          title: 'Produtos com Desconto',
                          items: hc.discounted,
                          itemBuilder: (p) => ProductCard(product: p),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                _buildHorizontalList(
                  sc.allProducts.where((p) => p.hasDiscount).toList(),
                ),

                const SizedBox(height: 24),

                // 🏋️ Sessão: Saúde e Fit
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                  ),
                  child: SectionHeader(
                    title: 'Saúde e Fit',
                    onTap: () {
                      Get.to(
                        () => GenericListingPage<ProductModel>(
                          title: 'Saúde e Fit',
                          items: hc.mostOrdered,
                          itemBuilder: (p) => ProductCard(product: p),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                _buildHorizontalList(sc.allProducts),
              ],
            ],
          );
        }),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }

  /// 🔄 Lista horizontal com ProductCard
  Widget _buildHorizontalList(List<ProductModel> products) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (ctx, i) => ProductCard(product: products[i]),
      ),
    );
  }
}
