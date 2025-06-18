// lib/pages/history_page.dart
import 'package:app_ecommerce/presentation/controllers/order_controller.dart';
import 'package:app_ecommerce/presentation/widgets/app_nav_bar.dart';
import 'package:app_ecommerce/presentation/widgets/order_page/order_card.dart';
import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Garantir que o controller seja criado aqui e onInit() seja executado
    final ctrl = Get.put(OrderController());

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNav(),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Histórico de Compras',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (ctrl.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (ctrl.error.isNotEmpty) {
              return Center(child: Text('Erro: ${ctrl.error.value}'));
            }
            final orders = ctrl.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('Nenhum pedido encontrado.'));
            }
            return ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final order = orders[i];
                return OrderCard(
                  order: order,
                  onTap: () {
                    // Exemplo: navegar para detalhes
                    // Get.toNamed('/orders/${order.id}');
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
