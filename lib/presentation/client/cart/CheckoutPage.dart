import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'package:kolshy_app/presentation/client/cart/ThankYouPage.dart';
import '../../shared/Search/SearchPage.dart';
import '../../shared/home/home_screen.dart';
import '../../shared/settings/Settings_screen.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../Messages/Chat_screen.dart';
import '../notifications/notification_screen.dart';
import 'ShoppingCartPage.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedIndex = 1;
  final Color primaryColor = const Color(0xFFE51742);

  String userName = "John Doe";
  String userEmail = "johndoe@example.com";
  String userPhone = "+1 234 567 8901";
  String userAddress = "123 Main Street, Cityville";
  String paymentMethod = "Visa *** 1234";

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
          },
        ),
        title: Text(
          t.checkoutTitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDetailsContainer(t),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              _buildPlaceOrderButton(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(AppLocalizations t) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.orderDetails,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                ),
                child: Text(
                  t.editDetails,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailItem(
              Icons.person_outline, t.personalInfo, [userName, userEmail, userPhone]),
          const Divider(height: 32, color: Colors.black12),
          _buildDetailItem(
              Icons.location_on_outlined, t.shippingAddress, [userAddress]),
          const Divider(height: 32, color: Colors.black12),
          _buildDetailItem(
              Icons.credit_card, t.paymentMethod, [paymentMethod]),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, List<String> details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black54, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              const SizedBox(height: 4),
              ...details.map((line) => Text(
                line,
                style:
                const TextStyle(fontSize: 15, color: Colors.black54),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceOrderButton(AppLocalizations t) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => ThankYouPage(cartItems: widget.cartItems)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          shadowColor: primaryColor.withOpacity(0.5),
        ),
        child: Text(
          t.placeOrder,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
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