// lib/data/models/order_model.dart

import 'cart_item_model.dart';

class OrderModel {
  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double total;

  OrderModel({
    required this.orderNumber,
    required this.orderDate,
    required this.orderStatus,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });
}