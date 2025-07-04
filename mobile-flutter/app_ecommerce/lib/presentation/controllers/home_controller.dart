// lib/presentation/controllers/home_controller.dart
import 'package:app_ecommerce/data/api_service.dart';
import 'package:get/get.dart';
import '../../models/banner_model.dart';
import '../../models/product_model.dart';

class HomeController extends GetxController {
  final ApiService _api = ApiService();

  // Banner estático
  late final BannerModel banner;

  // Produtos
  var mostOrdered = <ProductModel>[].obs;
  var favorites = <ProductModel>[].obs;
  var allProducts = <ProductModel>[].obs;
  var discounted = <ProductModel>[].obs;
  // Loader
  var isLoading = true.obs;

  // ← Adicione este campo:
  var navIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Carrega banner de assets (sincrono)
    banner = _api.fetchBannerSync();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final most = await _api.fetchMostOrdered(limit: 10);
      mostOrdered.assignAll(most);

      final fav = await _api.fetchFavorites(limit: 10);
      favorites.assignAll(fav);

      final allProducts = await _api.fetchAllProducts();
      favorites.assignAll(allProducts);

      // ← Carrega produtos com desconto (por exemplo, limit 10)
      final disc = await _api.fetchDiscounted();
      discounted.assignAll(disc);
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
