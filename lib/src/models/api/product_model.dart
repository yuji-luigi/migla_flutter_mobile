class ProductModel {
  final String name;
  final double price;
  final String priceString;
  ProductModel({
    required this.name,
    required this.price,
    required this.priceString,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      priceString: json['priceString'] ?? 'N/',
    );
  }
}
