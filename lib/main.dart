import 'package:flutter/material.dart';

import 'package:kolshy_app/presentation/client/cart/CheckoutPage.dart';
import 'package:kolshy_app/presentation/client/cart/ShoppingCartPage.dart';
import 'package:kolshy_app/presentation/client/cart/ThankYouPage.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/client/notifications/notification_screen.dart';
import 'package:kolshy_app/presentation/client/product/NewProductDetailPage.dart';
import 'package:kolshy_app/presentation/client/product/favorite_products_screen.dart';
import 'package:kolshy_app/presentation/shared/Search/FilterPage.dart';
import 'package:kolshy_app/presentation/shared/Search/ResultPage.dart';
import 'package:kolshy_app/presentation/shared/Search/SearchPage.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_edit.dart';
import 'package:kolshy_app/presentation/shared/profile/profile_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/help_and_support_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/language_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/legal_and_policies_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';
import 'core/theme/app_theme.dart';
import 'presentation/auth/login/login_screen.dart';
import 'presentation/auth/login/welcome_screen.dart';
import 'presentation/auth/register/register_screen.dart';
import 'presentation/auth/forgot_password/forgot_password.dart';
import 'presentation/auth/forgot_password/verification_code.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), // ou Locale('en') ou null pour utiliser la langue du système
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
      home: RegisterScreen(),
    );

  }
}
