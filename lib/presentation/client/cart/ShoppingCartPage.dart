// lib/presentation/client/cart/shopping_cart_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/presentation/client/cart/cart_manager.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/client/cart/CheckoutPage.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final Color primaryColor = const Color(0xFFE63056);

  // Utilise le CartManager pour accéder à la liste des articles
  final cartManager = CartManager();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cartItems = cartManager.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
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
        title: Text(
          t.myCart,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1, // L'index du panier est 1
        onItemTapped: (index) {
          if (index != 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => getScreenForTab(index)),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: cartItems.isEmpty
                  ? Center(child: Text(t.cartEmpty, style: const TextStyle(fontSize: 18)))
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return _buildCartItem(cartItems[index], index);
                },
              ),
            ),
            if (cartItems.isNotEmpty)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCouponField(t),
                    const SizedBox(height: 12),
                    _buildTotalSection(cartManager.totalAmount, t),
                    const SizedBox(height: 16),
                    _buildCheckoutButton(t),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(item.product.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(item.product.selectedSize ?? 'N/A', style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text('AED ${item.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  cartManager.removeItem(item);
                });
                HapticFeedback.lightImpact();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                child: const Icon(Icons.close, size: 18),
              ),
            ),
          ),
          Positioned(bottom: 0, right: 0, child: _buildQuantitySelector(item)),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (item.quantity > 1) {
                  cartManager.updateQuantity(item, item.quantity - 1);
                  HapticFeedback.lightImpact();
                }
              });
            },
            child: const Icon(Icons.remove, size: 18),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('${item.quantity}',
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                cartManager.updateQuantity(item, item.quantity + 1);
                HapticFeedback.lightImpact();
              });
            },
            child: const Icon(Icons.add, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponField(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: const Icon(Icons.local_offer_outlined),
          hintText: t.addCoupon,
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          if (value.toLowerCase() == 'save10') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.couponApplied)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.invalidCoupon)));
          }
        },
      ),
    );
  }

  Widget _buildTotalSection(double total, AppLocalizations t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(thickness: 1),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(t.total, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('AED ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        Text(t.earnPointsFreeShipping, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }

  Widget _buildCheckoutButton(AppLocalizations t) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: cartManager.items.isEmpty
            ? null
            : () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutPage(cartItems: cartManager.items)),          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          t.proceedToCheckout,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
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