import 'package:app_ecommerce/core/utils/navigator_observer.dart';
import 'package:app_ecommerce/presentation/controllers/cart_controller.dart';
import 'package:app_ecommerce/presentation/controllers/home_controller.dart';
import 'package:app_ecommerce/presentation/controllers/navigation_controller.dart';
import 'package:app_ecommerce/presentation/controllers/notification_controller.dart';
import 'package:app_ecommerce/presentation/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Registra o HomeController globalmente
  Get.put(NavigationController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(NotificationController(), permanent: true);
  Get.put(OrderController());
  Get.put(CartController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-Buy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      navigatorObservers: [RouteObserverX()],
      initialRoute: AppRoutes.home,

      getPages: AppRoutes.pages,
    );
  }
}
