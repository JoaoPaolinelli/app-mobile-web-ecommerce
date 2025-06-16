// lib/presentation/controllers/notification_controller.dart
import 'package:get/get.dart';
import 'package:flutter/animation.dart';

class NotificationController extends GetxController
    with SingleGetTickerProviderMixin {
  late final AnimationController anim;
  var isRinging = false.obs;

  @override
  void onInit() {
    super.onInit();
    anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  /// Começa a tocar a animação em loop
  void ring() {
    // se já estiver tocando, não faz nada
    if (isRinging.value) return;

    isRinging.value = true;
    anim
      ..reset()
      ..repeat(reverse: true);
  }

  /// Deve ser chamado quando o usuário clicar no sino
  void acknowledge() {
    if (!isRinging.value) return;

    anim.stop();
    isRinging.value = false;
  }

  @override
  void onClose() {
    anim.dispose();
    super.onClose();
  }
}
