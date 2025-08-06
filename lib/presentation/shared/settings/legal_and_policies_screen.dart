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

  // New state variable to control which policy text is shown
  bool _showHumanFriendlyPolicy = true; // true for 'Human-Friendly', false for 'Legal Mumbo Jumbo'

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
              // Human-Friendly button
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
              // Legal Mumbo Jumbo button
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
              // Display content based on the selected policy
              _showHumanFriendlyPolicy
                  ? "This is the human-friendly summary of our privacy policy. We collect minimal data, protect it fiercely, and never share it without your explicit consent. Your privacy is our priority. For more details, see the 'Legal Mumbo Jumbo' version." // TODO: Replace with localizations.humanFriendlyPolicyText
                  : "Welcome to the labyrinthine legal document that is our Privacy Policy. This verbose tome outlines, in excruciating detail, the exhaustive methodologies by which we, the proprietors of this digital service, collect, process, store, and occasionally, with due diligence and adherence to all applicable statutes and regulations, utilize your personally identifiable information. Be advised that by continuing your engagement with this platform, you implicitly, unequivocally, and irrevocably consent to the entirety of the stipulations herein enumerated. Proceed with caution, for the legal ramifications of non-compliance are, whilst not explicitly punitive in nature, implicitly binding upon your digital persona. Enjoy the read!", // TODO: Replace with localizations.legalMumboJumboPolicyText
              style: const TextStyle(fontSize: 15.5, height: 1.6, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${localizations.lastUpdated}: June 24, 2020',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
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

  // Modified _buildTabButton to accept an onTap callback
  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap, // Added onTap callback
  }) {
    return Expanded(
      child: GestureDetector( // GestureDetector makes the Container tappable
        onTap: onTap, // Assign the onTap callback here
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