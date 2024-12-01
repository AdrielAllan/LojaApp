class ProductModel {
  final String photo;
  final List<VariationModel> variations;

  ProductModel({required this.photo, required this.variations});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      photo: map['photo'] ?? '',
      variations: (map['variations'] as List).map((item) => VariationModel.fromMap(item)).toList(),
    );
  }
}

class VariationModel {
  final String id;
  final String name;
  final String price;
  final String? promotionalPrice;
  final String category;
  final String? weight;
  final String? quantity;
  final String variation;

  VariationModel({
    required this.id,
    required this.name,
    required this.price,
    this.promotionalPrice,
    required this.category,
    this.weight,
    this.quantity,
    required this.variation,
  });

  factory VariationModel.fromMap(Map<String, dynamic> map) {
    return VariationModel(
      id: map['uuid'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      promotionalPrice: map['promotional_price'],
      category: map['category'] ?? '',
      weight: map['weight'] ?? '',
      quantity: map['quantity'],
      variation: map['variation'] ?? '',
    );
  }
}
