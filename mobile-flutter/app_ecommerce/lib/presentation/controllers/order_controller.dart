// lib/controllers/order_controller.dart
import 'package:app_ecommerce/data/api_service.dart';
import 'package:app_ecommerce/models/order.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final _service = ApiService();
  var orders = <Order>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      isLoading(true);
      error('');
      final list = await _service.fetchOrders();
      orders.assignAll(list);
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
