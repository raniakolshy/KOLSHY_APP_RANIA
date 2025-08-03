import 'package:flutter/material.dart';

import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'SearchPage.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Color primaryColor = const Color(0xFFE63056);
  int _selectedIndex = 2;
  String selectedCategory = 'All';
  String selectedBrand = 'All';
  int selectedStar = -1;

  final List<String> categories = ['All', 'T-Shirt', 'Headphone', 'Shoes', 'Jeans', 'Bag', 'Watch'];
  final List<String> brands = ['All', 'Nike', 'Alibaba', 'Vans', 'Welly', 'Adidas'];
  final List<int> stars = [5, 4, 3, 2, 1];

  RangeValues _priceRange = const RangeValues(50, 150);

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
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
        ),
        title: const Text(
          'Filter',
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              _buildSectionTitle('Category'),
              _buildChips(categories, selectedCategory, (val) {
                setState(() => selectedCategory = val);
              }),
              const SizedBox(height: 24),
              _buildSectionTitle('Brand'),
              _buildChips(brands, selectedBrand, (val) {
                setState(() => selectedBrand = val);
              }),
              const SizedBox(height: 24),
              _buildSectionTitle('Price'),
              _buildPriceSlider(),
              const SizedBox(height: 24),
              _buildSectionTitle('Stars Range'),
              Wrap(
                spacing: 8,
                children: [
                  _buildChip('All', selectedStar == -1, () => setState(() => selectedStar = -1)),
                  ...stars.map((star) => _buildStarChip(star)).toList(),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFilters,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.black), // Change border color to black
                      ),
                      child: const Text("Reset Filter", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply the filters and navigate back to SearchPage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SearchPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Apply Filter", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }

  Widget _buildChips(List<String> items, String selectedItem, Function(String) onTap) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return _buildChip(item, selectedItem == item, () => onTap(item));
      }).toList(),
    );
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        backgroundColor: selected ? primaryColor : Colors.grey.shade200,
        label: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildStarChip(int star) {
    return GestureDetector(
      onTap: () => setState(() => selectedStar = star),
      child: Chip(
        backgroundColor: selectedStar == star ? primaryColor : Colors.grey.shade200,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              '$star',
              style: TextStyle(
                color: selectedStar == star ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildPriceSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RangeSlider(
          values: _priceRange,
          min: 10,
          max: 250,
          divisions: 48,
          activeColor: primaryColor,
          inactiveColor: Colors.grey.shade300,
          labels: RangeLabels(
            'AED ${_priceRange.start.toInt()}',
            'AED ${_priceRange.end.toInt()}',
          ),
          onChanged: (values) {
            setState(() => _priceRange = values);
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'AED ${_priceRange.start.toInt()} - AED ${_priceRange.end.toInt()}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedCategory = 'All';
      selectedBrand = 'All';
      selectedStar = -1;
      _priceRange = const RangeValues(50, 150);
    });
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