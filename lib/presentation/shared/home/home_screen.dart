import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _promoPageController = PageController(viewportFraction: 0.9);
  int _currentPromoPage = 0;

  static const List<Map<String, String>> categories = [
    {'label': 'All', 'image': 'assets/home/all.png'},
    {'label': 'Electronics', 'image': 'assets/home/electronics.png'},
    {'label': 'Computer & Software', 'image': 'assets/home/computer.jpg'},
    {'label': 'Fashion', 'image': 'assets/home/fashion.jpg'},
    {'label': 'Home & Kitchen', 'image': 'assets/home/home_kitchen.jpg'},
    {'label': 'Health & Beauty', 'image': 'assets/home/beauty.jpg'},
    {'label': 'Groceries & Food', 'image': 'assets/home/grocery.jpg'},
    {'label': 'Children & Toys', 'image': 'assets/home/toys.jpg'},
    {'label': 'Cars & Accessories', 'image': 'assets/home/cars.jpg'},
    {'label': 'Books', 'image': 'assets/home/books.jpg'},
    {'label': 'Sports & Fitness', 'image': 'assets/home/sports.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 4), (timer) {
        if (_promoPageController.hasClients) {
          _currentPromoPage++;
          if (_currentPromoPage >= 3) _currentPromoPage = 0;
          _promoPageController.animateToPage(
            _currentPromoPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildPromoCarousel()),
            SliverToBoxAdapter(child: _buildCategoryTabs()),
            SliverToBoxAdapter(child: _buildSectionTitle('Best Seller')),
            _buildProductGrid(),
            SliverToBoxAdapter(child: _buildSectionTitle('Shop by Category')),
            SliverToBoxAdapter(child: _buildCategoryGrid()),
            SliverToBoxAdapter(child: _buildSectionTitle('New Arrivals')),
            _buildProductGrid(),
            SliverToBoxAdapter(child: _buildBottomBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi Alex C.', style: TextStyle(fontSize: 18)),
                SizedBox(height: 4),
                Text('Welcome back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Promo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final offers = [
      {'title': 'Explore thousands of products', 'subtitle': 'Fast delivery across the Middle East'},
      {'title': 'Summer sale 50% OFF', 'subtitle': 'On selected items, limited time!'},
      {'title': 'New arrivals are here!', 'subtitle': 'Check the freshest styles now'},
    ];

    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _promoPageController,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.orange.withOpacity(0.2), blurRadius: 10),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    offer['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(offer['subtitle']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Chip(
            label: Text(categories[i]['label']!),
            backgroundColor: i == 0 ? Colors.black : Colors.grey[200],
            labelStyle: TextStyle(color: i == 0 ? Colors.white : Colors.black),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProductGrid() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 5,
          itemBuilder: (_, i) => Container(
            width: 150,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    'assets/shoes.png',
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Forem ipsum', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('AED 19.00'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  category['image']!,
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    category['label']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage('assets/shopping_girl.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white.withOpacity(0.9),
                Colors.white.withOpacity(0.0),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '50–40% OFF',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'On selected products\nShop now with big discounts!',
                      style: TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text('Shop Now', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}