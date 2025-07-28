import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';
  final TextEditingController _searchController = TextEditingController();
  final int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE51742);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Language', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(Icons.search, color: Colors.black54),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildLanguageTile('English', '🇬🇧'),
          _buildLanguageTile('Arabic', '🇸🇦'),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildLanguageTile(String language, String flagEmoji) {
    final isSelected = selectedLanguage == language;

    return GestureDetector(
      onTap: () => setState(() => selectedLanguage = language),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                language,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? primaryColor : Colors.grey,
            ),
          ],
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