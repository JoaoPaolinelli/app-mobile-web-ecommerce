// lib/presentation/widgets/generic_listing_page.dart

import 'package:app_ecommerce/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/app_nav_bar.dart';

/// Página genérica de listagem de itens T
class GenericListingPage<T> extends StatelessWidget {
  /// Título da AppBar e header
  final String title;

  /// A lista de itens a mostrar
  final List<T> items;

  /// Como renderizar cada item
  final Widget Function(T item) itemBuilder;

  const GenericListingPage({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // Supondo que você sempre tenha o HomeController para a bottom nav:
    final hc = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title, style: AppTextStyles.sectionTitle),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body:
          items.isEmpty
              ? Center(
                child: Text(
                  'Nada em "$title"',
                  style: AppTextStyles.sectionTitle,
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSizes.md,
                    mainAxisSpacing: AppSizes.md,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (_, i) => itemBuilder(items[i]),
                ),
              ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}
