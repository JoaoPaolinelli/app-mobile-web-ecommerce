import 'package:app_ecommerce/presentation/pages/cart_page.dart';
import 'package:app_ecommerce/presentation/pages/category_page.dart';
import 'package:app_ecommerce/presentation/pages/category_product_page.dart';
import 'package:app_ecommerce/presentation/pages/confirm_payment_page.dart';
import 'package:app_ecommerce/presentation/pages/history_page.dart';
import 'package:app_ecommerce/presentation/pages/payment_page.dart';
import 'package:app_ecommerce/presentation/pages/phone_number_page.dart';
import 'package:app_ecommerce/presentation/pages/profile_page.dart';
import 'package:app_ecommerce/presentation/pages/search_page.dart';
import 'package:get/get.dart';
import '../presentation/pages/home_page.dart';
// import '../presentation/pages/category_page.dart';
// import '../presentation/pages/cart_page.dart';
// import '../presentation/pages/search_page.dart';
// import '../presentation/pages/profile_page.dart';

abstract class AppRoutes {
  // Nomes das rotas
  static const String home = '/home';
  static const String category = '/category';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String historyPurchase = '/profile/orders';
  static const String cart = '/cart';
  static const String phoneNumber = '/phone';
  static const String payment = '/payment';
  static const String confirmPayment = '/confirm';
  static const String categoryProduct = '/category_products';

  // Lista de GetPage
  static final pages = <GetPage>[
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: category, page: () => CategoryPage()),
    GetPage(name: AppRoutes.search, page: () => SearchPage()),
    GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
    GetPage(name: AppRoutes.historyPurchase, page: () => HistoryPage()),
    GetPage(name: AppRoutes.cart, page: () => CartPage()),
    GetPage(name: AppRoutes.phoneNumber, page: () => PhoneNumberPage()),
    GetPage(name: AppRoutes.payment, page: () => PagamentoPage()),
    GetPage(
      name: AppRoutes.confirmPayment,
      page: () => ConfirmacaoPedidoPage(),
    ),
    GetPage(
      name: AppRoutes.categoryProduct,
      page: () => CategoryProductsPage(),
    ),
  ];
}
