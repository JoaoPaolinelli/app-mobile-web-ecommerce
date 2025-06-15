class CategoryCountModel {
  final String category;
  final int count;

  CategoryCountModel({required this.category, required this.count});

  factory CategoryCountModel.fromJson(Map<String, dynamic> json) {
    return CategoryCountModel(
      category: json['category'] as String,
      count: (json['count'] as num).toInt(),
    );
  }
}
