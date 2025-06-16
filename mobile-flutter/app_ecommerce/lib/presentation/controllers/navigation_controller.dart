// lib/presentation/controllers/navigation_controller.dart
import 'package:get/get.dart';

class NavigationController extends GetxController {
  /// Rotas na mesma ordem do navbar
  final pages = <String>['/home', '/category', '/search', '/profile', '/cart'];

  /// Índice reativo
  final currentIndex = 0.obs;

  /// Chama ao tocar num item
  void setPage(int idx) {
    if (idx == currentIndex.value) return;
    currentIndex.value = idx;
    Get.toNamed(pages[idx]);
  }
}
