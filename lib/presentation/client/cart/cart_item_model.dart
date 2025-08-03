class CartItem {
  final String name;
  final String type;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.type,
    required this.price,
    this.quantity = 1,
  });
}