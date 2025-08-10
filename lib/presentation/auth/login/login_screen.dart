import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

import 'package:kolshy_app/presentation/auth/forgot_password/forgot_password.dart';
import 'package:kolshy_app/presentation/auth/register/register_screen.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

const Color primaryPink = Color(0xFFE51742);
const Color inputFill = Color(0xFFF4F4F4);
const Color lightBorder = Color(0xFFDDDDDD);
const Color greyText = Color(0xFF777777);

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '524516881115-erpl9ot3g239d893kctb06o9dnb16v11.apps.googleusercontent.com',
  serverClientId: '524516881115-erpl9ot3g239d893kctb06o9dnb16v11.apps.googleusercontent.com',
  scopes: [
    'email',
  ],
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onLoginPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      _showMessage('Username or email is required');
      return;
    }

    if (password.length < 8 || !RegExp(r'\d').hasMatch(password)) {
      _showMessage('Password must be 8+ characters and contain a number');
      return;
    }

    _showMessage('Attempting login with username: $username');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> _signInWithGoogle() async {
    _showMessage('Initiating Google Sign-In...');
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _showMessage('Google Sign-In cancelled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('Google ID Token: ${googleAuth.idToken}');
      print('Google Access Token: ${googleAuth.accessToken}');

      final response = await http.post(
        Uri.parse('https://kolshy.ae/sociallogin/social/callback/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'provider': 'google',
          'idToken': googleAuth.idToken!,
          'accessToken': googleAuth.accessToken ?? '',
          'email': googleUser.email,
          'displayName': googleUser.displayName ?? '',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _showMessage('Google Sign-In successful with backend: ${responseData['message']}');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        _showMessage('Backend authentication failed: ${response.body}');
        print('Backend error: ${response.body}');
      }

    } catch (e) {
      _showMessage('Google Sign-In failed: ${e.toString()}');
      print('Google Sign-In error: $e');
    }
  }

  Future<void> _signInWithFacebook() async {
    _showMessage('Initiating Facebook Sign-In...');
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        print('Facebook Access Token: ${accessToken.token}');
        print('Facebook User ID: ${accessToken.userId}');

        final response = await http.post(
          Uri.parse('https://kolshy.ae/sociallogin/social/callback/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'provider': 'facebook',
            'accessToken': accessToken.token,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          _showMessage('Facebook Sign-In successful with backend: ${responseData['message']}');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          _showMessage('Backend authentication failed: ${response.body}');
          print('Backend error: ${response.body}');
        }

      } else if (result.status == LoginStatus.cancelled) {
        _showMessage('Facebook Sign-In cancelled.');
      } else {
        _showMessage('Facebook Sign-In failed: ${result.message}');
        print('Facebook Sign-In error: ${result.message}');
      }
    } catch (e) {
      _showMessage('Facebook Sign-In failed: ${e.toString()}');
      print('Facebook Sign-In error: $e');
    }
  }

  // New function for Instagram Login
  Future<void> _signInWithInstagram() async {
    _showMessage('Initiating Instagram Sign-In...');
    try {
      const String instagramAppId = '642270335021538';
      const String redirectUri = 'https://kolshy.ae/sociallogin/social/callback/instagram.php';
      const String authorizationUrl = 'https://api.instagram.com/oauth/authorize'
          '?client_id=$instagramAppId'
          '&redirect_uri=$redirectUri'
          '&scope=user_profile,user_media'
          '&response_type=code';

      final result = await FlutterWebAuth2.authenticate(
        url: authorizationUrl,
        callbackUrlScheme: "https", // Note: This needs to be a scheme that your app can handle
      );

      // The result contains the redirected URL with the authorization code
      final uri = Uri.parse(result);
      final String? code = uri.queryParameters['code'];
      final String? error = uri.queryParameters['error'];

      if (code != null) {
        _showMessage('Instagram authorization successful. Sending code to backend.');
        print('Instagram Authorization Code: $code');

        // TODO: The next step is to send the authorization code to your backend.
        // Your backend will then exchange this code for an access token using your App Secret.
        // The App Secret should NEVER be in your mobile app code.
        final response = await http.post(
          Uri.parse('https://kolshy.ae/sociallogin/social/callback/instagram.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'provider': 'instagram',
            'code': code,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          _showMessage('Instagram Sign-In successful with backend: ${responseData['message']}');
          // TODO: Store your backend's session token and navigate
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          _showMessage('Backend authentication failed: ${response.body}');
          print('Backend error: ${response.body}');
        }
      } else if (error != null) {
        _showMessage('Instagram Sign-In failed: ${uri.queryParameters['error_description']}');
        print('Instagram error: ${uri.queryParameters['error_description']}');
      } else {
        _showMessage('Instagram Sign-In cancelled.');
      }
    } catch (e) {
      _showMessage('Instagram Sign-In failed: ${e.toString()}');
      print('Instagram Sign-In error: $e');
    }
  }


  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: primaryPink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.welcomeBack,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 36),

        _CustomInput(
          controller: _usernameController,
          hintText: AppLocalizations.of(context)!.usernameOrEmail,
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 20),

        _CustomInput(
          controller: _passwordController,
          hintText: AppLocalizations.of(context)!.password,
          icon: Icons.lock_outline,
          isPassword: true,
          obscureText: _obscurePassword,
          toggleVisibility: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),

        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: primaryPink,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppLocalizations.of(context)!.forgotPwd,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPink,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 40),

        Row(
          children: [
            const Expanded(child: Divider(color: lightBorder)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(AppLocalizations.of(context)!.continueWith, style: const TextStyle(color: greyText, fontSize: 14)),
            ),
            const Expanded(child: Divider(color: lightBorder)),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Button
            SocialButton(
              icon: 'assets/google.png',
              onTap: _signInWithGoogle,
            ),
            const SizedBox(width: 20),
            // Instagram Button (replaces Apple)
            SocialButton(
              icon: 'assets/instagram.png', // You need to add this asset
              onTap: _signInWithInstagram,
            ),
            const SizedBox(width: 20),
            // Facebook Button
            SocialButton(
              icon: 'assets/facebook.png',
              onTap: _signInWithFacebook,
            ),
          ],
        ),
        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.createAnAccountLogin, style: const TextStyle(color: greyText, fontSize: 14)),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text(
                  AppLocalizations.of(context)!.signUp,
                  style: TextStyle(color: primaryPink, fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _CustomInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;

  const _CustomInput({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: inputFill,
        hintText: hintText,
        hintStyle: const TextStyle(color: greyText, fontSize: 16),
        prefixIcon: Icon(icon, color: greyText),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: greyText),
          onPressed: toggleVisibility,
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPink, width: 2),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;

  const SocialButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryPink, width: 1.5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(icon, fit: BoxFit.contain),
      ),
    );
  }
}