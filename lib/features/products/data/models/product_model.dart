class ProductModel {
  final String id;
  final String title;
  final int currentPrice;
  final List<String> photos;
  final int quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.photos,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      currentPrice: json['current_price'] ?? 0,
      photos: List<String>.from(json['photos']),
      quantity: json['quantity'] ?? 0,
    );
  }
}
