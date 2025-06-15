// lib/presentation/delegates/product_search_delegate.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../presentation/widgets/product_card.dart';
import '../../models/product_model.dart';
import '../controllers/search_controller.dart';

class ProductSearchDelegate extends SearchDelegate<ProductModel?> {
  // Pega o controller único, que já carregou allProducts em onInit
  final SearchControllers c = Get.find<SearchControllers>();

  @override
  String? get searchFieldLabel => 'Buscar produtos';

  @override
  TextStyle? get searchFieldStyle => AppTextStyles.productName;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  // Quando o usuário confirma (pressiona "enter")
  @override
  Widget buildResults(BuildContext context) {
    final filtered = c.filterLocal(query);
    if (filtered.isEmpty) {
      return Center(
        child: Text(
          'Nenhum produto encontrado',
          style: AppTextStyles.productSub,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: filtered.length,
      itemBuilder: (_, i) => ProductCard(product: filtered[i]),
    );
  }

  // Enquanto digita, mostramos sugestões (igual ao resultados, mas pode ser lista menor)
  @override
  Widget buildSuggestions(BuildContext context) {
    final input = query.trim();
    if (input.isEmpty) {
      return Center(
        child: Text('Digite algo para buscar', style: AppTextStyles.productSub),
      );
    }

    final suggestions = c.filterLocal(input);
    if (suggestions.isEmpty) {
      return Center(
        child: Text(
          'Nenhum produto encontrado',
          style: AppTextStyles.productSub,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: suggestions.length,
      itemBuilder: (_, i) {
        final p = suggestions[i];
        return ListTile(
          leading: SizedBox(
            width: 48,
            child: Image.network(
              p.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => const Icon(Icons.image_not_supported),
            ),
          ),
          title: Text(p.name, style: AppTextStyles.productName),
          subtitle: Text(
            'R\$ ${p.price.toStringAsFixed(2)}',
            style: AppTextStyles.productPrice,
          ),
          onTap: () {
            // Fecha a busca e retorna o produto selecionado
            close(context, p);
          },
        );
      },
    );
  }
}
