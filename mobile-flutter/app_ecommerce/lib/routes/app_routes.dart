import 'package:app_ecommerce/presentation/pages/category_page.dart';
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
  static const String cart = '/cart';

  // Lista de GetPage
  static final pages = <GetPage>[
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: category, page: () => CategoryPage()),
    GetPage(name: AppRoutes.search, page: () => SearchPage()),
    // GetPage(name: profile, page: () => ProfilePage()),
    // GetPage(name: cart, page: () => CartPage()),
  ];
}
