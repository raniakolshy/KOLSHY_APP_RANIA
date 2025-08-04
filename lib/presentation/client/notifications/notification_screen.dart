import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/shared/widgets/bottom_nav_bar.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';

import '../Messages/Chat_screen.dart';
import '../product/NewProductDetailPage.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 0;

  final List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];

  late List<NotificationItemData> todayNotifications;
  late List<NotificationItemData> yesterdayNotifications;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Localized strings should be used here instead of initState
    todayNotifications = [
      NotificationItemData(
        Icons.local_shipping,
        AppLocalizations.of(context)!.purchaseCompleted,
        AppLocalizations.of(context)!.minago,
      ),
      NotificationItemData(
        Icons.inventory_2,
        AppLocalizations.of(context)!.orderPacked,
        AppLocalizations.of(context)!.minago,
      ),
    ];

    yesterdayNotifications = [
      NotificationItemData(
        Icons.percent,
        AppLocalizations.of(context)!.discountApplied,
        AppLocalizations.of(context)!.yesterday,
      ),
      NotificationItemData(
        Icons.notifications,
        AppLocalizations.of(context)!.newFeatureUpdate,
        AppLocalizations.of(context)!.yesterday,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
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
          AppLocalizations.of(context)!.notification,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        children: [
          if (todayNotifications.isNotEmpty)
            SectionHeader(title: AppLocalizations.of(context)!.today),
          ...todayNotifications.map((n) => _buildDismissibleNotification(n, true)),

          if (yesterdayNotifications.isNotEmpty) ...[
            const SizedBox(height: 24),
            SectionHeader(title: AppLocalizations.of(context)!.yesterday),
            ...yesterdayNotifications.map((n) => _buildDismissibleNotification(n, false)),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3,
        onItemTapped: (index) {
          if (index != 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => getScreenForTab(index)),
            );
          }
        },
      ),
    );
  }

  Widget _buildDismissibleNotification(NotificationItemData data, bool isToday) {
    return Dismissible(
      key: ValueKey('${data.title}-${data.time}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() {
          if (isToday) {
            todayNotifications.remove(data);
          } else {
            yesterdayNotifications.remove(data);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data.title} dismissed')),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: NotificationCard(data: data),
    );
  }
}

class NotificationItemData {
  final IconData icon;
  final String title;
  final String time;

  const NotificationItemData(this.icon, this.title, this.time);
}

class NotificationCard extends StatelessWidget {
  final NotificationItemData data;

  const NotificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, size: 26, color: Colors.black87),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero.',
                  style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 6),
                Text(
                  data.time,
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
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
