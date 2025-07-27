import 'package:flutter/material.dart';
import '../widgets/white_menu_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF0F0F0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                )
              ],
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text("General",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          WhiteMenuButton(
            icon: Icons.person_outline,
            text: "Edit profile",
            onTap: () {},
          ),
          WhiteMenuButton(
            icon: Icons.notifications_none,
            text: "Notification",
            onTap: () {},
          ),
          WhiteMenuButton(
            icon: Icons.favorite_border,
            text: "Favourites",
            onTap: () {},
          ),
          WhiteMenuButton(
            icon: Icons.language,
            text: "Language",
            trailingText: "English",
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Text("Performances",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          WhiteMenuButton(
            icon: Icons.gavel_outlined,
            text: "Legal and Policies",
            onTap: () {},
          ),
          WhiteMenuButton(
            icon: Icons.help_outline,
            text: "Help & Support",
            onTap: () {},
          ),
          WhiteMenuButton(
            icon: Icons.logout,
            text: "Logout",
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
