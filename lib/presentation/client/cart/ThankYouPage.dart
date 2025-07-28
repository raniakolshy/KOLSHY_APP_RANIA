import 'package:flutter/material.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  int _selectedIndex = 1;
  final Color primaryColor = const Color(0xFFE63056);
  final Color successColor = const Color(0xFF34A853);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildSuccessIcon(),
              const SizedBox(height: 24),
              const Text(
                "Thank you for\nshopping with us!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E8E3E),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your order number 16 is confirmed\nand in processing",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Porem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Nunc vulputate libero et velit interdum, ac aliquet odio mattis. "
                    "Class aptent taciti sociosqu ad litora torquent per conubia nostra, "
                    "per inceptos himenaeos.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 36),
              _buildOutlinedButton(),
              const SizedBox(height: 16),
              _buildFilledButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: successColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle_rounded,
        size: 80,
        color: successColor,
      ),
    );
  }

  Widget _buildOutlinedButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          // Navigate to order details
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          "Order Details",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildFilledButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to home or previous screen
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Done",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
      elevation: 0,
      items: List.generate(iconNames.length, (index) {
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
    );
  }
}