// lib/data/models/cart_item_model.dart

import 'package:kolshy_app/data/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  // Calcule le prix total de cet article (quantité * prix)
  double get totalItemPrice => product.price * quantity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product.name == product.name &&
        other.product.selectedSize == product.selectedSize;
  }

  @override
  int get hashCode => product.name.hashCode ^ product.selectedSize.hashCode;
}