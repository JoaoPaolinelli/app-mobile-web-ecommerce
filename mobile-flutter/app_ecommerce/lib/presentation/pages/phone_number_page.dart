// lib/presentation/pages/phone_number_page.dart
import 'package:app_ecommerce/presentation/controllers/phone_number_controller.dart';
import 'package:app_ecommerce/presentation/controllers/user_controller.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/country_selector.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/phone_input_field.dart';
import 'package:app_ecommerce/presentation/widgets/phone_number_page/primary_button.dart';
import 'package:app_ecommerce/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberPage extends StatelessWidget {
  PhoneNumberPage({super.key});

  final phoneCtrl = Get.put(PhoneNumberController());
  final userCtrl = Get.find<UserController>();

  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final Rx<Country> selectedCountry =
      Country(
        name: 'Brazil',
        code: 'BR',
        dialCode: '55',
        flag: '🇧🇷',
        nameTranslations: {},
        minLength: 1,
        maxLength: 5,
      ).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 28,
            right: 28,
            top: 52,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  iconSize: 24,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 271,
                height: 271,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 52),
              CountrySelector(selectedCountry: selectedCountry),
              const SizedBox(height: 16),
              PhoneInputField(
                selectedCountry: selectedCountry,
                maskFormatter: maskFormatter,
                onChanged: phoneCtrl.onPhoneChanged,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 271,
                height: 52,
                child: PrimaryButton(
                  text: 'Continuar',
                  onPressed: () {
                    final numero = phoneCtrl.phone.value;
                    if (numero.isEmpty || numero.length < 10) {
                      Get.snackbar('Erro', 'Digite um número válido');
                      return;
                    }
                    // Atualiza o UserController
                    userCtrl.updatePhone(numero);
                    // Navega para a próxima tela
                    Get.toNamed(AppRoutes.payment);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
