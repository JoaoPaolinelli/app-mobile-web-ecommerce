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
  const PagamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: Colors.white, // mantenha o fundo uniforme com o app
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              const PaymentTitleWidget(),
              const SizedBox(height: 20),
              const SacolaWidget(),
              const SizedBox(height: 24),
              const EntregaWidget(),
              const SizedBox(height: 24),
              const PagamentoWidget(),
              const SizedBox(height: 24),
              const TotalPagarWidget(),
              const SizedBox(height: 32),

              // Botão centralizado e com espaçamento
              SizedBox(
                width: double.infinity,
                height: 58,
                child: PrimaryButton(
                  text: 'Continuar',
                  onPressed: () => Get.toNamed(AppRoutes.confirmPayment),
                  // {

                  //   // Ação ao continuar
                  // },
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
