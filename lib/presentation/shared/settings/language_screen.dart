import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/providers/locale_provider.dart';

import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';

import '../../client/Messages/Chat_screen.dart';
// import '../../client/notifications/notification_screen.dart';
import '../home/home_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String selectedLanguage;
  final TextEditingController _searchController = TextEditingController();
  late int _selectedIndex = 4;
  final Color primaryColor = const Color(0xFFE51742);

  @override
  void initState() {
    super.initState();
    final currentLocale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    selectedLanguage = currentLocale == 'ar' ? 'arabic' : 'english';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Liste de langues avec labels localisés
    final allLanguages = [
      _LangItem(label: localizations.english, value: 'english', flag: '🇬🇧'),
      _LangItem(label: localizations.arabic, value: 'arabic', flag: '🇸🇦'),
    ];

    // Filtre
    final query = _searchController.text.trim().toLowerCase();
    final filtered = allLanguages.where((item) {
      if (query.isEmpty) return true;
      final haystack = '${item.label} ${item.value}'.toLowerCase();
      return haystack.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        title: Text(
          localizations.language,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
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
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (_) => setState(() {}), // met à jour la liste
                      decoration: InputDecoration(
                        hintText: localizations.search,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () {
                      _searchController.clear();
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),

          // Liste filtrée ou message "aucun résultat"
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _noResultsText(context), // <<< plus d'accès à une clé inexistante
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ...filtered.map(
                  (item) => _buildLanguageTile(item.label, item.value, item.flag),
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

  Widget _buildLanguageTile(String label, String value, String flagEmoji) {
    final isSelected = selectedLanguage == value;

    return GestureDetector(
      onTap: () {
        setState(() => selectedLanguage = value);

        final provider = Provider.of<LocaleProvider>(context, listen: false);
        final newLocale = value == 'arabic' ? const Locale('ar') : const Locale('en');
        provider.setLocale(newLocale);
      },
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
                label,
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

  // Texte "aucun résultat" selon la langue courante
  String _noResultsText(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode;
    switch (code) {
      case 'ar':
        return 'لا توجد نتائج';
      case 'fr':
        return 'Aucun résultat';
      default:
        return 'No results';
    }
  }
}

// Petit type interne pour garder le code propre
class _LangItem {
  final String label;
  final String value;
  final String flag;
  const _LangItem({required this.label, required this.value, required this.flag});
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
