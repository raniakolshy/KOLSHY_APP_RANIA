import 'package:flutter/material.dart';

class FavoriteProductsScreen extends StatelessWidget {
  const FavoriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(6, (_) => null); // Faux produits

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("My favourite"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.close),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return const ProductCard();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/shoes.png', height: 100), // À ajuster avec tes assets
              const SizedBox(height: 8),
              const Text(
                "HRX by Hrithik Roshan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Neque porro quisquam est qui dolorem ipsum quia",
                style: TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              const Text("AED 499", style: TextStyle(fontWeight: FontWeight.bold)),
              const Row(
                children: [
                  Text("AED 999", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
                  SizedBox(width: 4),
                  Text("50% Off", style: TextStyle(color: Colors.pink, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  Icon(Icons.star_half, color: Colors.amber, size: 16),
                  Icon(Icons.star_border, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text("352", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.pinkAccent),
          ),
        )
      ],
    );
  }
}
