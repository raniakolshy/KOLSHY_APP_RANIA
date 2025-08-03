import 'cart_item_model.dart';

class CartManager {
  static final List<CartItem> _items = [];

  static void addItem(CartItem item) {
    // Check if same product with same type already exists
    final existingIndex = _items.indexWhere((e) => e.name == item.name && e.type == item.type);
    if (existingIndex != -1) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  static List<CartItem> getItems() {
    return _items;
  }

  static void removeItem(CartItem item) {
    _items.remove(item);
  }

  static void clearCart() {
    _items.clear();
  }

  static double getTotal() {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}