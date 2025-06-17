// lib/presentation/widgets/notification_panel.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';
import '../../models/notification_item.dart';

class NotificationPanel extends StatelessWidget {
  const NotificationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final nc = Get.find<NotificationController>();
    final list =
        nc.notifications.isEmpty
            ? <NotificationItem>[
              NotificationItem(
                id: 'ex1',
                title: 'Bem-vindo ao E-Buy!',
                route: '/home',
              ),
              NotificationItem(
                id: 'ex2',
                title: 'Confira nossas promoções',
                route: '/promo',
              ),
            ]
            : nc.notifications;

    final screen = MediaQuery.of(context).size;
    final panelWidth = screen.width * 0.8;
    final panelHeight = screen.height * 0.5;
    final panelLeft = (screen.width - panelWidth) / 2 + 0;
    final logoTop = (screen.height - panelHeight) / 2 - 22;

    return Stack(
      children: [
        // 1) blur full-screen
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.transparent),
          ),
        ),

        // 2) painel centralizado
        Center(
          child: Material(
            color: Colors.white.withOpacity(0.9),
            elevation: 24,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: panelWidth,
              constraints: BoxConstraints(maxHeight: panelHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // header com texto e botão de fechar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Container()),

                        Text(
                          'Notificações',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  // lista scrollable de notificações
                  Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (_, i) {
                        final item = list[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            // AnimatedSwitcher para transição de ícone
                            leading: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder:
                                  (child, anim) => ScaleTransition(
                                    scale: anim,
                                    child: child,
                                  ),
                              child:
                                  item.isRead
                                      ? const Icon(
                                        Icons.check_circle,
                                        key: ValueKey('read'),
                                        color: Colors.green,
                                      )
                                      : const Icon(
                                        Icons.circle_outlined,
                                        key: ValueKey('unread'),
                                        color: Colors.grey,
                                      ),
                            ),
                            title: Text(item.title),
                            onTap: () {
                              if (!item.isRead) {
                                item.isRead = true;
                                nc.notifications[i] = item; // notifica mudança
                              }
                              Get.back();
                              Get.toNamed(item.route);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 3) logo “flutuando” sobre o painel
        Positioned(
          left: panelLeft,
          top: logoTop,
          child: Image.asset(
            'assets/images/logo.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
