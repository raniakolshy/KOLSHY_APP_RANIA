import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';

// ✅ Ensure these imports are real paths in your app!
import 'package:kolshy_app/presentation/auth/forgot_password/forgot_password.dart';
import 'package:kolshy_app/presentation/auth/register/register_screen.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart';

// ℹ️ Add these dependencies to your pubspec.yaml:
// dependencies:
//   google_sign_in: ^6.1.0 # For Google Sign-In
//   flutter_facebook_auth: ^6.1.0 # For Facebook Login
//   sign_in_with_apple: ^6.0.0 # For Apple Sign-In
//   http: ^1.1.0 # For making HTTP requests to your backend

// ℹ️ Uncomment these imports once you've added the packages to pubspec.yaml
import 'package:google_sign_in/google_sign_in.dart'; // Uncomment this
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:http/http.dart' as http; // Uncomment this for backend calls
// import 'dart:convert'; // Uncomment this for JSON encoding

const Color primaryPink = Color(0xFFE51742);
const Color inputFill = Color(0xFFF4F4F4);
const Color lightBorder = Color(0xFFDDDDDD);
const Color greyText = Color(0xFF777777);

// Initialize GoogleSignIn outside the widget to ensure it's a singleton
// IMPORTANT: Replace 'YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com'
// with your actual Client ID (the one ending in .apps.googleusercontent.com)
// This Client ID should be the "Web application" client ID from Google Cloud Console,
// even for mobile apps, to ensure you get an idToken for backend verification.
final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '524516881115-erpl9ot3g239d893kctb06o9dnb16v11.apps.googleusercontent.com', // Your provided Client ID for iOS/Web
  serverClientId: '524516881115-erpl9ot3g239d893kctb06o9dnb16v11.apps.googleusercontent.com', // Your provided Client ID (Web application type) for Android
  scopes: [
    'email',
    // You can add more scopes if your backend needs more user data, e.g., 'profile'
  ],
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
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

    // TODO: Implement actual email/password login logic (e.g., your custom API)
    _showMessage('Attempting login with username: $username');

    // Simulate successful login and navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  // Google Sign-In Implementation Structure
  Future<void> _signInWithGoogle() async {
    _showMessage('Initiating Google Sign-In...');
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _showMessage('Google Sign-In cancelled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Now, send googleAuth.idToken (or googleAuth.accessToken) to your backend for verification.
      // Your backend will then use this token to authenticate the user and return your app's session token.
      print('Google ID Token: ${googleAuth.idToken}');
      print('Google Access Token: ${googleAuth.accessToken}');

      // TODO: Replace this with an actual HTTP call to your backend's social login endpoint.
      // Example using the 'http' package (uncomment 'http' and 'dart:convert' imports above):
      /*
      final response = await http.post(
        Uri.parse('https://kolshy.ae/sociallogin/social/callback/'), // Or your specific API endpoint for Google login
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'idToken': googleAuth.idToken!,
          // You might also send accessToken if your backend needs it, or other user info
          'email': googleUser.email,
          'displayName': googleUser.displayName ?? '',
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful login from your backend
        final responseData = jsonDecode(response.body);
        _showMessage('Google Sign-In successful with backend: ${responseData['message']}');
        // TODO: Store your backend's session token and navigate to HomeScreen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        // Handle error from your backend
        _showMessage('Backend authentication failed: ${response.body}');
        print('Backend error: ${response.body}');
      }
      */

      // Placeholder for successful sign-in (remove once backend integration is live)
      _showMessage('Google Sign-In successful!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

    } catch (e) {
      _showMessage('Google Sign-In failed: ${e.toString()}');
      print('Google Sign-In error: $e'); // Log the full error for debugging
    }
  }

  // Apple Sign-In Implementation Structure
  Future<void> _signInWithApple() async {
    _showMessage('Initiating Apple Sign-In...');
    try {
      // ℹ️ Uncomment and implement actual Apple Sign-In logic here
      // final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName,
      //   ],
      // );

      // ℹ️ If using Firebase Auth:
      // final AuthCredential firebaseCredential = AppleAuthProvider.credential(
      //   identityToken: String.fromCharCodes(credential.identityToken!.codeUnits),
      //   rawNonce: String.fromCharCodes(credential.nonce!.codeUnits),
      // );
      // await _auth.signInWithCredential(firebaseCredential);
      // _showMessage('Apple Sign-In successful!');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

      // ℹ️ If not using Firebase Auth, send identityToken/nonce to your backend
      // _showMessage('Apple Sign-In successful (send token to backend)!');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

      // Placeholder for successful sign-in
      _showMessage('Apple Sign-In successful!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

    } catch (e) {
      _showMessage('Apple Sign-In failed: ${e.toString()}');
      print('Apple Sign-In error: $e'); // Log the full error for debugging
    }
  }

  // Facebook Sign-In Implementation Structure
  Future<void> _signInWithFacebook() async {
    _showMessage('Initiating Facebook Sign-In...');
    try {
      // ℹ️ Uncomment and implement actual Facebook Sign-In logic here
      // final LoginResult result = await FlutterFacebookAuth.instance.login();

      // if (result.status == LoginStatus.success) {
      //   final AccessToken accessToken = result.accessToken!;

      //   ℹ️ If using Firebase Auth:
      //   final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
      //   await _auth.signInWithCredential(credential);
      //   _showMessage('Facebook Sign-In successful!');
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

      //   ℹ️ If not using Firebase Auth, send accessToken.token to your backend
      //   _showMessage('Facebook Sign-In successful (send token to backend)!');
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

      // } else if (result.status == LoginStatus.cancelled) {
      //   _showMessage('Facebook Sign-In cancelled.');
      // } else {
      //   _showMessage('Facebook Sign-In failed: ${result.message}');
      // }

      // Placeholder for successful sign-in
      _showMessage('Facebook Sign-In successful!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

    } catch (e) {
      _showMessage('Facebook Sign-In failed: ${e.toString()}');
      print('Facebook Sign-In error: $e'); // Log the full error for debugging
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: primaryPink, // Use primaryPink for consistency
        behavior: SnackBarBehavior.floating, // Modern look for snackbar
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
            color: Colors.black87, // Slightly darker for better contrast
          ),
        ),
        const SizedBox(height: 36),

        // Username field
        _CustomInput(
          controller: _usernameController,
          hintText: AppLocalizations.of(context)!.usernameOrEmail,
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 20),

        // Password field
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
              foregroundColor: primaryPink, // Ensure text color is primaryPink
              padding: EdgeInsets.zero, // Remove default padding for tighter alignment
              minimumSize: Size.zero, // Remove default min size
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap area
            ),
            child: Text(
              AppLocalizations.of(context)!.forgotPwd,
              style: const TextStyle(
                fontSize: 14, // Slightly smaller for a modern look
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24), // Increased space before login button

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPink,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4, // Added a subtle shadow
            ),
            child: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Larger font, bold
            ),
          ),
        ),
        const SizedBox(height: 40),

        Row(
          children: [
            const Expanded(child: Divider(color: lightBorder)), // Added color to divider
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
            // Apple Button
            SocialButton(
              icon: 'assets/apple.png',
              onTap: _signInWithApple,
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
              child: Padding( // Added padding for better tap area
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                child: Text(
                  AppLocalizations.of(context)!.signUp,
                  style: TextStyle(color: primaryPink, fontWeight: FontWeight.w700, fontSize: 14), // Bold for emphasis
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // Added space at the bottom
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
    super.key, // Added key for better practice
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      style: const TextStyle(fontSize: 16, color: Colors.black87), // Adjusted text style
      decoration: InputDecoration(
        filled: true,
        fillColor: inputFill,
        hintText: hintText,
        hintStyle: const TextStyle(color: greyText, fontSize: 16), // Adjusted hint style
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
          borderSide: const BorderSide(color: primaryPink, width: 2), // Thicker border on focus
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap; // Added onTap callback

  const SocialButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrapped with GestureDetector
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryPink, width: 1.5),
          color: Colors.white, // Ensure background is white
          boxShadow: [ // Added subtle shadow for depth
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