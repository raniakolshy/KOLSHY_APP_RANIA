// lib/data/orders_manager.dart

import 'package:flutter/foundation.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/data/models/order_model.dart'; // Vous aurez besoin de ce modèle
import 'package:uuid/uuid.dart';

class OrdersManager extends ChangeNotifier {
  final List<OrderModel> _myOrders = [];

  List<OrderModel> get orders => _myOrders;

  void addOrder(List<CartItem> items) {
    const uuid = Uuid();
    final newOrder = OrderModel(
      orderNumber: '#${uuid.v4().substring(0, 8).toUpperCase()}',
      orderDate: DateTime.now().toString().substring(0, 10), // Format YYYY-MM-DD
      orderStatus: 'Confirmed',
      items: items,
      subtotal: _calculateSubtotal(items),
      shipping: 0.0,
      total: _calculateSubtotal(items),
    );

    _myOrders.add(newOrder);
    notifyListeners(); // Notifie tous les widgets qui écoutent ce manager
  }

  double _calculateSubtotal(List<CartItem> items) {
    double subtotal = 0.0;
    for (var item in items) {
      subtotal += item.quantity * item.product.price;
    }
    return subtotal;
  }
}