// lib/services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:app_ecommerce/models/category_count_model.dart';
import 'package:app_ecommerce/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/banner_model.dart';
import '../models/product_model.dart';

class ApiService {
  // Ajuste a URL conforme necessário (use o IP da máquina ou emulador)

  String get _baseUrl {
    if (kIsWeb) {
      // Flutter Web
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      // Android Emulator
      return 'http://10.0.3.2:3000';
    } else {
      // iOS Simulator e dispositivos reais
      return 'http://localhost:3000';
    }
  }

  /// Busca apenas produtos com desconto
  Future<List<ProductModel>> fetchDiscounted({int limit = 0}) async {
    final uri = Uri.parse('$_baseUrl/products/discounted');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception(
        'Erro ao carregar produtos com desconto (${res.statusCode})',
      );
    }
    final List<dynamic> data = json.decode(res.body) as List<dynamic>;
    var list =
        data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
    if (limit > 0 && list.length > limit) {
      list = list.take(limit).toList();
    }
    return list;
  }

  Future<List<ProductModel>> fetchMostOrdered({int limit = 3}) async {
    final uri = Uri.parse('$_baseUrl/home/most-ordered');
    final response = await http.get(uri);

    // Log para debug
    print('FETCH MOST ORDERED → $uri');
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao carregar mais pedidos: ${response.statusCode}');
    }
  }

  Future<List<ProductModel>> fetchFavorites({int limit = 3}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/home/favorites?limit=$limit'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Erro ao carregar favoritos: ${response.statusCode}');
    }
  }

  BannerModel fetchBannerSync() {
    return BannerModel(
      title: 'Dia dos namorados E-Buy',
      subtitle: 'Descontos de até 30%',
      buttonText: 'VER OFERTAS',
      buttonAction: '/products?promo=true',
    );
  }

  Future<List<CategoryCountModel>> fetchCombinedCategoryCounts() async {
    final uri = Uri.parse('$_baseUrl/categories/combined/counts');
    final res = await http.get(uri);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final list =
          (json.decode(res.body) as List)
              .map(
                (e) => CategoryCountModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      return list;
    }
    throw Exception('Erro ao carregar categorias: ${res.statusCode}');
  }

  /// Busca todos os produtos (unificados Brasil + Europa)
  Future<List<ProductModel>> fetchAllProducts() async {
    final uri = Uri.parse('$_baseUrl/products');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar produtos: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Busca produtos filtrados no back-end (caso precise)
  Future<List<ProductModel>> searchProducts(String q) async {
    final uri = Uri.parse('$_baseUrl/products?filter=$q');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro na busca: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Busca produtos de uma categoria específica (Brazil + Europe)
  Future<List<ProductModel>> fetchByCategory(String category) async {
    final uri = Uri.parse('$_baseUrl/products/category/$category');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao carregar categoria $category: ${response.statusCode}',
      );
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Future<List<Order>> fetchOrders() async {
  //   final uri = Uri.parse('$_baseUrl/orders');
  //   final res = await http.get(uri);
  //   if (res.statusCode != 200 && res.statusCode != 201) {
  //     throw Exception('Erro ao buscar pedidos');
  //   }
  //   final List data = json.decode(res.body);
  //   return data.map((e) => Order.fromJson(e)).toList();
  // }

  // lib/services/order_service.dart
  Future<List<Order>> fetchOrders() async {
    final uri = Uri.parse('$_baseUrl/orders');
    debugPrint('🔗 [fetchOrders] GET $uri');

    final res = await http.get(uri);
    // final res = await http.get(uri);
    debugPrint("\n\n\n AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n\n\n");
    debugPrint('🔍 [fetchOrders] body: ${res.body}');
    // ←— DEBUG: imprime status e corpo
    debugPrint('🔍 [fetchOrders] status: ${res.statusCode}');
    debugPrint('🔍 [fetchOrders] body: ${res.body}');

    if (res.statusCode != 200) {
      throw Exception('Erro ao buscar pedidos: ${res.statusCode}');
    }
    final List data = json.decode(res.body);
    return data.map((e) => Order.fromJson(e)).toList();
  }

  Future<Order> createOrder({
    required List<OrderItem> items,
    required String address,
  }) async {
    final uri = Uri.parse(_baseUrl);
    final body = jsonEncode({
      'items':
          items
              .map(
                (i) => {
                  'productId': i.productId,
                  'productName': i.productName,
                  'unitPrice': i.unitPrice,
                  'quantity': i.quantity,
                },
              )
              .toList(),
      'address': address,
    });
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Falha ao criar pedido (${res.statusCode})');
    }
    return Order.fromJson(jsonDecode(res.body));
  }
}
