import 'package:app_ecommerce/data/api_service.dart';
import 'package:app_ecommerce/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryProductsController extends GetxController {
  final ApiService _api = ApiService();
  final String category = Get.parameters['category'] ?? '';

  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProductsByCategory();
  }

  Future<void> loadProductsByCategory() async {
    try {
      isLoading.value = true;
      final List<ProductModel> list = await _api.fetchByCategory(category);
      products.assignAll(list);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível carregar "$category": $e');
    } finally {
      isLoading.value = false;
    }
  }
}
