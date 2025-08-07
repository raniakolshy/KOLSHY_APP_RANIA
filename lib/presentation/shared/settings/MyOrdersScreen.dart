import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kolshy_app/data/models/order_model.dart';
import 'package:kolshy_app/presentation/client/cart/orders_manager.dart';
import '../../client/cart/OrderDetailsPage.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Consumer<OrdersManager>(
        builder: (context, ordersManager, child) {
          final orders = ordersManager.orders;

          if (orders.isEmpty) {
            return const Center(
              child: Text("You don't have any orders yet."),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderListItem(order: order);
            },
          );
        },
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Order ${order.orderNumber}'),
        subtitle: Text('${order.orderDate} - ${order.orderStatus}'),
        trailing: Text('AED ${order.total.toStringAsFixed(2)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(items: order.items),
            ),
          );
        },
      ),
    );
  }
}