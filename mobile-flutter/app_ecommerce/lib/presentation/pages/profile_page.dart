import 'package:app_ecommerce/presentation/controllers/home_controller.dart';
import 'package:app_ecommerce/presentation/widgets/order_page/profile_item_animation.dart';
import 'package:app_ecommerce/presentation/widgets/profile_page/profile_item_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/profile_page/profile_section_title.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppBottomNav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 24),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Pensou em compras,\nPediu E-Buy",
                      style: AppTextStyles.headingProfile,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 160,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Botão
              SizedBox(
                width: 342,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purchaseButton,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Entrar ou fazer cadastro",
                    style: AppTextStyles.buttonProfile,
                  ),
                ),
              ),

              // Seções
              const ProfileSectionTitle(title: "PEDIDOS"),

              // Agora o Histórico com animação + mesma aparência:
              GestureDetector(
                onTap: () => Get.toNamed('/profile/orders'),
                child: const ProfileItemTile(
                  icon: Icons.history,
                  label: "Histórico de compras",
                ),
              ),
              // const ProfileItemTile(
              //   icon: Icons.history,
              //   label: "Histórico de compras",
              // ),

              // AnimatedProfileItemTile(
              //   icon: Icons.history,
              //   label: "Histórico de compras",
              //   routeName: '/profile/orders', // ajuste pra sua rota
              // ),
              const ProfileItemTile(
                icon: Icons.mic,
                label: "Registre um problema",
              ),
              const ProfileItemTile(
                icon: Icons.local_shipping,
                label: "Rastreamento de pedidos",
              ),

              const ProfileSectionTitle(title: "CONFIGURAÇÕES"),
              const ProfileItemTile(
                icon: Icons.place,
                label: "Informações de entrega",
              ),
              const ProfileItemTile(
                icon: Icons.credit_card,
                label: "Informações de pagamento",
              ),

              const ProfileSectionTitle(title: "Informações"),
              const ProfileItemTile(
                icon: Icons.description,
                label: "Termos de uso",
              ),
              const ProfileItemTile(
                icon: Icons.shield,
                label: "Políticas de privacidade",
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
