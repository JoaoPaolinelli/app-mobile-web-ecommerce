// lib/presentation/controllers/navigation_controller.dart
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  /// Rotas na mesma ordem do navbar
  final pages = <String>[
    AppRoutes.home,
    AppRoutes.category,
    AppRoutes.search,
    AppRoutes.profile,
    AppRoutes.cart,
  ];

  /// Índice reativo
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Sincroniza índice quando a rota muda
    Get.routingCallback = (routing) {
      final r = routing?.current ?? '';
      final idx = pages.indexOf(r);
      if (idx != -1 && idx != currentIndex.value) {
        currentIndex.value = idx;
      }
    };
  }

  /// Navega para a página e atualiza índice
  void setPage(int idx) {
    if (idx == currentIndex.value) return;
    currentIndex.value = idx;
    Get.offNamedUntil(pages[idx], (route) => false);
  }
}
