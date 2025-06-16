// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../pages/loading_page.dart';
// import '../pages/pedido_confirmado_page.dart';

// class ConfirmacaoController extends GetxController {
//   final complementoController = TextEditingController();
//   final instrucoesController = TextEditingController();
//   final isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _carregarCamposSalvos();
//   }

//   void _carregarCamposSalvos() async {
//     final prefs = await SharedPreferences.getInstance();
//     complementoController.text = prefs.getString('complemento') ?? '208';
//     instrucoesController.text = prefs.getString('instrucoes') ?? '';
//   }

//   Future<void> confirmarPedido({required List<dynamic> produtos}) async {
//     isLoading.value = true;
//     Get.to(() => const LoadingPage());

//     final pedidoFormatado =
//         produtos.map((produto) {
//           return {
//             "productId": produto["id"].toString(),
//             "quantity": produto["quantidade"] ?? 1,
//             "customerName":
//                 "João", // ou recupere do SharedPreferences, se preferir
//           };
//         }).toList();

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:3000/orders'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(pedidoFormatado),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         await _limparCarrinhoLocal();
//         Get.off(() => const PedidoConfirmadoPage());
//       } else {
//         Get.back();
//         Get.snackbar(
//           'Erro',
//           'Falha ao confirmar pedido: ${response.body}',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.back();
//       Get.snackbar(
//         'Erro',
//         'Erro de conexão ao enviar pedido.',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> _limparCarrinhoLocal() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('produtos');
//   }

//   @override
//   void onClose() {
//     complementoController.dispose();
//     instrucoesController.dispose();
//     super.onClose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/loading_page.dart';
import '../pages/pedido_confirmado_page.dart';

class ConfirmacaoController extends GetxController {
  final complementoController = TextEditingController();
  final instrucoesController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _carregarCamposSalvos();
  }

  void _carregarCamposSalvos() async {
    final prefs = await SharedPreferences.getInstance();
    complementoController.text = prefs.getString('complemento') ?? '208';
    instrucoesController.text = prefs.getString('instrucoes') ?? '';
  }

  Future<void> confirmarPedidoSimulado() async {
    isLoading.value = true;
    Get.to(() => const LoadingPage());

    await Future.delayed(const Duration(seconds: 2)); // simula envio

    await _limparCarrinhoLocal();
    Get.off(() => const PedidoConfirmadoPage());
    isLoading.value = false;
  }

  Future<void> _limparCarrinhoLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('produtos');
  }

  @override
  void onClose() {
    complementoController.dispose();
    instrucoesController.dispose();
    super.onClose();
  }
}
