import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedPayment = 0;
  int _selectedIndex = 1;
  final Color primaryColor = const Color(0xFFE63056);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildShippingInfo(),
              const SizedBox(height: 24),
              _buildPaymentMethod(),
              const SizedBox(height: 20),
              _buildInfoText(),
              const SizedBox(height: 24),
              _buildPlaceOrderButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: const [
        Icon(Icons.arrow_back, size: 28),
        SizedBox(width: 12),
        Text(
          "Checkout",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildShippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Shipping Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text("Edit", style: TextStyle(color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Work", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("356 Maple Street, Apartment 28,\nno where, 100111",
                        style: TextStyle(height: 1.4)),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Payment method",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text("Add a card", style: TextStyle(color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 14),
        _buildPaymentOption(0, 'Apple Pay', Icons.phone_iphone), // ✅ Replaced asset path with IconData
        const SizedBox(height: 12),
        _buildPaymentOption(1, 'Pay Pal', Icons.account_balance_wallet), // ✅ Replaced asset path
      ],
    );
  }

  Widget _buildPaymentOption(int index, String title, IconData icon) {
    bool isSelected = _selectedPayment == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey.shade400,
                    width: 2),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
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
      "Porem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
      style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5),
    );
  }

  Widget _buildPlaceOrderButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          "Place order",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
            icon: Column(
              children: [
                Container(
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
              ],
            ),
            label: name,
          );
        }),
      ),
    );
  }
}