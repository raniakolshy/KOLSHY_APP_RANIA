// lib/presentation/client/product/NewProductDetailPage.dart

import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/View_profile.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/data/models/product_model.dart';
import 'package:kolshy_app/presentation/client/cart/cart_manager.dart';
import 'package:kolshy_app/presentation/client/cart/CheckoutPage.dart';

class NewProductDetailPage extends StatefulWidget {
  const NewProductDetailPage({super.key});

  @override
  State<NewProductDetailPage> createState() => _NewProductDetailPageState();
}

class _NewProductDetailPageState extends State<NewProductDetailPage> {
  final Color primaryColor = const Color(0xFFE63056);
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  String selectedSize = 'M';
  bool isFavorite = false;
  int quantity = 1;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<String> productImages = [
    'assets/product_image.png',
    'assets/product_image.png',
    'assets/product_image.png',
  ];

  /// Vendor for this product
  final Vendor vendor = const Vendor(
    id: 'vendor_001',
    name: 'Aliana',
    shopName: 'Aliana Shop',
    avatarUrl: null,
    rating: 4.7,
    productsCount: 128,
    followers: 2530,
  );

  final List<Map<String, dynamic>> customerReviews = [
    {
      'name': 'Alice',
      'comment': 'Amazing quality, fits perfectly!',
      'date': 'Jul 25, 2025',
      'images': ['assets/product_image.png', 'assets/product_image.png'],
    },
    {
      'name': 'Bob',
      'comment': 'Comfortable and stylish. Worth it!',
      'date': 'Jul 21, 2025',
      'images': ['assets/product_image.png'],
    },
    {
      'name': 'Charlie',
      'comment': 'Good value for money.',
      'date': 'Jul 15, 2025',
      'images': [],
    },
  ];

  void _addToCart() {
    final loc = AppLocalizations.of(context)!;
    final productToAdd = Product(
      name: loc.productTitle,
      brand: loc.productBrand,
      price: 13.99,
      imageUrl: productImages.first,
      selectedSize: selectedSize,
    );

    CartManager().addProduct(productToAdd, quantity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$quantity ${loc.productTitle} added to cart.'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Buy Now: add current item to cart then open CheckoutPage
  void _goToCheckout() {
    final loc = AppLocalizations.of(context)!;

    final productToAdd = Product(
      name: loc.productTitle,
      brand: loc.productBrand,
      price: 13.99,
      imageUrl: productImages.first,
      selectedSize: selectedSize,
    );
    CartManager().addProduct(productToAdd, quantity);

    final cartItems = CartManager().items;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(cartItems: cartItems),
      ),
    );
  }

  /// Open vendor profile page
  void _openVendorProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VendorProfileScreen(vendor: vendor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                _buildProductImage(),
                const SizedBox(height: 16),
                Text(loc.productTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(loc.productBrand, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 6),
                _buildRating(),
                const SizedBox(height: 16),
                const Text('AED 13.99', style: TextStyle(fontSize: 20, color: Color(0xFFE63056), fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),

                /// VENDOR BLOCK (shop name only + button in English)
                _buildVendorBlock(),

                const SizedBox(height: 16),
                _buildSizeSelection(),
                const SizedBox(height: 16),
                _buildAvailability(loc),
                const SizedBox(height: 16),
                _buildExpandableSection(loc.description, loc.descriptionContent, true),
                const SizedBox(height: 16),
                _buildExpandableSection(loc.ingredients, loc.ingredientsContent, false),
                const SizedBox(height: 16),
                _buildExpandableSection(loc.howToUse, loc.howToUseContent, false),
                const SizedBox(height: 16),
                Text(loc.customerReviews, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _buildCustomerReviews(),
                const SizedBox(height: 16),
                Text(loc.recommendedProducts, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildRecommendedProducts(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityAddToCartAndBuyNow(loc),
          BottomNavBar(
            selectedIndex: 2,
            onItemTapped: (index) {
              if (index != 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => getScreenForTab(index)),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 24),
        onPressed: () => Navigator.of(context).pop(),
      ),
      IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? const Color(0xFFE63056) : Colors.black,
          size: 24,
        ),
        onPressed: () => setState(() => isFavorite = !isFavorite),
      ),
    ],
  );

  Widget _buildProductImage() => Column(
    children: [
      SizedBox(
        height: 350,
        child: PageView.builder(
          controller: _pageController,
          itemCount: productImages.length,
          onPageChanged: (index) => setState(() => _currentPageIndex = index),
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              productImages[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(productImages.length, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: _currentPageIndex == index ? 22 : 6,
            decoration: BoxDecoration(
              color: _currentPageIndex == index ? primaryColor : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    ],
  );

  Widget _buildRating() => const Row(
    children: [
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star, color: Colors.amber, size: 18),
      Icon(Icons.star_border, color: Colors.grey, size: 18),
      SizedBox(width: 6),
      Text('(234 reviews)', style: TextStyle(fontSize: 14, color: Colors.black54)),
    ],
  );

  /// Shop name only + "View profile" button (English)
  Widget _buildVendorBlock() {
    return InkWell(
      onTap: _openVendorProfile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: vendor.avatarUrl != null
                  ? (vendor.avatarUrl!.startsWith('http')
                  ? NetworkImage(vendor.avatarUrl!)
                  : AssetImage(vendor.avatarUrl!) as ImageProvider)
                  : null,
              child: vendor.avatarUrl == null
                  ? Text(
                vendor.shopName.isNotEmpty ? vendor.shopName[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                vendor.shopName, // ONLY the shop name
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _openVendorProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 0,
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              child: const Text('View profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeSelection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Sizes", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(
        children: sizes.map((size) {
          final bool isSelected = selectedSize == size;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => selectedSize = size),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? primaryColor : Colors.grey, width: 2),
                ),
                child: Text(size, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );

  Widget _buildAvailability(AppLocalizations loc) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF4A9F62), size: 16),
          const SizedBox(width: 10),
          Expanded(child: Text(loc.inStock, style: const TextStyle(fontSize: 12, color: Color(0xFF4A9F62)))),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const Icon(Icons.local_shipping, size: 16),
          const SizedBox(width: 10),
          Expanded(child: Text(loc.freeDelivery, style: const TextStyle(fontSize: 12))),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          const Icon(Icons.store, size: 16),
          const SizedBox(width: 10),
          Expanded(child: Text(loc.availableInStore, style: const TextStyle(fontSize: 12))),
        ],
      ),
    ],
  );

  Widget _buildExpandableSection(String title, String content, bool initiallyExpanded) =>
      ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: initiallyExpanded,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(content, style: const TextStyle(height: 1.5)),
          ),
        ],
      );

  Widget _buildCustomerReviews() => Column(
    children: customerReviews.map((review) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(review['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(review['comment']),
            const SizedBox(height: 10),
            if (review['images'] != null && review['images'].isNotEmpty)
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: (review['images'] as List<String>).map((img) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(img, width: 80, height: 80, fit: BoxFit.cover),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      );
    }).toList(),
  );

  Widget _buildRecommendedProducts() => SizedBox(
    height: 210,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(2, (index) => const ProductCard()),
    ),
  );

  Widget _buildQuantityAddToCartAndBuyNow(AppLocalizations loc) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) setState(() => quantity--);
                },
              ),
              Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => quantity++),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _addToCart,
            child: Text(loc.addToCart, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _goToCheckout,
            child: Text(AppLocalizations.of(context)!.buyNow, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/product_image.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Black Winter...', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('AED 499', style: TextStyle(color: Color(0xFFE63056))),
        ],
      ),
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
