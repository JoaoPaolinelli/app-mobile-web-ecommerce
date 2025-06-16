// lib/presentation/widgets/phone_input_field.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneInputField extends StatelessWidget {
  final Rx<Country> selectedCountry;
  final MaskTextInputFormatter maskFormatter;
  final Function(String) onChanged;

  const PhoneInputField({
    super.key,
    required this.selectedCountry,
    required this.maskFormatter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ddi = selectedCountry.value.dialCode;
      return TextField(
        keyboardType: TextInputType.phone,
        inputFormatters: [maskFormatter],
        onChanged: (value) {
          final numeroCompleto = '+$ddi${maskFormatter.getUnmaskedText()}';
          onChanged(numeroCompleto);
        },
        decoration: InputDecoration(
          prefixText: '+$ddi ',
          labelText: 'Número de telefone',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: 0.03,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0828C9), width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF0828C9), width: 1),
          ),
        ),
      );
    });
  }
}
