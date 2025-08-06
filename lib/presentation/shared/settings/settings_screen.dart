import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/auth/login/login_screen.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/client/product/favorite_products_screen.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'package:kolshy_app/presentation/shared/settings/MyOrdersScreen.dart';
import 'package:kolshy_app/presentation/shared/settings/help_and_support_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/language_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/legal_and_policies_screen.dart';
import '../../client/Messages/Chat_screen.dart';
import '../widgets/white_menu_button.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/client/cart/OrderDetailsPage.dart';


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
        title:  Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(

        children: [
          _buildSectionTitle(AppLocalizations.of(context)!.general),
          WhiteMenuButton(
            iconPath: 'assets/Icons/profile.png',
            text: AppLocalizations.of(context)!.editProfile,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/notification.png',
            text: AppLocalizations.of(context)!.notification,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/favorites.png',
            text: AppLocalizations.of(context)!.favourites,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteProductsScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/reciept.png',
            text: AppLocalizations.of(context)!.myOrders,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/language.png',
            text: AppLocalizations.of(context)!.language,
            trailingText: AppLocalizations.of(context)!.trailLanguage,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
            },
          ),
          _buildSectionTitle(AppLocalizations.of(context)!.performances),
          WhiteMenuButton(
            iconPath: 'assets/Icons/policy.png',
            text: AppLocalizations.of(context)!.legalAndPolicies,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalAndPoliciesScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/help.png',
            text: AppLocalizations.of(context)!.helpSupport,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpAndSupportScreen()));
            },
          ),
          WhiteMenuButton(
            iconPath: 'assets/Icons/logout.png',
            text: AppLocalizations.of(context)!.logout,
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