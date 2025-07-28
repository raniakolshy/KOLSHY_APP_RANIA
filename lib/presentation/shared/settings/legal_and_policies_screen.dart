import 'package:flutter/material.dart';

class LegalAndPoliciesScreen extends StatefulWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  State<LegalAndPoliciesScreen> createState() => _LegalAndPoliciesScreenState();
}

class _LegalAndPoliciesScreenState extends State<LegalAndPoliciesScreen> {
  final int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE51742);
  final Color tabInactiveColor = const Color(0xFFF3F3F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Row(
            children: [
              _buildTabButton("HUMAN-FRIENDLY", true),
              const SizedBox(width: 10),
              _buildTabButton("LEGAL MUMBO-JUMBO", false),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Our human-friendly Terms of Service for the platform prevails over the detailed one, which specifies all rights and obligations in more complex legalese.\n\nIn case of contradiction between the two documents, the human-friendly Terms shall prevail. That means no nasty surprises if you read only the human-friendly version.',
              style: TextStyle(fontSize: 15.5, height: 1.6, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Last updated: June 24, 2020",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : tabInactiveColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black54,
              letterSpacing: 0.5,
            ),
          ),
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
              onTap: () => setState(() {}),
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