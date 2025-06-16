// lib/presentation/controllers/payment_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController extends GetxController {
  var isBagExpanded = false.obs;
  var cpf = ''.obs;
  var endereco = ''.obs;
  var metodoPagamento = ''.obs;
  var produtos = [].obs;

  @override
  void onInit() {
    super.onInit();
    carregarDadosSalvos();
  }

  Future<void> carregarDadosSalvos() async {
    final prefs = await SharedPreferences.getInstance();

    cpf.value = prefs.getString('cpf') ?? '010.555.465-70';
    endereco.value =
        prefs.getString('endereco') ?? 'Rua Major Lopes, Belo Horizonte';
    metodoPagamento.value = prefs.getString('metodoPagamento') ?? 'PIX';

    final produtosJson = prefs.getString('produtos');
    if (produtosJson != null) {
      produtos.value = jsonDecode(produtosJson);
    } else {
      produtos.value = []; // vazio por padrão
    }
  }

  Future<void> salvarCpf(String novoCpf) async {
    cpf.value = novoCpf;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cpf', novoCpf);
  }

  Future<void> salvarEndereco(String novoEndereco) async {
    endereco.value = novoEndereco;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('endereco', novoEndereco);
  }

  Future<void> salvarMetodoPagamento(String novoMetodo) async {
    metodoPagamento.value = novoMetodo;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('metodoPagamento', novoMetodo);
  }

  Future<void> salvarProdutos(List<Map<String, dynamic>> novosProdutos) async {
    produtos.value = novosProdutos;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('produtos', jsonEncode(novosProdutos));
  }

  void toggleBag() => isBagExpanded.value = !isBagExpanded.value;

  Future<void> adicionarProduto(Map<String, dynamic> produto) async {
    final existente = produtos.firstWhereOrNull(
      (p) => p['nome'] == produto['nome'],
    );

    if (existente != null) {
      existente['quantidade'] += 1;
    } else {
      produtos.add({...produto, 'quantidade': 1});
    }

    await _salvarCarrinho();
  }

  Future<void> atualizarQuantidade(
    String nomeProduto,
    int novaQuantidade,
  ) async {
    final produto = produtos.firstWhereOrNull((p) => p['nome'] == nomeProduto);
    if (produto != null) {
      produto['quantidade'] = novaQuantidade;
      await _salvarCarrinho();
    }
  }

  Future<void> removerProduto(String nomeProduto) async {
    produtos.removeWhere((p) => p['nome'] == nomeProduto);
    await _salvarCarrinho();
  }

  Future<void> _salvarCarrinho() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('produtos', jsonEncode(produtos));
    produtos.refresh(); // Notifica widgets reativos
  }
}
