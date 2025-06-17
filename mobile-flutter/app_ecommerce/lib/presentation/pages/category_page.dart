// lib/presentation/pages/category_page.dart
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  // Mapeamento de categoria → ícone
  final Map<String, IconData> _iconMap = {
    'Fantastic': FontAwesomeIcons.star,
    'Refined': FontAwesomeIcons.gem,
    'Practical': FontAwesomeIcons.toolbox,
    'Small': FontAwesomeIcons.leaf,
    'Sleek': FontAwesomeIcons.bolt,
    'Generic': FontAwesomeIcons.cube,
    'Handmade': FontAwesomeIcons.handSparkles,
    'Gorgeous': FontAwesomeIcons.heart,
    'Licensed': FontAwesomeIcons.certificate,
    'Rustic': FontAwesomeIcons.tree,
    'Unbranded': FontAwesomeIcons.question,
    'Ergonomic': FontAwesomeIcons.user,
    'Intelligent': FontAwesomeIcons.brain,
    'Incredible': FontAwesomeIcons.rocket,
    'Awesome': FontAwesomeIcons.thumbsUp,
    'Tasty': FontAwesomeIcons.utensils,
    'Handcrafted': FontAwesomeIcons.tools,
    'Roupas': FontAwesomeIcons.tshirt,
    'Elegant': FontAwesomeIcons.crown,
    'Oriental': FontAwesomeIcons.pagelines,
    'Electronic': FontAwesomeIcons.tv,
    'Bespoke': FontAwesomeIcons.paintBrush,
    'Recycled': FontAwesomeIcons.recycle,
    'Luxurious': FontAwesomeIcons.diamond,
    'Modern': FontAwesomeIcons.mobileAlt,
    'Fresh': FontAwesomeIcons.appleAlt,
  };

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final gap = AppSizes.md;
    final horizontalPadding = AppSizes.md * 2;
    final itemWidth = (totalWidth - horizontalPadding - gap * 2) / 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Categorias', style: AppTextStyles.sectionTitle),
        centerTitle: true,
        backgroundColor: AppColors.background,
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
              const SizedBox(height: AppSizes.md),

              // === Destaques ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: Text('Destaques', style: AppTextStyles.sectionTitle),
              ),
              const SizedBox(height: AppSizes.sm),
              SizedBox(
                height: itemWidth + AppSizes.lg * 2,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                  scrollDirection: Axis.horizontal,
                  itemCount: highlights.length,
                  separatorBuilder: (_, __) => SizedBox(width: gap),
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
                              '${AppRoutes.categoryProduct}?category=${Uri.encodeComponent(item.category)}',
                            ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSizes.lg),

              // === Todas as Categorias ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: Text('Categorias', style: AppTextStyles.sectionTitle),
              ),
              const SizedBox(height: AppSizes.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: gap,
                    mainAxisSpacing: gap,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (ctx, i) {
                    final cat = c.categories[i];
                    final icon =
                        _iconMap[cat.category] ?? FontAwesomeIcons.tags;
                    return CategoryCard(
                      title: cat.category,
                      icon: icon,
                      onTap:
                          () => Get.toNamed(
                            '/category_products?category=${Uri.encodeComponent(cat.category)}',
                          ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSizes.md),
            ],
          ),
        );
      }),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
