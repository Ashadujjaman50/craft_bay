import '../../../products/data/models/product_model.dart';

class WishlistItemModel {
  final String id;
  final ProductModel productModel;
  int? quantity;
  final String? color;
  final String? size;

  WishlistItemModel({
    required this.id,
    required this.productModel,
    this.quantity,
    this.color,
    this.size,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['_id'] ?? '',
      productModel: ProductModel.fromJson(json['product'] ?? {}),
      quantity: json['quantity'] ?? 1,
      color: json['color'],
      size: json['size'],
    );
  }
}
