// lib/presentation/widgets/notification_icon.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_sizes.dart';
import '../controllers/notification_controller.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.find<NotificationController>();
    const double size = AppSizes.iconSize;

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.md),
      child: GestureDetector(
        onTap: nc.openNotifications,
        child: Obx(() {
          return Lottie.asset(
            'assets/animation/notification.json',
            width: size,
            height: size,
            fit: BoxFit.contain,
            animate: nc.isRinging.value,
            repeat: nc.isRinging.value,
          );
        }),
      ),
    );
  }
}
