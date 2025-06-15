// lib/presentation/pages/category_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/highlight_model.dart';
import '../../presentation/widgets/highlight_card.dart';
import '../../presentation/widgets/category_card.dart';
import '../../presentation/widgets/app_nav_bar.dart';
import '../controllers/category_controller.dart';
import '../controllers/home_controller.dart';

class CategoryPage extends StatelessWidget {
  final CategoryController c = Get.put(CategoryController());
  final HomeController h = Get.find();

  @override
  Widget build(BuildContext context) {
    // Calcula largura de cada coluna do grid (e dos destaques)
    final totalWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = AppSizes.padding * 2; // left+right
    const gap = 16.0; // crossAxisSpacing
    final itemWidth = (totalWidth - horizontalPadding - gap * 2) / 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Categorias', style: AppTextStyles.sectionTitle),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final highlights = <HighlightModel>[
          c.fixedHighlights[0],
          if (c.dynamicHighlight.value != null) c.dynamicHighlight.value!,
          c.fixedHighlights[1],
        ];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.padding),

              // === Destaques ===
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: Text('Destaques', style: AppTextStyles.sectionTitle),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height:
                    itemWidth +
                    AppSizes.cardSpacing *
                        2, // altura igual ao grid item (aprox)
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: highlights.length,
                  separatorBuilder: (_, __) => const SizedBox(width: gap),
                  itemBuilder: (ctx, i) {
                    final item = highlights[i];
                    return SizedBox(
                      width: itemWidth,
                      child: HighlightCard(
                        title: item.category,
                        imageAsset: item.imageAsset,
                        stripeColor: item.stripeColor,
                        onTap:
                            () => Get.toNamed(
                              '/products?category=${item.category}',
                            ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // === Todas as Categorias ===
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                child: Text('Categorias', style: AppTextStyles.sectionTitle),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: c.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: gap,
                  mainAxisSpacing: gap,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (ctx, i) {
                  final cat = c.categories[i];
                  return CategoryCard(
                    // category: cat,
                    title: cat.category,
                    // count: cat.count,
                    onTap:
                        () => Get.toNamed('/products?category=${cat.category}'),
                    imageAsset: 'assets/images/Camiseta_default.jpg',
                  );
                },
              ),

              const SizedBox(height: AppSizes.padding),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () => AppBottomNav(
          currentIndex: h.navIndex.value,
          onTap: (i) => h.navIndex.value = i,
        ),
      ),
    );
  }
}
