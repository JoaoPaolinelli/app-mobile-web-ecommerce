// lib/presentation/pages/pagamento_page.dart
import 'package:app_ecommerce/presentation/widgets/payment_page/bag_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/delivery_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/full_price_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/payment_title_widget.dart';
import 'package:app_ecommerce/presentation/widgets/payment_page/payment_widget.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:flutter/material.dart';

class PagamentoPage extends StatelessWidget {
  const PagamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PaymentTitleWidget(),
              const SizedBox(height: 20),
              const SacolaWidget(),
              const SizedBox(height: 20),
              const EntregaWidget(),
              const SizedBox(height: 20),
              const PagamentoWidget(),
              const SizedBox(height: 20),
              const TotalPagarWidget(valor: 'RS 78,99'),
              const Spacer(),
              PrimaryButton(
                text: 'Continuar',
                onPressed: () {
                  // Ação ao continuar
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
