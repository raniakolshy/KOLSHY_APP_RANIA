import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import '../../shared/Search/SearchPage.dart';
import '../../shared/home/home_screen.dart';
import '../../shared/settings/Settings_screen.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../Messages/Chat_screen.dart';
import '../cart/ShoppingCartPage.dart';
import '../notifications/notification_screen.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _allProducts = List.generate(6, (index) => {
    'id': index,
    'nameKey': 'product${index}Name',
    'image': 'assets/shoes.png',
  });

  List<Map<String, dynamic>> _displayedProducts = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _displayedProducts = [..._allProducts];
  }

  void _removeProduct(int id) {
    setState(() {
      _displayedProducts.removeWhere((product) => product['id'] == id);
    });
  }

  void _filterProducts(String text) {
    setState(() {
      _searchText = text;
      _displayedProducts = _allProducts
          .where((product) => AppLocalizations.of(context)!
          .getTranslatedProductName(product['nameKey'])
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.favourites,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchFavorites,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _filterProducts('');
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _displayedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final product = _displayedProducts[index];
                return AnimatedProductCard(
                  key: ValueKey(product['id']),
                  nameKey: product['nameKey'],
                  imagePath: product['image'],
                  onRemove: () => _removeProduct(product['id']),
                );
              },
            ),
          ),
        ],
      ),
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
    );
  }
}

class AnimatedProductCard extends StatefulWidget {
  final String nameKey;
  final String imagePath;
  final VoidCallback onRemove;

  const AnimatedProductCard({
    super.key,
    required this.nameKey,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  State<AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard> with TickerProviderStateMixin {
  bool _isFavorite = true;
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  void _toggleFavorite() async {
    setState(() => _isFavorite = false);
    await Future.delayed(const Duration(milliseconds: 200));
    await _fadeController.forward();
    widget.onRemove();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(_fadeController),
      child: Stack(
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
                Image.asset(widget.imagePath, height: 100),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.getTranslatedProductName(widget.nameKey),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.productDescription,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(AppLocalizations.of(context)!.currentPrice,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.originalPrice,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                    const SizedBox(width: 4),
                    Text(AppLocalizations.of(context)!.discount,
                        style: const TextStyle(color: Colors.pink, fontSize: 12)),
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
            child: GestureDetector(
              onTap: _toggleFavorite,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(_isFavorite),
                    color: Colors.pinkAccent,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension LocalizedProductName on AppLocalizations {
  String getTranslatedProductName(String key) {
    return {
      'product0Name': product0Name,
      'product1Name': product1Name,
      'product2Name': product2Name,
      'product3Name': product3Name,
      'product4Name': product4Name,
      'product5Name': product5Name,
    }[key] ?? key;
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