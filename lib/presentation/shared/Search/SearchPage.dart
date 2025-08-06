import 'package:flutter/material.dart';
import 'package:kolshy_app/presentation/client/product/NewProductDetailPage.dart';

import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'FilterPage.dart';
import 'ResultPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 2;
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['Brown Jacket', 'Nike Pegasus', 'Light Brown'];

  // Add a list for recently viewed items with dummy data
  final List<Map<String, dynamic>> _recentlyViewed = [
    {
      "name": "Lorem ipsum",
      "brand": "Brand name",
      "price": 13.99,
      "rating": 4.9,
      "image": 'https://placehold.co/150x150/E0E0E0/FFFFFF?text=Product1', // Placeholder image
    },
    {
      "name": "Lorem ipsum",
      "brand": "Brand name",
      "price": 13.99,
      "rating": 4.9,
      "image": 'https://placehold.co/150x150/E0E0E0/FFFFFF?text=Product2', // Placeholder image
    },
    {
      "name": "Lorem ipsum",
      "brand": "Brand name",
      "price": 13.99,
      "rating": 4.9,
      "image": 'https://placehold.co/150x150/E0E0E0/FFFFFF?text=Product3', // Placeholder image
    },
    {
      "name": "Lorem ipsum",
      "brand": "Brand name",
      "price": 13.99,
      "rating": 4.9,
      "image": 'https://placehold.co/150x150/E0E0E0/FFFFFF?text=Product4', // Placeholder image
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index != _selectedIndex) {
            setState(() => _selectedIndex = index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => getScreenForTab(index)),
            );
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSearchBar(),
              if (recentSearches.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildRecentSearches(),
              ],
              const SizedBox(height: 24),
              const Text(
                "Recently Viewed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildRecentlyViewedList()),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchResultPage(searchTerm: query),
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    child: const Icon(Icons.close, size: 18, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FilterScreen()),
            );
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE51742),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.filter_alt_outlined, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Searches",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () => setState(() => recentSearches.clear()),
              child: const Text(
                "Clear All",
                style: TextStyle(color: Color(0xFFE51742)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: recentSearches
              .map(
                (term) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchResultPage(searchTerm: term),
                  ),
                );
              },
              child: Chip(
                label: Text(term),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => setState(() => recentSearches.remove(term)),
                backgroundColor: Colors.grey.shade100,
              ),
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRecentlyViewedList() {
    return ListView.separated(
      itemCount: _recentlyViewed.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = _recentlyViewed[index];
        return GestureDetector( // Wrap with GestureDetector
          onTap: () {
            // Navigate to NewProductDetailPage when a recently viewed item is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewProductDetailPage()),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['image'], // Use item['image'] from the _recentlyViewed list
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64,
                    height: 64,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, size: 28, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(item['brand'], style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    const SizedBox(height: 6),
                    Text("AED ${item['price']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text("${item['rating']}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget getScreenForTab(int index) {
  switch (index) {
    case 0:
      return const HomeScreen();
    case 1:
      return const ShoppingCartPage();
    case 2:
      return const SearchPage();
    case 3:
      return const ChatScreen();
    case 4:
      return const SettingsScreen();
    default:
      return const HomeScreen();
  }
}