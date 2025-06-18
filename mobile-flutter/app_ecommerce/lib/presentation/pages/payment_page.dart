import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/bag_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/delivery_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/full_price_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/payment_title_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/payment_widget.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PagamentoPage extends StatelessWidget {
  PagamentoPage({super.key});
  final controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // AppBar fiel ao PaymentTitleWidget
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                const Expanded(
                  child: Text(
                    'Pagamento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      color: Color(0xFF060606),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // espaço para equilibrar visualmente
              ],
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // const SacolaWidget(),
            // const PaymentTitleWidget(),
            const SizedBox(height: 20),
            const SacolaWidget(),
            const SizedBox(height: 24),
            const EntregaWidget(),
            const SizedBox(height: 24),
            const PagamentoWidget(),
            const SizedBox(height: 24),
            const TotalPagarWidget(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: PrimaryButton(
                text: 'Continuar',
                onPressed: () => Get.toNamed(AppRoutes.confirmPayment),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
