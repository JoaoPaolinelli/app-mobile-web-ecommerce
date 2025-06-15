// lib/models/product_model.dart

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final double price;
  final bool hasDiscount;
  final double discountValue;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.hasDiscount,
    required this.discountValue,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Parsing seguro para cada campo
    final rawId = json['id'];
    final rawName = json['name'];
    final rawDescription = json['description'];
    final rawCategory = json['category'];
    final rawImageUrl = json['imageUrl'];
    final rawPrice = json['price'];
    final rawHasDiscount = json['hasDiscount'];
    final rawDiscountValue = json['discountValue'];

    return ProductModel(
      id: rawId?.toString() ?? '',
      name: rawName?.toString() ?? '',
      description: rawDescription?.toString() ?? '',
      category: rawCategory?.toString() ?? '',
      imageUrl: rawImageUrl?.toString() ?? '',
      price:
          (rawPrice is num)
              ? rawPrice.toDouble()
              : double.tryParse(rawPrice?.toString() ?? '') ?? 0.0,
      hasDiscount:
          rawHasDiscount is bool
              ? rawHasDiscount
              : (rawHasDiscount?.toString().toLowerCase() == 'true'),
      discountValue:
          (rawDiscountValue is num)
              ? rawDiscountValue.toDouble()
              : double.tryParse(rawDiscountValue?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'imageUrl': imageUrl,
    'price': price,
    'hasDiscount': hasDiscount,
    'discountValue': discountValue,
  };
}
