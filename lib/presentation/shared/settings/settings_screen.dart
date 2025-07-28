import 'package:flutter/material.dart';
import '../widgets/white_menu_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE63056);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionTitle("General"),
          WhiteMenuButton(
            iconPath: 'assets/Icons/profile.png',
            text: "Edit profile",
            onTap: () {},
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/notification.png',
            text: "Notification",
            onTap: () {},
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/favorites.png',
            text: "Favourites",
            onTap: () {},
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/language.png',
            text: "Language",
            trailingText: "English",
            onTap: () {},
          ),
          _buildSectionTitle("Performances"),
          WhiteMenuButton(
            iconPath: 'assets/Icons/policy.png',
            text: "Legal and Policies",
            onTap: () {},
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/help.png',
            text: "Help & Support",
            onTap: () {},
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/logout.png',
            text: "Logout",
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {},
          ),
          const SizedBox(height: 28),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
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