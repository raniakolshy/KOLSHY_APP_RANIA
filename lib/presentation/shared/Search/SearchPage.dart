import 'package:flutter/material.dart';

import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'FilterPage.dart'; // Add the import for FilterPage.dart
import 'ResultPage.dart'; // Add the import for ResultPage.dart

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 2;
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['Brown Jacket', 'Nike Pegasus', 'Light Brown'];

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
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
        ),title: const Text(
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
                      // When user presses Enter, navigate to the ResultPage
                      if (query == 'T-Shirt') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SearchResultPage()),
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
            // Navigate to the FilterPage when the pink filter button is pressed
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
                (term) => Chip(
              label: Text(term),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () =>
                  setState(() => recentSearches.remove(term)),
              backgroundColor: Colors.grey.shade100,
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRecentlyViewedList() {
    final items = List.generate(4, (index) => index);
    final images = [
      'https://via.placeholder.com/150?text=Image+1',
      'https://via.placeholder.com/150?text=Image+2',
      'https://via.placeholder.com/150?text=Image+3',
      'https://via.placeholder.com/150?text=Image+4',
    ];

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                images[index % images.length],
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
                children: const [
                  Text("Lorem ipsum", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text("Brand name", style: TextStyle(color: Colors.black54, fontSize: 13)),
                  SizedBox(height: 6),
                  Text("AED 13.99", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text("4.9", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
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