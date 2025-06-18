// lib/presentation/controllers/order_controller.dart
import 'package:app_ecommerce/data/api_service.dart';
import 'package:get/get.dart';

import '../../models/order.dart';

class OrderController extends GetxController {
  final orders = <Order>[].obs;
  final isLoading = true.obs;
  final error = ''.obs;
  final ApiService _api = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      error.value = '';
      final resList = await _api.fetchOrders();
      // fetchOrdersByUser já retorna List<Order>
      orders.assignAll(resList);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
