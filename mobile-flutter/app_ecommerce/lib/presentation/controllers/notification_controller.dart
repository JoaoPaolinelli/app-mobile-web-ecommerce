// lib/presentation/controllers/notification_controller.dart
import 'package:app_ecommerce/models/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/notification_panel.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationItem>[].obs;
  var isRinging = false.obs;

  void ring() => isRinging.value = true;
  void acknowledge() => isRinging.value = false;

  // lib/presentation/controllers/notification_controller.dart

  void openNotifications() {
    ring(); // opcional: dispara ring antes de abrir
    showGeneralDialog(
      context: Get.overlayContext!,
      barrierDismissible: true,
      barrierLabel: 'Notificações',
      barrierColor: Colors.black26, // leve escurecimento atrás do blur
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const NotificationPanel(),
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
