// lib/state_management/client/cart_provider.dart

import 'package:flutter/foundation.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/data/models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addProduct(Product product, int quantity) {
    final existingItemIndex = _items.indexWhere(
          (item) => item.product.name == product.name && item.product.selectedSize == product.selectedSize,
    );

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      final itemIndex = _items.indexOf(item);
      if (itemIndex != -1) {
        _items[itemIndex].quantity = newQuantity;
      }
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}