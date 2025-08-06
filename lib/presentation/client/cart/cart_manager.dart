// lib/core/services/cart_manager.dart

import 'package:kolshy_app/data/models/product_model.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';

class CartManager {
  // Pattern Singleton pour une seule instance du gestionnaire de panier
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addProduct(Product product, int quantity) {
    // Vérifie si un article avec le même produit et la même taille existe déjà
    final existingItemIndex = _items.indexWhere(
          (item) => item.product.name == product.name && item.product.selectedSize == product.selectedSize,
    );

    if (existingItemIndex != -1) {
      // Si l'article existe, met à jour sa quantité
      _items[existingItemIndex].quantity += quantity;
    } else {
      // Sinon, ajoute un nouvel article au panier
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }

  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity > 0) {
      final itemIndex = _items.indexOf(item);
      if (itemIndex != -1) {
        _items[itemIndex].quantity = newQuantity;
      }
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
  }

  void clearCart() {
    _items.clear();
  }
}