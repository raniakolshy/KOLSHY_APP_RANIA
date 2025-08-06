// lib/shared/settings/MyOrdersScreen.dart

import 'package:flutter/material.dart';
import '../../client/cart/OrderDetailsPage.dart';

class MyOrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyOrders = const [
    {
      'orderNumber': '#12345678',
      'orderDate': 'July 31, 2025',
      'orderStatus': 'Confirmed',
      'customerInfo': {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
      },
      'items': [
        {
          'name': 'Nike Air Max',
          'type': 'Sneakers',
          'quantity': 2,
          'price': 69.99,
          'imagePath': 'assets/shoes.png',
        },
      ],
      'shippingAddress': '742 Evergreen Terrace,\nSpringfield',
      'paymentMethod': 'Apple Pay',
      'totals': {
        'subtotal': 139.98,
        'shipping': 0.00,
        'total': 139.98,
      },
    },
    {
      'orderNumber': '#12345679',
      'orderDate': 'August 05, 2025',
      'orderStatus': 'Processing',
      'customerInfo': {
        'name': 'Jane Doe',
        'email': 'jane.doe@example.com',
      },
      'items': [
        {
          'name': 'T-Shirt',
          'type': 'Apparel',
          'quantity': 1,
          'price': 50.00,
          'imagePath': 'assets/tshirt.png',
        },
      ],
      'shippingAddress': '123 Main Street,\nAnytown',
      'paymentMethod': 'Credit Card',
      'totals': {
        'subtotal': 50.00,
        'shipping': 10.00,
        'total': 60.00,
      },
    },
  ];

  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: dummyOrders.length,
        itemBuilder: (context, index) {
          final order = dummyOrders[index];
          return OrderListItem(order: order);
        },
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderListItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Order ${order['orderNumber']}'),
        subtitle: Text('${order['orderDate']} - ${order['orderStatus']}'),
        trailing: Text('AED ${order['totals']['total'].toStringAsFixed(2)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(orderData: order),
            ),
          );
        },
      ),
    );
  }
}