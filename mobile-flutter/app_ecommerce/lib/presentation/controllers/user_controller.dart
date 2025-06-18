import 'dart:convert';
import 'package:app_ecommerce/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  static const _key = 'USER_INFO';

  /// O objeto que armazena todas as informações do usuário.
  final user = Rxn<UserInfo>();

  @override
  void onInit() {
    super.onInit();
    _loadFromPrefs();
  }

  /// Carrega do shared_preferences, se existir.
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      user.value = UserInfo.fromJson(json.decode(raw));
    }
  }

  /// Persiste todas as informações atuais do usuário.
  Future<void> saveUser() async {
    if (user.value == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(user.value!.toJson()));
  }

  /// Verifica se já existe dados de usuário carregados.
  bool get hasUser => user.value != null;

  /// Limpa os dados do usuário tanto em memória quanto em armazenamento.
  Future<void> clear() async {
    user.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// Atualiza somente o telefone.
  void updatePhone(String phoneNumber) {
    final current =
        user.value ??
        UserInfo(
          phoneNumber: '',
          identification: '',
          deliveryAddress: '',
          paymentMethod: 'OTHER',
        );
    current.phoneNumber = phoneNumber;
    user.value = current;
  }

  /// Atualiza somente a identificação (CPF, RG etc.).
  void updateIdentification(String id) {
    final current =
        user.value ??
        UserInfo(
          phoneNumber: '',
          identification: '',
          deliveryAddress: '',
          paymentMethod: 'OTHER',
        );
    current.identification = id;
    user.value = current;
  }

  /// Atualiza somente o endereço de entrega.
  void updateAddress(String address) {
    if (user.value != null) {
      user.value!.deliveryAddress = address;
    }
  }

  /// Atualiza complemento de endereço.
  void updateComplement(String complement) {
    if (user.value != null) {
      user.value!.addressComplement = complement;
    }
  }

  /// Atualiza instruções de entrega.
  void updateInstructions(String instructions) {
    if (user.value != null) {
      user.value!.deliveryInstructions = instructions;
    }
  }

  /// Atualiza o método de pagamento selecionado.
  void updatePaymentMethod(String method) {
    if (user.value != null) {
      user.value!.paymentMethod = method;
    }
  }
}
