// lib/data/models/product_model.dart

class Product {
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String? selectedSize;
  int quantity;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.selectedSize,
    this.quantity = 1,
  });
}