import 'package:app_ecommerce/data/api_service.dart';
import 'package:get/get.dart';
import '../../models/product_model.dart';

class SearchControllers extends GetxController {
  final ApiService _api = ApiService();

  /// Todos os produtos carregados da API
  final allProducts = <ProductModel>[].obs;

  /// Resultados filtrados dinamicamente
  final results = <ProductModel>[].obs;

  /// Controle de carregamento
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() {
    super.onInit();
    carregarProdutos(); // Carrega ao abrir
  }

  /// Carrega os produtos da API e armazena
  Future<void> carregarProdutos() async {
    isLoading = true;
    try {
      final produtos = await _api.fetchAllProducts();
      allProducts.assignAll(produtos);
      results.assignAll(produtos); // exibe tudo inicialmente (ou deixe vazio)
    } catch (e) {
      // Pode logar erro ou mostrar snackbar
      print('Erro ao carregar produtos: $e');
    } finally {
      isLoading = false;
    }
  }

  /// Filtra localmente os produtos
  // void search(String query) {
  //   if (query.isEmpty) {
  //     results.clear(); // ou use allProducts para mostrar tudo
  //     return;
  //   }

  //   results.value =
  //       allProducts
  //           .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  // }

  final searchActive = false.obs;

  void search(String query) {
    searchActive.value = query.isNotEmpty;

    if (query.isEmpty) {
      results.clear();
      return;
    }

    results.value =
        allProducts
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }
}
