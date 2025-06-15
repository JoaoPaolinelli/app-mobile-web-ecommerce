// lib/presentation/controllers/search_controller.dart
import 'package:app_ecommerce/data/api_service.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';

class SearchControllers extends GetxController {
  final ApiService _api = ApiService();

  /// Todos os produtos carregados do servidor
  final allProducts = <ProductModel>[].obs;

  /// Resultados filtrados em memória (obs apenas se precisar reagir a mudanças)
  final results = <ProductModel>[].obs;

  get isLoading => null;

  @override
  void onInit() {
    super.onInit();
    // Carrega tudo apenas uma vez
    _api.fetchAllProducts().then(allProducts.assignAll);
  }

  /// Preenche `results` usando filtro local
  void setQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      results.clear();
    } else {
      results.assignAll(filterLocal(q));
    }
  }

  /// Retorna todos os produtos cujo nome contenha a query
  List<ProductModel> filterLocal(String query) {
    final lower = query.toLowerCase();
    return allProducts
        .where((p) => p.name.toLowerCase().contains(lower))
        .toList();
  }
}
