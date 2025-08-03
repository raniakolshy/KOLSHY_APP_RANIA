import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/l10n/app_localizations_en.dart';

import 'package:kolshy_app/presentation/shared/home/home_screen.dart';
import '../login/login_screen.dart';

const Color primaryPink = Color(0xFFE51742);
const Color inputFill = Color(0xFFF4F4F4);
const Color lightBorder = Color(0xFFDDDDDD);
const Color greyText = Color(0xFF777777);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isChecked = false;
  bool _newsletter = false;
  bool _remoteAssist = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String _sellerChoice = '';

  void _showMessage(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void _onRegister() {
    if (!_isChecked) {
      _showMessage('You must accept the public offer');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('Passwords do not match');
      return;
    }

    _showMessage('Account created successfully!', isError: false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // ou center selon ton besoin
                children: [
                  Text(
                    AppLocalizations.of(context)!.createSimple, // ← "Create"
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.anAccount, // ← "an account"
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
,
              const SizedBox(height: 36),

              _CustomInput(
                controller: _firstNameController,
                hintText: AppLocalizations.of(context)!.firstName,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

              _CustomInput(
                controller: _lastNameController,
                hintText: AppLocalizations.of(context)!.lastName,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),

              _CustomInput(
                controller: _emailController,
                hintText: AppLocalizations.of(context)!.email,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              _CustomInput(
                controller: _phoneController,
                hintText: AppLocalizations.of(context)!.phone,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
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
              const SizedBox(height: 20),

              _CustomInput(
                controller: _confirmPasswordController,
                hintText: AppLocalizations.of(context)!.passworConfirmation,
                icon: Icons.lock_outline,
                isPassword: true,
                obscureText: _obscureConfirm,
                toggleVisibility: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
              const SizedBox(height: 20),

              // Become a Seller section
              Text(AppLocalizations.of(context)!.becomeASeller, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildChoiceChip(AppLocalizations.of(context)!.yes),
                  const SizedBox(width: 10),
                  _buildChoiceChip(AppLocalizations.of(context)!.no),
                ],
              ),
              const SizedBox(height: 16),

              // Checkboxes
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: primaryPink,
                value: _isChecked,
                onChanged: (v) => setState(() => _isChecked = v ?? false),
                title: RichText(
                  text:  TextSpan(
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(text: AppLocalizations.of(context)!.byClickingThe ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.signUp,
                        style: TextStyle(
                          color: primaryPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: AppLocalizations.of(context)!.publicOffer),
                    ],
                  ),
                ),
              ),

              CheckboxListTile(
                title:  Text( AppLocalizations.of(context)!.newsletter),
                value: _newsletter,
                onChanged: (val) =>
                    setState(() => _newsletter = val ?? false),
                activeColor: primaryPink,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              CheckboxListTile(
                title:  Text(AppLocalizations.of(context)!.enableremoteshoppinghelp),
                value: _remoteAssist,
                onChanged: (val) =>
                    setState(() => _remoteAssist = val ?? false),
                activeColor: primaryPink,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:  Text(
                    AppLocalizations.of(context)!.create,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Row(
                children:  [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(AppLocalizations.of(context)!.continueWith,
                        style: TextStyle(color: greyText)),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SocialButton(icon: 'assets/google.png'),
                  SizedBox(width: 20),
                  SocialButton(icon: 'assets/apple.png'),
                  SizedBox(width: 20),
                  SocialButton(icon: 'assets/facebook.png'),
                ],
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.alreadyHaveAnAccount,
                      style: TextStyle(color: greyText)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                          color: primaryPink, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    final selected = _sellerChoice == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _sellerChoice = label),
      selectedColor: primaryPink,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
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
  final TextInputType keyboardType;

  const _CustomInput({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: inputFill,
        hintText: hintText,
        hintStyle: const TextStyle(color: greyText),
        prefixIcon: Icon(icon, color: greyText),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: greyText,
          ),
          onPressed: toggleVisibility,
        )
            : null,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
          borderSide: const BorderSide(color: primaryPink),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  const SocialButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryPink, width: 1.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Image.asset(icon, fit: BoxFit.contain),
    );
  }
}
