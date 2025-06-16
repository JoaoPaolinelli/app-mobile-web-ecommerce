import 'package:get/get.dart';

class CartItem {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  void addToCart(CartItem item) {
    final index = cartItems.indexWhere(
      (i) => i.title == item.title && i.description == item.description,
    );
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
  }

  void increaseQuantity(int index) => cartItems[index].quantity++;
  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
  }

  void clearCart() => cartItems.clear();

  double get total =>
      cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);
}
