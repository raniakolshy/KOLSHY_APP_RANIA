import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/shared/settings/Settings_screen.dart';
import '../../client/product/NewProductDetailPage.dart';
import '../Search/ResultPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;
  final PageController _promoPageController = PageController(viewportFraction: 0.9);
  int _currentPromoPage = 0;

  List<Map<String, String>> get categories => [
    {'label': AppLocalizations.of(context)!.all, 'image': 'assets/home/all.png'},
    {'label': AppLocalizations.of(context)!.electronics, 'image': 'assets/home/electronics.png'},
    {'label': AppLocalizations.of(context)!.computerSoftware, 'image': 'assets/home/computer.jpg'},
    {'label': AppLocalizations.of(context)!.fashion, 'image': 'assets/home/fashion.jpg'},
    {'label': AppLocalizations.of(context)!.homeKitchen, 'image': 'assets/home/home_kitchen.jpg'},
    {'label': AppLocalizations.of(context)!.healthBeauty, 'image': 'assets/home/beauty.jpg'},
    {'label': AppLocalizations.of(context)!.groceriesFood, 'image': 'assets/home/grocery.jpg'},
    {'label': AppLocalizations.of(context)!.childrenToys, 'image': 'assets/home/toys.jpg'},
    {'label': AppLocalizations.of(context)!.carsAccessories, 'image': 'assets/home/cars.jpg'},
    {'label': AppLocalizations.of(context)!.books, 'image': 'assets/home/books.jpg'},
    {'label': AppLocalizations.of(context)!.sportsFitness, 'image': 'assets/home/sports.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 4), (timer) {
        if (_promoPageController.hasClients) {
          _currentPromoPage = (_currentPromoPage + 1) % 3;
          _promoPageController.animateToPage(
            _currentPromoPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  void _onNavItemTap(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0: break;
      case 1: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ShoppingCartPage())); break;
      case 2: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SearchPage())); break;
      case 3: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatScreen())); break;
      case 4: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsScreen())); break;
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavItemTap,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildPromoCarousel()),
            SliverToBoxAdapter(child: _buildCategoryTabs()),

            // Dynamic section that changes based on selected category
            if (_selectedCategoryIndex == 0) ...[
              SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.shopByCategory)),
              _buildAllCategoriesGrid(),
            ] else ...[
              SliverToBoxAdapter(child: _buildSectionTitle('Most Sold in ${categories[_selectedCategoryIndex]['label']!}')),
              _buildProductGrid(categories[_selectedCategoryIndex]['label']!),
            ],

            SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.newArrivals)),
            _buildProductGrid('New Arrivals'),
            SliverToBoxAdapter(child: _buildBottomBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(String categoryName) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 225,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 5,
          itemBuilder: (_, i) => ProductCard(
            imageUrl: 'assets/shoes.png',
            title: '$categoryName Product $i',
            price: 'AED ${(19 + i)}.00',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewProductDetailPage()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAllCategoriesGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => _onCategorySelected(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(category['image']!, fit: BoxFit.cover),
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
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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

  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(image: AssetImage('assets/shopping_girl.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.0)],
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
                    Text(AppLocalizations.of(context)!.discountBanner, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 4),
                    Text(AppLocalizations.of(context)!.shopNowText, style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SearchResultPage(searchTerm: '')), // Navigate to the promo result page
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(AppLocalizations.of(context)!.promo, style: const TextStyle(color: Colors.white)),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.hiUser("Alex C."), style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 4),
                Text(AppLocalizations.of(context)!.welcomeBack, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add this navigation code
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchResultPage(searchTerm: '')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(AppLocalizations.of(context)!.promo, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final offers = [
      {
        'title': AppLocalizations.of(context)!.exploreProducts,
        'subtitle': AppLocalizations.of(context)!.fastDelivery,
      },
      {
        'title': AppLocalizations.of(context)!.summerSale,
        'subtitle': AppLocalizations.of(context)!.selectedItems,
      },
      {
        'title': AppLocalizations.of(context)!.newArrivalsBanner,
        'subtitle': AppLocalizations.of(context)!.freshestStyles,
      },
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
                boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.2), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(offer['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          child: GestureDetector(
            onTap: () => _onCategorySelected(i),
            child: Chip(
              label: Text(categories[i]['label']!),
              backgroundColor: _selectedCategoryIndex == i ? Colors.black : Colors.grey[200],
              labelStyle: TextStyle(color: _selectedCategoryIndex == i ? Colors.white : Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}