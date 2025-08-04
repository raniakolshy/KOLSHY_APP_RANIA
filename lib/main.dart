import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:kolshy_app/core/theme/app_theme.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/auth/forgot_password/forgot_password.dart';
import 'package:kolshy_app/presentation/auth/forgot_password/verification_code.dart';
import 'package:kolshy_app/presentation/auth/login/login_screen.dart';
import 'package:kolshy_app/presentation/auth/login/welcome_screen.dart';
import 'package:kolshy_app/presentation/client/Messages/Chat_screen.dart';
import 'package:kolshy_app/presentation/client/cart/CheckoutPage.dart';
import 'package:kolshy_app/presentation/client/cart/OrderDetailsPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/client/cart/ThankYouPage.dart';
import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/client/product/NewProductDetailPage.dart';
import 'package:kolshy_app/presentation/client/product/favorite_products_screen.dart';
import 'package:kolshy_app/presentation/shared/Search/FilterPage.dart';
import 'package:kolshy_app/presentation/shared/Search/ResultPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'package:kolshy_app/presentation/shared/settings/help_and_support_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/language_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/legal_and_policies_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('ar'); // par défaut anglais

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kolshy App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/verify-code': (context) => const VerificationCodeScreen(),
        '/cart': (context) => const ShoppingCartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/thankyou': (context) => const ThankYouPage(),
        '/notifications': (context) => const NotificationScreen(),
        '/product-detail': (context) => const NewProductDetailPage(),
        '/favorites': (context) => const FavoriteProductsScreen(),
        '/search': (context) => const SearchPage(),
        '/filter': (context) => const FilterScreen(),
        '/results': (context) => const SearchResultPage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/change-password': (context) => const ChangePasswordPage(),
        '/settings': (context) => const SettingsScreen(),
        '/language': (context) => const LanguageScreen(),
        '/legal': (context) => const LegalAndPoliciesScreen(),
        '/help': (context) => const HelpAndSupportScreen(),
        '/orderdetails': (context) => const OrderDetailsPage(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
