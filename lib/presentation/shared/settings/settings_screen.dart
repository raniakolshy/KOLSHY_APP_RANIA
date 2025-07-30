import 'package:flutter/material.dart';
import 'package:kolshy_app/presentation/auth/login/login_screen.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/client/product/favorite_products_screen.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'package:kolshy_app/presentation/shared/settings/help_and_support_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/language_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/legal_and_policies_screen.dart';
import '../widgets/white_menu_button.dart';
import 'package:flutter/material.dart';
import '../widgets/white_menu_button.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE63056);

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

  }

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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/notification.png',
            text: "Notification",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/favorites.png',
            text: "Favourites",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteProductsScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/language.png',
            text: "Language",
            trailingText: "English",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
            },
          ),
          _buildSectionTitle("Performances"),
          WhiteMenuButton(
            iconPath: 'assets/Icons/policy.png',
            text: "Legal and Policies",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalAndPoliciesScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/help.png',
            text: "Help & Support",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpAndSupportScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/logout.png',
            text: "Logout",
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
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
              onTap: () => _onBottomNavTap(index),
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
