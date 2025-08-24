// lib/presentation/vendor/View_profile.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

/// Simple vendor model (kept for reuse from product page)
class Vendor {
  final String id;
  final String name;       // e.g. "Aliana"
  final String shopName;   // e.g. "Aliana Shop"
  final String? avatarUrl; // asset or network (optional)
  final double rating;
  final int productsCount;
  final int followers;

  const Vendor({
    required this.id,
    required this.name,
    required this.shopName,
    this.avatarUrl,
    this.rating = 4.6,
    this.productsCount = 0,
    this.followers = 0,
  });
}

/// EXACT design as your 2nd code (banner + cards + grid + button)
class VendorProfileScreen extends StatefulWidget {
  final Vendor vendor;

  const VendorProfileScreen({super.key, required this.vendor});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  // Static (non-localized) base data. Localized strings are read in build().
  late final Map<String, dynamic> _vendorData = {
    'companyName': widget.vendor.shopName,
    'logoUrl': widget.vendor.avatarUrl ?? 'assets/logo.jpg',
    'bannerUrl': 'assets/welcome_background.jpeg',
    'socialMedia': {
      'twitter': 'gadgets_gear',
      'instagram': 'gadgets_gear_official',
      'youtube': 'GadgetsAndGear',
    },
    // category values are ids; we translate them in build()
    'products': [
      {'name': 'Wireless Headphones', 'price': 'AED 129.99', 'category': 'electronics', 'imageUrl': 'assets/img_square.jpg'},
      {'name': 'Smartwatch',          'price': 'AED 249.00', 'category': 'electronics', 'imageUrl': 'assets/img_square.jpg'},
      {'name': 'Portable Power Bank', 'price': 'AED 45.50',  'category': 'accessories','imageUrl': 'assets/img_square.jpg'},
      {'name': 'Action Camera',       'price': 'AED 399.99', 'category': 'electronics', 'imageUrl': 'assets/img_square.jpg'},
      {'name': 'Bluetooth Speaker',   'price': 'AED 89.95',  'category': 'electronics', 'imageUrl': 'assets/img_square.jpg'},
      {'name': 'Drone',               'price': 'AED 550.00', 'category': 'electronics', 'imageUrl': 'assets/img_square.jpg'},
    ],
  };

  IconData _getSocialMediaIcon(String id) {
    switch (id) {
      case 'twitter':   return FontAwesomeIcons.twitter;
      case 'facebook':  return FontAwesomeIcons.facebook;
      case 'instagram': return FontAwesomeIcons.instagram;
      case 'youtube':   return FontAwesomeIcons.youtube;
      case 'pinterest': return FontAwesomeIcons.pinterest;
      case 'tiktok':    return FontAwesomeIcons.tiktok;
      default:          return Icons.link;
    }
  }

  String _trCategory(String id, AppLocalizations loc) {
    switch (id) {
      case 'electronics': return loc.categoryElectronics;
      case 'accessories': return loc.categoryAccessories;
      default:            return id; // fallback
    }
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // <-- localization instance

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(image: AssetImage(_vendorData['bannerUrl']), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Profile header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo (circle)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black.withOpacity(0.1)),
                          image: DecorationImage(image: _resolveImageProvider(_vendorData['logoUrl']), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Vendor info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_vendorData['companyName'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(loc.vendorLocation, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Social media icons
                            Wrap(
                              spacing: 8.0,
                              children: (_vendorData['socialMedia'] as Map<String, String>).entries.map<Widget>((entry) {
                                return IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(_getSocialMediaIcon(entry.key), color: Colors.black87),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // About (localized)
                  _sectionCard(title: loc.vendorAboutTitle, children: [
                    Text(loc.vendorBio),
                  ]),

                  // Products grid (categories localized)
                  _sectionCard(title: loc.vendorProductsTitle, children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.7, mainAxisSpacing: 16, crossAxisSpacing: 16,
                      ),
                      itemCount: (_vendorData['products'] as List).length,
                      itemBuilder: (context, index) {
                        final raw = Map<String, String>.from(_vendorData['products'][index]);
                        final localized = {
                          ...raw,
                          'category': _trCategory(raw['category']!, loc),
                        };
                        return _buildProductCard(localized);
                      },
                    ),
                  ]),

                  // Bottom button (localized)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      label: Text(loc.vendorEditProfile, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Product card
  Widget _buildProductCard(Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(product['imageUrl']!, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(product['category']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(product['price']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to support both asset and network images for the logo
  ImageProvider _resolveImageProvider(String pathOrUrl) {
    if (pathOrUrl.startsWith('http') || pathOrUrl.startsWith('https')) return NetworkImage(pathOrUrl);
    return AssetImage(pathOrUrl);
  }
}
