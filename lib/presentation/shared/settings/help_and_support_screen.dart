import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import '../../client/Messages/Chat_screen.dart';
import '../home/home_screen.dart';
import 'Settings_screen.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late int _selectedIndex = 4;

  // Couple (clé de topic, url vidéo) — dernier retiré.
  final List<_HelpItem> _items = const [
    _HelpItem('helpTopic0', 'https://www.youtube.com/watch?v=ObdRKJRYtfE'),
    _HelpItem('helpTopic1', 'https://www.youtube.com/watch?v=_L71pFhPZ0M'),
    _HelpItem('helpTopic2', 'https://www.youtube.com/watch?v=ti_e1mtU5VA&t=5s'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Impossible d’ouvrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // Filtrage sur le libellé localisé
    final String q = _searchController.text.trim().toLowerCase();
    final List<_HelpItem> filtered = _items.where((it) {
      final label = localizations.getHelpTopic(it.key).toLowerCase();
      return q.isEmpty || label.contains(q);
    }).toList(growable: false);

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
          localizations.helpAndSupport,
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: localizations.searchTopics,
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF4F5F7),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                ...filtered.map((item) {
                  final String youtubeId = _getYoutubeId(item.videoUrl);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Material(
                        color: const Color(0xFFF9FAFB),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            collapsedIconColor: Colors.black,
                            iconColor: Colors.black,
                            title: Text(
                              localizations.getHelpTopic(item.key),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            children: [
                              // Miniature officielle YouTube de la vidéo
                              GestureDetector(
                                onTap: () => _launchURL(item.videoUrl),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image.network(
                                        'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.network(
                                            'https://img.youtube.com/vi/$youtubeId/0.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),

                // Bloc Contact
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.howtocontactus,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("West Burry Tower - 21rd Floor - Office No. 13"),
                      Text("Opposite to Opal Tower - Business Bay"),
                      Text("Dubai, UAE"),
                      SizedBox(height: 8),
                      Text("📞 +971551228825"),
                      Text("✉ info@kolshy.ae"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          // Toujours naviguer vers Settings si l’utilisateur tape l’icône Settings
          if (index == 4) {
            setState(() => _selectedIndex = 4);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
            return;
          }
          // Autres onglets : navigation normale
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

  String _getYoutubeId(String url) {
    final uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    } else if (uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return '';
  }
}

class _HelpItem {
  final String key;
  final String videoUrl;
  const _HelpItem(this.key, this.videoUrl);
}

extension HelpTopicExtension on AppLocalizations {
  String getHelpTopic(String key) {
    return {
      'helpTopic0': helpTopic0,
      'helpTopic1': helpTopic1,
      'helpTopic2': helpTopic2,
      // helpTopic3 supprimé
    }[key] ?? key;
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
