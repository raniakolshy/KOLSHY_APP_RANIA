import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/shared/settings/Settings_screen.dart';
import '../../client/notifications/notification_screen.dart';
import '../../client/product/NewProductDetailPage.dart';
import '../Search/ResultPage.dart'; // Change this import if needed
import 'package:google_fonts/google_fonts.dart';

// These should be defined once, preferably in a global theme or constants file
const Color primaryPink = Color(0xFFE51742);
const Color lightGrey = Color(0xFFF7F7F7);
const Color darkGrey = Color(0xFF444444);
const Color offWhite = Color(0xFFFBFBFB);
const Color modernWhite = Color(0xFFFFFFFF);
const Color modernBackground = Color(0xFFF0F0F0);

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

  final List<String> _favoriteProducts = [];

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

  @override
  void dispose() {
    _promoPageController.dispose();
    super.dispose();
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

  void _toggleFavorite(String productId) {
    setState(() {
      if (_favoriteProducts.contains(productId)) {
        _favoriteProducts.remove(productId);
      } else {
        _favoriteProducts.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: modernBackground,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavItemTap,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildPromoCarousel()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: _buildCategoryTabs()),
            SliverToBoxAdapter(
              child: _selectedCategoryIndex == 0
                  ? _buildSectionTitle(AppLocalizations.of(context)!.shopByCategory, null)
                  : _buildSectionTitle('Most Sold in ${categories[_selectedCategoryIndex]['label']!}', 'See All'),
            ),
            _selectedCategoryIndex == 0
                ? _buildAllCategoriesGrid()
                : _buildProductGrid(categories[_selectedCategoryIndex]['label']!),
            SliverToBoxAdapter(child: _buildSaleBanner('assets/sale.jpg')),
            SliverToBoxAdapter(child: _buildSectionTitle('Hot Deals', 'See All')),
            _buildProductGrid('Hot Deals', hasDiscount: true),
            SliverToBoxAdapter(child: _buildSectionTitle('Most Popular', 'See All')),
            _buildProductGrid('Most Popular', hasDiscount: false),
            SliverToBoxAdapter(child: _buildAdBanner(
              'assets/yellow-back.jpg',
              AppLocalizations.of(context)!.summerSale,
              'Up to 50% Off!',
              Colors.amber.shade100,
            )),
            SliverToBoxAdapter(child: _buildSectionTitle(AppLocalizations.of(context)!.newArrivals, 'See All')),
            _buildProductGrid('New Arrivals', hasDiscount: false),
            SliverToBoxAdapter(child: _buildSectionTitle('Special Offers', 'See All')),
            _buildSpecialOffersGrid(),
            SliverToBoxAdapter(child: _buildBottomBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(String categoryName, {bool hasDiscount = true}) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 290,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 5,
          itemBuilder: (_, i) {
            final productId = '$categoryName Product $i';
            return Padding(
              padding: EdgeInsets.only(right: i < 4 ? 12.0 : 0),
              child: ProductCard(
                imageUrl: 'assets/shoes.png',
                title: productId,
                price: 'AED ${(19 + i)}.00',
                oldPrice: hasDiscount ? 'AED ${(29 + i)}.00' : null,
                rating: 4.5,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewProductDetailPage()),
                  );
                },
                isFavorite: _favoriteProducts.contains(productId),
                onFavoriteToggle: () => _toggleFavorite(productId),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSpecialOffersGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final productId = 'Special Offer ${index + 1}';
            return ProductCard(
              imageUrl: 'assets/electronics_deal.jpg',
              title: productId,
              price: 'AED ${(49 + index)}.00',
              oldPrice: 'AED ${(79 + index)}.00',
              rating: 4.8,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NewProductDetailPage()),
                );
              },
              isFavorite: _favoriteProducts.contains(productId),
              onFavoriteToggle: () => _toggleFavorite(productId),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAllCategoriesGrid() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.05,
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
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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

  Widget _buildSectionTitle(String title, String? seeAllText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (seeAllText != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                String searchQuery = title.replaceFirst('Most Sold in ', '').trim();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SearchResultPage(searchTerm: searchQuery)),
                );
              },
              child: Text(
                seeAllText,
                style: GoogleFonts.poppins(color: primaryPink),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomBanner() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                    Text(
                      AppLocalizations.of(context)!.discountBanner,
                      style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(AppLocalizations.of(context)!.shopNowText, style: GoogleFonts.poppins(color: Colors.black87)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SearchResultPage(searchTerm: 'Promo')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(AppLocalizations.of(context)!.promo, style: GoogleFonts.poppins(color: Colors.white)),
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

  Widget _buildSaleBanner(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchPage()),
          );
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdBanner(String imagePath, String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.2)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: darkGrey.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.shopNowText,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.hiUser('Alex C.'), style: GoogleFonts.poppins(fontSize: 16, color: darkGrey)),
                  Text(AppLocalizations.of(context)!.welcomeBack, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: darkGrey, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: modernWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: darkGrey),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.search,
                style: GoogleFonts.poppins(color: darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCarousel() {
    final List<Map<String, dynamic>> offers = [
      {'title': AppLocalizations.of(context)!.exploreProducts, 'subtitle': AppLocalizations.of(context)!.fastDelivery, 'color': Colors.orange},
      {'title': AppLocalizations.of(context)!.summerSale, 'subtitle': AppLocalizations.of(context)!.selectedItems, 'color': primaryPink},
      {'title': AppLocalizations.of(context)!.newArrivalsBanner, 'subtitle': AppLocalizations.of(context)!.freshestStyles, 'color': Colors.blue},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 140,
        child: PageView.builder(
          controller: _promoPageController,
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: modernWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (offer['color'] as Color).withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(offer['title'] as String, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text(offer['subtitle'] as String, style: GoogleFonts.poppins(color: Colors.black54)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => _onCategorySelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: _selectedCategoryIndex == i ? primaryPink : modernWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _selectedCategoryIndex == i ? primaryPink : Colors.grey.shade300, width: 1.5),
                boxShadow: _selectedCategoryIndex == i
                    ? [
                  BoxShadow(
                    color: primaryPink.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
                    : null,
              ),
              child: Center(
                child: Text(
                  categories[i]['label']!,
                  style: GoogleFonts.poppins(
                    color: _selectedCategoryIndex == i ? modernWhite : darkGrey,
                    fontWeight: _selectedCategoryIndex == i ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
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
  final String? oldPrice;
  final double rating;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.oldPrice,
    this.rating = 0.0,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: modernWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.asset(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
                  if (oldPrice != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryPink,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '-${(((double.parse(oldPrice!.replaceAll(RegExp(r'[^0-9.]'), '')) - double.parse(price.replaceAll(RegExp(r'[^0-9.]'), ''))) / double.parse(oldPrice!.replaceAll(RegExp(r'[^0-9.]'), ''))) * 100).round()}%',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: modernWhite,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? primaryPink : Colors.grey.shade400,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13, color: darkGrey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(rating.toString(), style: GoogleFonts.poppins(fontSize: 11, color: darkGrey)),
                      Text(' (${(rating * 100).round()})', style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: primaryPink, fontSize: 16)),
                      if (oldPrice != null) ...[
                        const SizedBox(width: 8),
                        Text(oldPrice!, style: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 11, decoration: TextDecoration.lineThrough)),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}