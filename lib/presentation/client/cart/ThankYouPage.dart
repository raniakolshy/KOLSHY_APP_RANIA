import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/data/models/cart_item_model.dart';
import 'package:kolshy_app/data/models/order_model.dart';
import 'package:provider/provider.dart';
import '../../shared/home/home_screen.dart';
import '../cart/OrderDetailsPage.dart';
import 'package:kolshy_app/presentation/client/cart/orders_manager.dart';

class ThankYouPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const ThankYouPage({super.key, required this.cartItems});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  final Color primaryColor = const Color(0xFFE63056);
  final Color successColor = const Color(0xFF34A853);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildSuccessIcon(),
              const SizedBox(height: 24),
              Text(
                localizations.thankYouTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E8E3E),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                localizations.thankYouSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                localizations.thankYouDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 36),
              _buildOutlinedButton(localizations),
              const SizedBox(height: 16),
              _buildFilledButton(localizations),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: successColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle_rounded,
        size: 80,
        color: successColor,
      ),
    );
  }

  Widget _buildOutlinedButton(AppLocalizations localizations) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsPage(items: widget.cartItems)),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          localizations.orderDetails,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildFilledButton(AppLocalizations localizations) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // L'ajout de la commande a été supprimé ici pour éviter les doublons.
          // Cette logique doit se trouver sur la page "Place Order".

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          localizations.done,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}