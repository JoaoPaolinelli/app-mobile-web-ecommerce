// lib/presentation/controllers/category_controller.dart
import 'package:app_ecommerce/data/api_service.dart';
import 'package:get/get.dart';
import '../../models/highlight_model.dart';
import '../../models/category_count_model.dart';
import '../../core/constants/app_colors.dart';

class CategoryController extends GetxController {
  final ApiService _api = ApiService();

  // Destaques fixos já em HighlightModel
  final fixedHighlights =
      <HighlightModel>[
        HighlightModel(
          category: 'Arraia E-Buy',
          imageAsset: 'assets/images/Arraia.png',
          stripeColor: AppColors.success,
        ),
        HighlightModel(
          category: 'Promoções',
          imageAsset: 'assets/images/promocao.png',
          stripeColor: AppColors.error,
        ),
      ].obs;

  // Destaque dinâmico em HighlightModel
  var dynamicHighlight = Rxn<HighlightModel>();

  // Todas as categorias com contagem
  var categories = <CategoryCountModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      isLoading.value = true;
      final list = await _api.fetchCombinedCategoryCounts();

      categories.assignAll(list);

      if (list.isNotEmpty) {
        final first = list.first;
        dynamicHighlight.value = HighlightModel(
          category: first.category,
          // monte o nome do asset conforme seu padrão:
          imageAsset: 'assets/images/vestido.jpeg',
          stripeColor: AppColors.success, // ou outra cor dinâmica
        );
      }
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
