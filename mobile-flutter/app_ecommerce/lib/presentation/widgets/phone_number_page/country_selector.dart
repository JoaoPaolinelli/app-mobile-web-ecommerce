// lib/presentation/widgets/country_selector.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

class CountrySelector extends StatelessWidget {
  final Rx<Country> selectedCountry;

  const CountrySelector({super.key, required this.selectedCountry});

  void showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => ListView(
            children:
                countries.map((country) {
                  return ListTile(
                    leading: Text(country.flag),
                    title: Text(country.name),
                    trailing: Text('+${country.dialCode}'),
                    onTap: () {
                      selectedCountry.value = country;
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCountryPicker(context),
      child: Obx(() {
        final country = selectedCountry.value;
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 140),
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(country.flag, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 6),
                Text(
                  '+${country.dialCode}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, size: 18),
              ],
            ),
          ),
        );
      }),
    );
  }
}
