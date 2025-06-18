// lib/presentation/controllers/confirmacao_pedido_controller.dart
import 'dart:convert';
import 'package:app_ecommerce/data/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/loading_page.dart';
import '../pages/pedido_confirmado_page.dart';
import 'cart_controller.dart';
import 'user_controller.dart';

class ConfirmacaoPedidoController extends GetxController {
  final complementoController = TextEditingController();
  final instrucoesController = TextEditingController();
  final isLoading = false.obs;
  // final api = ApiService();
  final api = Get.put<ApiService>;

  late final CartController _cartCtrl;
  late final UserController _userCtrl;

  @override
  void onInit() {
    super.onInit();
    _cartCtrl = Get.find<CartController>();
    _userCtrl = Get.find<UserController>();
    _carregarCamposSalvos();
  }

  Future<void> _carregarCamposSalvos() async {
    final prefs = await SharedPreferences.getInstance();
    complementoController.text = prefs.getString('complemento') ?? '';
    instrucoesController.text = prefs.getString('instrucoes') ?? '';
  }

  Future<void> confirmarPedido() async {
    // 1) valida com base em cartItems
    if (_cartCtrl.cartItems.isEmpty) {
      Get.snackbar('Erro', 'Carrinho vazio');
      return;
    }

    isLoading.value = true;
    Get.to(() => const LoadingPage());

    try {
      // 2) atualiza UserController
      _userCtrl.updateComplement(complementoController.text.trim());
      _userCtrl.updateInstructions(instrucoesController.text.trim());
      await _userCtrl.saveUser();

      // 3) monta o payload a partir de cartItems
      // final items =
      //     _cartCtrl.cartItems.map((item) {
      //       return {
      //         // como CartItem não tem id, usamos o title como identificador
      //         'productId': item.title,
      //         'quantity': item.quantity,
      //         'unitPrice': item.price,
      //       };
      //     }).toList();

      final items =
          _cartCtrl.cartItems.map((item) {
            return {
              'productId': item.title, // ou `item.id`
              'productName': item.title, // <<-- adicione este campo
              'unitPrice': item.price.toInt(),
              'quantity': item.quantity,
            };
          }).toList();

      final body = {'items': items, 'user': _userCtrl.user.value!.toJson()};

      // 4) chama sua API
      final response = await http.post(
        Uri.parse('http://10.0.3.2:3000/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _limparCarrinhoLocal();
        Get.off(() => const PedidoConfirmadoPage());
      } else {
        Get.back();
        Get.snackbar(
          'Erro',
          'Falha ao confirmar pedido: ${response.body}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Erro',
        'Erro de conexão: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _limparCarrinhoLocal() async {
    final prefs = await SharedPreferences.getInstance();
    // usa a string literal que o CartController usa
    await prefs.remove('cart_items');
    _cartCtrl.clearCart();
  }

  @override
  void onClose() {
    complementoController.dispose();
    instrucoesController.dispose();
    super.onClose();
  }
}
