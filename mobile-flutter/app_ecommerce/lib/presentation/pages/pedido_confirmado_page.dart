import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class PedidoConfirmadoPage extends StatefulWidget {
  const PedidoConfirmadoPage({super.key});

  @override
  State<PedidoConfirmadoPage> createState() => _PedidoConfirmadoPageState();
}

class _PedidoConfirmadoPageState extends State<PedidoConfirmadoPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animation/check.json',
              width: 150,
              height: 150,
              repeat: false,
            ),
            const SizedBox(height: 20),
            Text(
              'Pedido confirmado!',
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
