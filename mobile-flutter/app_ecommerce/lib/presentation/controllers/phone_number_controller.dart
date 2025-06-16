import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  final phone = ''.obs;

  void onPhoneChanged(String value) {
    phone.value = value;
  }

  void continuePressed() {
    if (phone.value.isEmpty || phone.value.length < 10) {
      Get.snackbar('Erro', 'Digite um número válido');
      return;
    }

    // Lógica de navegação ou envio
    print('Número enviado: ${phone.value}');
    // Get.toNamed(AppRoutes.verification); // exemplo
  }
}
