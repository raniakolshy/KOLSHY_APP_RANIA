import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/client/cart/cart_manager.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/client/cart/CheckoutPage.dart';

class OrderDetailsPage extends StatefulWidget {
  final List<CartItem> items;

  const OrderDetailsPage({super.key, required this.items});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int _selectedIndex = 1;
  final Color primaryColor = const Color(0xFFE63056);

  final String orderNumber = 'KS-123456';
  final String orderDate = '2024-08-07';
  final String orderStatus = 'In Progress';
  final String customerName = 'John Doe';
  final String customerEmail = 'johndoe@example.com';
  final String shippingAddress = '123 Main Street, Cityville, 54321';
  final String paymentMethod = 'Visa *** 1234';

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var item in widget.items) {
      subtotal += item.quantity * item.product.price;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final subtotal = calculateSubtotal();
    const shipping = 0.0;
    final total = subtotal + shipping;

    return Scaffold(
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
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.orderDetails,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(localizations.orderSummary),
            _buildSummaryRow(localizations.orderNumber, orderNumber),
            _buildSummaryRow(localizations.orderDate, orderDate),
            _buildSummaryRow(localizations.orderStatus, orderStatus),
            const SizedBox(height: 24),
            _buildSectionTitle(localizations.customerInfo),
            const SizedBox(height: 8),
            _buildCustomerInfoCard(name: customerName, email: customerEmail),
            const SizedBox(height: 24),
            _buildSectionTitle(localizations.items),
            ...widget.items.map((item) => _buildItemCard(
              name: item.product.name,
              type: item.product.selectedSize ?? 'N/A',
              quantity: item.quantity,
              price: item.product.price,
              imagePath: item.product.imageUrl,
            )),
            const SizedBox(height: 24),
            _buildSectionTitle(localizations.shippingAddress),
            const SizedBox(height: 8),
            _buildAddressCard(shippingAddress),
            const SizedBox(height: 24),
            _buildSectionTitle(localizations.paymentMethod),
            const SizedBox(height: 8),
            _buildPaymentMethodRow(paymentMethod),
            const SizedBox(height: 24),
            _buildSectionTitle(localizations.orderTotal),
            const SizedBox(height: 8),
            _buildTotalBreakdown(localizations, subtotal, shipping, total),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCustomerInfoCard({required String name, required String email}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(email,
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard({
    required String name,
    required String type,
    required int quantity,
    required double price,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(type, style: const TextStyle(color: Colors.black54)),
                Text('Qty: $quantity'),
              ],
            ),
          ),
          Text('AED ${price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildAddressCard(String address) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Text(address, style: const TextStyle(fontSize: 14, height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodRow(String method) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.payment_outlined),
          const SizedBox(width: 12),
          Text(method, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTotalBreakdown(
      AppLocalizations localizations, double subtotal, double shipping, double total) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          _TotalRow(
            label: localizations.subtotal,
            value: 'AED ${subtotal.toStringAsFixed(2)}',
          ),
          _TotalRow(
            label: localizations.shipping,
            value: shipping == 0.0
                ? localizations.free
                : 'AED ${shipping.toStringAsFixed(2)}',
          ),
          const Divider(),
          _TotalRow(
            label: localizations.total,
            value: 'AED ${total.toStringAsFixed(2)}',
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _TotalRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
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