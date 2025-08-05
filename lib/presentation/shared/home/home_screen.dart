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
      _selectedCategoryIndex = index;  // Mettre à jour l'index de la catégorie sélectionnée
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
            SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.bestSeller)),
            _buildProductGrid(),
            SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.shopByCategory)),
            // Affichage de l'image de la catégorie sélectionnée
            SliverToBoxAdapter(
              child: _selectedCategoryIndex == 0 ? _buildAllCategoriesImage() : _buildCategoryImage(),
            ),
            SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.newArrivals)),
            _buildProductGrid(),
            SliverToBoxAdapter(child: _buildBottomBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  // Affiche l'image de la catégorie sélectionnée
  Widget _buildCategoryImage() {
    final selectedCategory = categories[_selectedCategoryIndex];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(
        selectedCategory['image']!,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  // Affiche l'image pour toutes les catégories (si "All" est sélectionné)
  Widget _buildAllCategoriesImage() {
    return Padding(
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
          return ClipRRect(
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
          );
        },
      ),
    );
  }

  // Méthode pour afficher un titre de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  // Méthode pour afficher une grille de produits (vous pouvez personnaliser le contenu selon vos besoins)
  Widget _buildProductGrid() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 5,
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NewProductDetailPage())),
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
                    child: Image.asset('assets/shoes.png', height: 130, width: double.infinity, fit: BoxFit.cover),
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
      ),
    );
  }

  // Méthode pour afficher une bannière en bas de la page
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(AppLocalizations.of(context)!.shopNow, style: const TextStyle(color: Colors.white)),
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
            onPressed: () {},
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
