import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import '../../client/Messages/Chat_screen.dart';
import '../../client/notifications/notification_screen.dart';
import '../home/home_screen.dart';
import 'Settings_screen.dart';

class LegalAndPoliciesScreen extends StatefulWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  State<LegalAndPoliciesScreen> createState() => _LegalAndPoliciesScreenState();
}

class _LegalAndPoliciesScreenState extends State<LegalAndPoliciesScreen> {
  late int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE51742);
  final Color tabInactiveColor = const Color(0xFFF3F3F3);

  bool _showHumanFriendlyPolicy = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          localizations.privacyPolicy,
          style: const TextStyle(
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
              _buildTabButton(
                text: localizations.humanFriendly,
                isSelected: _showHumanFriendlyPolicy,
                onTap: () {
                  setState(() {
                    _showHumanFriendlyPolicy = true;
                  });
                },
              ),
              const SizedBox(width: 10),
              _buildTabButton(
                text: localizations.legalMumboJumbo,
                isSelected: !_showHumanFriendlyPolicy,
                onTap: () {
                  setState(() {
                    _showHumanFriendlyPolicy = false;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _showHumanFriendlyPolicy
                  ? AppLocalizations.of(context)!.humanFriendlyPolicyText
                  : AppLocalizations.of(context)!.legalMumboJumboPolicyText,
              style: const TextStyle(fontSize: 15.5, height: 1.6, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${localizations.lastUpdated}: 10/08/2025',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          // Navigation forcée vers Settings si index == 4
          if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
            return;
          }
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

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
