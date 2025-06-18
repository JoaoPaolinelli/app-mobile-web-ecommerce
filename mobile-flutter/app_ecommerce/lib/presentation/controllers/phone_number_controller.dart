// lib/presentation/controllers/phone_number_controller.dart
import 'package:get/get.dart';
import '../controllers/user_controller.dart'; // caminho relativo

class PhoneNumberController extends GetxController {
  final phone = ''.obs;
  final _userCtrl = Get.find<UserController>();

  void onPhoneChanged(String value) {
    phone.value = value;
  }

  void continuePressed() {
    if (phone.value.isEmpty || phone.value.length < 10) {
      Get.snackbar('Erro', 'Digite um número válido');
      return;
    }

    // 1) Atualiza o UserController
    _userCtrl.updatePhone(phone.value);

    // 2) Navega para a próxima tela
    // Get.toNamed(AppRoutes.identification);
  }
}
