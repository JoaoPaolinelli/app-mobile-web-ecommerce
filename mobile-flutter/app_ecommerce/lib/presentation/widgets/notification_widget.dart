// lib/presentation/widgets/notification_icon.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';
import '../controllers/notification_controller.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.find<NotificationController>();
    const double size = 24; // mesmo tamanho para ícone e Lottie

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.md),
      child: GestureDetector(
        onTap: () {
          nc.acknowledge();
          // navegue para notificações, se quiser
        },
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Sino estático
              Icon(
                Icons.notifications,
                size: size,
                color:
                    nc.isRinging.value
                        ? Colors.transparent
                        : AppColors.textPrimary,
              ),

              // Lottie por cima, especificando width/height
              if (nc.isRinging.value)
                Lottie.asset(
                  'assets/animation/notification.json',
                  controller: nc.anim!,
                  width: size, // força a largura
                  height: size, // força a altura
                  fit: BoxFit.contain,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
