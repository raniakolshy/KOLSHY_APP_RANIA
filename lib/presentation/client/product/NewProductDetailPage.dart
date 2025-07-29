import 'package:flutter/material.dart';

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
  int _selectedIndex = 0;

  int quantity = 1;

  bool showDescription = false;
  bool showHowToUse = false;
  bool showIngredients = false;

  final List<String> productImages = [
    'assets/avatar.png',
    'assets/avatar.png',
    'assets/avatar.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildProductImage(),
                const SizedBox(height: 16),
                _buildProductTitle(),
                const SizedBox(height: 8),
                _buildProductPrice(),
                const SizedBox(height: 16),
                _buildSizeSelection(),
                const SizedBox(height: 16),
                _buildQuantitySelector(),
                const SizedBox(height: 16),
                _buildAvailability(),
                const SizedBox(height: 24),
                _buildExpandableSection(
                  'Description',
                  'Corem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos.',
                  showDescription,
                      () => setState(() => showDescription = !showDescription),
                ),
                const SizedBox(height: 16),
                _buildExpandableSection(
                  'How to Use',
                  'Simply apply the product on the skin and wait for 5 minutes before rinsing off.',
                  showHowToUse,
                      () => setState(() => showHowToUse = !showHowToUse),
                ),
                const SizedBox(height: 16),
                _buildExpandableSection(
                  'Ingredients',
                  'Water, Glycerin, Aloe Vera, Vitamin C, Essential Oils.',
                  showIngredients,
                      () => setState(() => showIngredients = !showIngredients),
                ),
                const SizedBox(height: 20),
                _buildCustomerReviews(),
                const SizedBox(height: 20),
                _buildRecommendedProducts(),
                const SizedBox(height: 20),
                _buildAddToCartButton(),
                const SizedBox(height: 10),
                _buildScrollBar(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: _buildBottomNavigationBar()),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 12),
        const Text(
          "Product Details",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: primaryColor,
            size: 28,
          ),
          onPressed: () => setState(() => isFavorite = !isFavorite),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        itemCount: productImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                productImages[index],
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductTitle() {
    return const Text(
      'Modern Product Name',
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildProductPrice() {
    return const Text(
      'AED 199.99',
      style: TextStyle(fontSize: 20, color: Color(0xFFE63056)),
    );
  }

  Widget _buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Size", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: sizes.map((size) {
            return GestureDetector(
              onTap: () => setState(() => selectedSize = size),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: selectedSize == size ? primaryColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 8),
                  ],
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: selectedSize == size ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      children: [
        const Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(width: 8),
        Row(
          children: [
            _buildQuantityButton(Icons.remove, () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              }
            }),
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildQuantityButton(Icons.add, () {
              setState(() {
                quantity++;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, color: primaryColor),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildAvailability() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.check, size: 20, color: Colors.green),
            SizedBox(width: 8),
            Text('In Stock', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.local_shipping, size: 20, color: Colors.blue),
            SizedBox(width: 8),
            Text('Free delivery', style: TextStyle(fontSize: 16)),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.store, size: 20, color: Colors.purple),
            SizedBox(width: 8),
            Text('Available in the nearest store', style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableSection(String title, String content, bool showContent, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 8)],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Icon(showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: primaryColor),
              ],
            ),
            if (showContent) ...[
              const SizedBox(height: 8),
              Text(content, style: const TextStyle(fontSize: 14)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Customer Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)],
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/avatar.png')),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('User Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                Icons.star,
                                size: 18,
                                color: starIndex < 4 ? Colors.yellow : Colors.grey,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          const Text('This product is amazing! I loved it so much, and I am happy with my purchase.', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('2 days ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecommendedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recommended for You', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              5, // Number of product cards to show
                  (index) => const Padding(
                padding: EdgeInsets.only(right: 12),
                child: ProductCard(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Add To Cart", style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildScrollBar() {
    return Container(
      height: 4,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
        ],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        elevation: 0,
        items: List.generate(5, (index) {
          final name = iconNames[index];
          final isSelected = index == _selectedIndex;
          return BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black.withOpacity(0.05) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/Icons/${name}${isSelected ? 'G' : 'F'}.png',
                width: 26,
                height: 26,
              ),
            ),
            label: name,
          );
        }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/avatar.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'New Black Winter',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text(
          'AED 499',
          style: TextStyle(fontSize: 14, color: Color(0xFFE63056)),
        ),
      ],
    );
  }
}