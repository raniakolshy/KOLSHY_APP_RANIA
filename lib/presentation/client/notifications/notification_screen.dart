import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent',
                style: Theme.of(context).textTheme.titleLarge,

            ),
            SizedBox(height: 20),
            NotificationItem(),
            NotificationItem(),
            NotificationItem(),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text(
          'Purchase Completed',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(

          fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.',
        ),
        trailing: Text('2 m ago'),
      ),
    );
  }
}
