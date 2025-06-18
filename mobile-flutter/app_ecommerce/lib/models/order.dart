// lib/models/order.dart
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
      productId: json['productId'] as String? ?? '',
      productName: json['productName'] as String? ?? '—',
      unitPrice: (json['unitPrice'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }
}

class Order {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final DateTime orderDate;
  final String address; // novo campo
  final List<OrderItem> items;
  final int totalAmount;

  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.orderDate,
    required this.address, // novo campo

    required this.items,
    required this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Mongo geralmente retorna o id em _id
    final rawId = json['id'] ?? json['_id']?['\$oid'] ?? json['_id'];
    final parsedId =
        rawId is Map ? rawId['\$oid'] as String? : rawId as String?;

    return Order(
      id: parsedId ?? '',
      userId: json['userId'] as String? ?? 'automatic', // default
      userName: json['userName'] as String? ?? 'Usuário',
      userEmail: json['userEmail'] as String? ?? 'user@example.com',
      orderDate:
          DateTime.tryParse(json['orderDate'] as String? ?? '') ??
          DateTime.now(),
      address: json['address'] as String? ?? '', // lê o campo

      items:
          (json['items'] as List<dynamic>? ?? [])
              .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalAmount: (json['totalAmount'] as num?)?.toInt() ?? 0,
    );
  }
}
