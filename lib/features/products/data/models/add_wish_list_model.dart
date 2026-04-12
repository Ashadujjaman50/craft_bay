class AddWishListModel {
  final String id;

  AddWishListModel({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'product': id,
    };
  }
}
