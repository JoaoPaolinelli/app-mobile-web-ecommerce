import 'package:app_ecommerce/models/user_model.dart';

class OrderItem {
  final String productId;
  final String productName;
  final int unitPrice;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      unitPrice: (json['unitPrice'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );
  }
}

// class Order {
//   final String id;
//   final DateTime orderDate;
//   final double totalAmount;
//   final List<OrderItem> items;

//   Order({
//     required this.id,
//     required this.orderDate,
//     required this.totalAmount,
//     required this.items,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     // Garante que pegamos uma List aqui
//     final itemsJson = json['items'] as List<dynamic>;

//     return Order(
//       id: json['id'] as String,
//       orderDate: DateTime.parse(json['orderDate'] as String),
//       totalAmount: (json['totalAmount'] as num).toDouble(),
//       items:
//           itemsJson
//               .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
//               .toList(),
//     );
//   }
// }

class Order {
  final String id;
  final DateTime orderDate;
  final double totalAmount;
  final List<OrderItem> items;
  final UserInfo user; // ← adiciona aqui

  Order({
    required this.id,
    required this.orderDate,
    required this.totalAmount,
    required this.items,
    required this.user, // ← e no construtor
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    // 1) Mongo costuma retornar _id, não id
    final rawId = json['id'] ?? json['_id'];
    final id = rawId is String ? rawId : rawId.toString();

    // 2) Pega a data (assegure-se de não ser nula)
    final dateStr = json['orderDate'] as String? ?? json['createdAt'] as String;
    final orderDate = DateTime.parse(dateStr);

    // 3) Items
    final itemsJson = json['items'] as List<dynamic>? ?? [];

    return Order(
      id: id,
      orderDate: orderDate,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      items:
          itemsJson
              .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      // se tiver user, desserialize aqui...
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

//   factory Order.fromJson(Map<String, dynamic> json) {
//     final itemsJson = json['items'] as List<dynamic>;
//     return Order(
//       id: json['id'] as String,
//       orderDate: DateTime.parse(json['orderDate'] as String),
//       totalAmount: (json['totalAmount'] as num).toDouble(),
//       items:
//           itemsJson
//               .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
//               .toList(),
//       user: UserInfo.fromJson(
//         json['user'] as Map<String, dynamic>,
//       ), // ← desserializa
//     );
//   }
// }
