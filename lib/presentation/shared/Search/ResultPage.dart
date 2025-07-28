import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  int _selectedIndex = 2;
  String searchTerm = "T-Shirt";
  List<String> recentSearches = ['Dress', 'Shoes', 'Shirt'];
  List<bool> _isFavoriteList = List.generate(4, (index) => false);

  final List<Map<String, dynamic>> products = [
    {
      "name": "Black Winter Hoodie",
      "brand": "WonderWear",
      "description": "Autumn and Winter casual cotton-padded jacket",
      "price": 499,
      "rating": 4.5,
      "image": 'assets/shoes.png',
    },
    {
      "name": "Mens Starry Shirt",
      "brand": "StarWear",
      "description": "Mens Starry Sky Printed Shirt 100% Cotton Fabric",
      "price": 399,
      "rating": 4.7,
      "image": 'assets/shoes.png',
    },
    {
      "name": "Black Dress",
      "brand": "Fashionista",
      "description": "Solid Black Dress for Women, Sexy Chain Shorts Ladies",
      "price": 299,
      "rating": 4.3,
      "image": 'assets/shoes.png',
    },
    {
      "name": "Pink Embroidered Dress",
      "brand": "Earthen",
      "description": "EARTHEN Rose Pink Embroidered Tiered Maxi Dress",
      "price": 399,
      "rating": 4.6,
      "image": 'assets/shoes.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Search Result",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildSearchResult(),
              const SizedBox(height: 16),
              Expanded(child: _buildProductGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                Icon(Icons.search, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.close, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Color(0xFFE63056),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_alt_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSearchResult() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${products.length} Found for \"$searchTerm\"",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              searchTerm = '';
              _isFavoriteList = List.generate(4, (index) => false);
            });
          },
          child: const Text(
            "Clear All",
            style: TextStyle(color: Color(0xFFE63056), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
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
                  Image.asset(product['image'], height: 100, fit: BoxFit.cover),
                  const SizedBox(height: 8),
                  Text(
                    product['brand'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['description'],
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text("AED ${product['price']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Row(
                    children: [
                      Text("AED 999", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
                      SizedBox(width: 4),
                      Text("50% Off", style: TextStyle(color: Colors.pink, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${product['rating']}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() => _isFavoriteList[index] = !_isFavoriteList[index]);
                },
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(
                    _isFavoriteList[index] ? Icons.favorite : Icons.favorite_border,
                    color: _isFavoriteList[index] ? Colors.pink : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 1, color: Colors.black.withOpacity(0.05)),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(iconNames.length, (index) {
                final name = iconNames[index];
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/Icons/${name}${isSelected ? 'G' : 'F'}.png',
                          width: 26,
                          height: 26,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            color: Colors.black,
                          ),
                          child: Text(name),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}