// 1) Defina um observer global
import 'package:app_ecommerce/presentation/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RouteObserverX extends RouteObserver<PageRoute<dynamic>> {
  final nav = Get.find<NavigationController>();

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _updateIndex(previousRoute?.settings.name);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateIndex(route.settings.name);
  }

  void _updateIndex(String? routeName) {
    final idx = nav.pages.indexWhere((r) => routeName?.startsWith(r) ?? false);
    if (idx != -1 && idx != nav.currentIndex.value) {
      nav.currentIndex.value = idx;
    }
  }
}
