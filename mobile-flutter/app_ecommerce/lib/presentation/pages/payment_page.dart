// lib/presentation/pages/pagamento_page.dart
import 'package:app_ecommerce/core/constants/app_colors.dart';
import 'package:app_ecommerce/presentation/controllers/payment_controller.dart';
import 'package:app_ecommerce/presentation/controllers/user_controller.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/bag_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/delivery_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/full_price_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/payment_widget.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagamentoPage extends StatelessWidget {
  PagamentoPage({super.key});

  // Injetamos ambos os controllers
  final paymentCtrl = Get.put(PaymentController());
  final userCtrl = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                const SizedBox(width: 48),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const SacolaWidget(),
            const SizedBox(height: 24),
            const EntregaWidget(), // aqui o paymentCtrl.endereco e cpf
            const SizedBox(height: 24),
            const PagamentoWidget(), // aqui o paymentCtrl.metodoPagamento
            const SizedBox(height: 24),
            const TotalPagarWidget(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: PrimaryButton(
                text: 'Continuar',
                onPressed: () async {
                  // validação mínima
                  if (paymentCtrl.cpf.value.isEmpty) {
                    Get.snackbar('Erro', 'Informe seu CPF');
                    return;
                  }
                  if (paymentCtrl.endereco.value.isEmpty) {
                    Get.snackbar('Erro', 'Informe o endereço de entrega');
                    return;
                  }

                  // 1️⃣ Atualiza o UserController
                  userCtrl.updateIdentification(paymentCtrl.cpf.value);
                  userCtrl.updateAddress(paymentCtrl.endereco.value);
                  userCtrl.updatePaymentMethod(
                    paymentCtrl.metodoPagamento.value,
                  );

                  // 2️⃣ Persiste no SharedPreferences
                  await userCtrl.saveUser();

                  // 3️⃣ Avança para a confirmação de pagamento
                  Get.toNamed(AppRoutes.confirmPayment);
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
