import 'package:flutter/material.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'Thankyoupage.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPayment = 0;
  int _selectedIndex = 1;
  final Color primaryColor = const Color(0xFFE63056);

  String _selectedAddress = 'Home';

  final Map<String, String> _addressMap = {
    'Home': '742 Evergreen Terrace, Springfield',
    'Work': '356 Maple Street, Apartment 28, NY 100111',
    'Other': 'Custom address goes here...',
  };

  final List<String> _addressOptions = ['Home', 'Work', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildSectionTitle("Shipping Information", action: "Edit"),
              const SizedBox(height: 12),
              _buildAddressSelector(),
              const SizedBox(height: 12),
              _buildAddressCard(),
              const SizedBox(height: 32),
              _buildSectionTitle("Payment Method", action: "Add a card"),
              const SizedBox(height: 16),
              _buildPaymentOption(0, 'Apple Pay', 'assets/checkout/apple_pay.png'),
              const SizedBox(height: 12),
              _buildPaymentOption(1, 'PayPal', 'assets/checkout/paypal.png'),
              const SizedBox(height: 32),
              _buildInfoText(),
              const SizedBox(height: 32),
              _buildPlaceOrderButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, size: 28),
        ),
        const SizedBox(width: 12),
        const Text(
          "Checkout",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, {required String action}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            );
          },
          child: Text(
            action,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSelector() {
    return Row(
      children: _addressOptions.map((type) {
        final isSelected = _selectedAddress == type;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => _selectedAddress = type),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
              color: Color(0x11000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _addressMap[_selectedAddress]!,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(int index, String title, String assetPath) {
    bool isSelected = _selectedPayment == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F000000), blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 40, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey.shade400,
                    width: 2),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                ),
              )
                  : null,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText() {
    return const Text(
      "By placing your order, you agree to our terms and privacy policy. You’ll receive an email confirmation shortly after checkout.",
      style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5),
    );
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThankYouPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          "Place Order",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
        color: Colors.white,
      ),
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
    );
  }
}
