// lib/presentation/controllers/cart_controller.dart

import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    imageUrl: json['imageUrl'],
    title: json['title'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'] as int,
  );

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'title': title,
    'description': description,
    'price': price,
    'quantity': quantity,
  };
}

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  static const _prefsKey = 'cart_items';

  @override
  void onInit() {
    super.onInit();
    _loadCartFromPrefs();
  }

  Future<void> addToCart(CartItem item) async {
    final idx = cartItems.indexWhere(
      (i) => i.title == item.title && i.description == item.description,
    );
    if (idx != -1) {
      cartItems[idx].quantity++;
    } else {
      cartItems.add(item);
    }
    await _saveCartToPrefs();
  }

  Future<void> increaseQuantity(int index) async {
    cartItems[index].quantity++;
    cartItems.refresh(); // <- força atualização reativa
    await _saveCartToPrefs();
  }

  Future<void> decreaseQuantity(int index) async {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh(); // <- força atualização reativa
    await _saveCartToPrefs();
  }

  Future<void> clearCart() async {
    cartItems.clear();
    await _saveCartToPrefs();
  }

  double get total =>
      cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey) ?? [];
    cartItems.value =
        stored.map((str) => CartItem.fromJson(jsonDecode(str))).toList();
  }

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_prefsKey, jsonList);
  }
}
