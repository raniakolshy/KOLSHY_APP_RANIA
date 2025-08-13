import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kolshy_app/presentation/auth/login/welcome_screen.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../../../l10n/app_localizations.dart';
import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../Search/SearchPage.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';

/// ====== CONFIG (à adapter) ======
const String kApiBase = 'https://YOUR_BACKEND_BASE_URL'; // <- remplace
const String kCurrency = 'SAR';
const double kOrderAmount = 299.00; // <- remplace par le total panier en temps réel
const List<Map<String, dynamic>> kDemoItems = [
  {"id": "sku_123", "name": "Item A", "qty": 1, "price": 99.0},
  {"id": "sku_456", "name": "Item B", "qty": 2, "price": 100.0},
];

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primaryColor = const Color(0xFFE51742);
  final Color inactiveColor = Colors.grey.shade400;

  final _personalInfoFormKey = GlobalKey<FormState>();
  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  final _pageController = PageController();
  int _currentPage = 0;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _countryController = TextEditingController();

  final _cardHolderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedPaymentMethod = "Card";
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = "John";
    _lastNameController.text = "Doe";
    _phoneNumberController.text = "1234567890";
    _emailController.text = "john.doe@example.com";
    _addressController.text = "123 Main St";
    _cityController.text = "Anytown";
    _zipController.text = "12345";
    _countryController.text = "USA";
  }

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  /// ===== NAV bouton "Next" =====
  void _onNext() {
    bool isValid = false;
    if (_currentPage == 0) {
      isValid = _personalInfoFormKey.currentState!.validate();
    } else if (_currentPage == 1) {
      isValid = _shippingFormKey.currentState!.validate();
    } else if (_currentPage == 2) {
      // ✅ si autre que Card, pas besoin des champs carte
      isValid = _validatePaymentStepForNext();
    }
    if (isValid) {
      if (_currentPage < 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _submit();
      }
    }
  }

  bool _validatePaymentStepForNext() {
    // si card => valider les champs carte, sinon OK
    if (_selectedPaymentMethod == "Card") {
      return _paymentFormKey.currentState?.validate() ?? false;
    }
    // pas de champs requis pour les autres moyens
    return true;
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index != _selectedIndex) {
            setState(() => _selectedIndex = index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => getScreenForTab(index)),
            );
          }
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: Row(
        children: [
          _buildVerticalStepperColumn(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildPersonalInfoForm(),
                      _buildShippingForm(),
                      _buildPaymentMethodForm(),
                    ],
                  ),
                ),
                _buildControlButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Vertical Stepper Column ---
  Widget _buildVerticalStepperColumn() {
    return Container(
      width: 140,
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepperItem(0, "Personal Info"),
          _buildStepperItem(1, "Shipping Address"),
          _buildStepperItem(2, "Payment Method"),
        ],
      ),
    );
  }

  Widget _buildStepperItem(int stepIndex, String title) {
    bool isActive = _currentPage == stepIndex;
    bool isCompleted = _currentPage > stepIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (isCompleted || isActive) {
              _pageController.animateToPage(
                stepIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted ? primaryColor : (isActive ? primaryColor : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? primaryColor : inactiveColor,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    (stepIndex + 1).toString(),
                    style: TextStyle(
                      color: isCompleted || isActive ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? primaryColor : (isCompleted ? primaryColor : Colors.black54),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (stepIndex < 2)
          Container(
            height: 60,
            width: 1.5,
            color: isCompleted ? primaryColor : inactiveColor,
            margin: const EdgeInsets.only(left: 11, top: 4, bottom: 4),
          ),
      ],
    );
  }

  // --- Form Sections ---
  Widget _buildPersonalInfoForm() {
    return Form(
      key: _personalInfoFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Personal Info",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            _buildInput(controller: _firstNameController, label: "First Name"),
            _buildInput(controller: _lastNameController, label: "Last Name"),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phone, // existant
                labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                isDense: true,
              ),
              initialCountryCode: 'US',
              onChanged: (phone) => print(phone.completeNumber),
              onSaved: (phone) => _phoneNumberController.text = phone!.completeNumber,
              validator: (phone) => (phone == null || phone.number.isEmpty) ? 'Required' : null,
            ),
            _buildInput(
              controller: _emailController,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Invalid email';
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChangePasswordPage()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.centerRight,
                  minimumSize: Size.zero,
                ),
                child: Text(
                  "Change Password",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showDeleteConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.red,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingForm() {
    return Form(
      key: _shippingFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Address",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            _buildInput(controller: _addressController, label: "Street Address"),
            _buildInput(controller: _cityController, label: "City"),
            _buildInput(
              controller: _zipController,
              label: "ZIP / Postal Code",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Required';
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Invalid code';
                return null;
              },
            ),
            _buildInput(controller: _countryController, label: "Country"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// ===== PAYMENT (5 moyens) =====
  Widget _buildPaymentMethodForm() {
    return Form(
      key: _paymentFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            _buildPaymentMethodOption("Card", Icons.credit_card),
            _buildPaymentMethodOption("PayPal", Icons.account_balance_wallet),
            _buildPaymentMethodOption("Apple Pay", Icons.phone_iphone),
            _buildPaymentMethodOption("Tabby (BNPL)", Icons.payments_outlined),
            _buildPaymentMethodOption("Tamara (BNPL)", Icons.payments),

            const SizedBox(height: 24),

            if (_selectedPaymentMethod == "Card") ...[
              _buildInput(controller: _cardHolderNameController, label: "Cardholder Name"),
              _buildInput(
                controller: _cardNumberController,
                label: "Card Number",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (value.replaceAll(' ', '').length != 16) return '16 digits needed';
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildInput(
                      controller: _expiryDateController,
                      label: "Expiry (MM/YY)",
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) return 'MM/YY';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInput(
                      controller: _cvvController,
                      label: "CVV",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (value.length < 3 || value.length > 4) return 'Invalid CVV';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _primaryButton("Pay now (Card)", _payWithCard),
            ] else if (_selectedPaymentMethod == "PayPal") ...[
              _primaryButton("Continue with PayPal", _payWithPayPal),
            ] else if (_selectedPaymentMethod == "Apple Pay") ...[
              _primaryButton("Pay with Apple Pay", _payWithApplePay),
            ] else if (_selectedPaymentMethod == "Tabby (BNPL)") ...[
              _primaryButton("Continue with Tabby", _startTabbyCheckout),
            ] else if (_selectedPaymentMethod == "Tamara (BNPL)") ...[
              _primaryButton("Continue with Tamara", _startTamaraCheckout),
            ],

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Reusable Widgets ---
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          isDense: true,
        ),
        validator: validator ?? (value) => (value == null || value.isEmpty) ? 'Required' : null,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String label, IconData icon) {
    bool isSelected = _selectedPaymentMethod == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? primaryColor : Colors.grey[700], size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? primaryColor : Colors.black87,
                ),
              ),
            ),
            if (isSelected) Icon(Icons.check_circle_rounded, color: primaryColor, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _primaryButton(String label, Future<void> Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async => await onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
        ),
        child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- Helpers génériques ---
  /// ✅ Validation générique :
  /// - Personal & Shipping toujours requis
  /// - Payment: Card => champs requis ; autres => pas de champs requis
  bool _validateAllFormsBeforePayment({required bool requireCardFields}) {
    final p1 = _personalInfoFormKey.currentState?.validate() ?? false;
    final p2 = _shippingFormKey.currentState?.validate() ?? false;
    if (!p1 || !p2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the required information.")),
      );
      return false;
    }
    if (requireCardFields) {
      final p3 = _paymentFormKey.currentState?.validate() ?? false;
      if (!p3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please complete your card details.")),
        );
        return false;
      }
    }
    return true;
  }

  void _showLoading(bool show) {
    if (show) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showPaymentResultDialog({required String title, required bool success, required String message}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("$title payment"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$title: payment successful"), backgroundColor: Colors.green),
                );
                // TODO: clear cart / navigate
              }
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _postJson(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$kApiBase$path');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('HTTP ${resp.statusCode}: ${resp.body}');
    }
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Map<String, dynamic> _commonPayload() {
    return {
      "amount": kOrderAmount,
      "currency": kCurrency,
      "items": kDemoItems,
      "customer": {
        "first_name": _firstNameController.text.trim(),
        "last_name": _lastNameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneNumberController.text.trim(),
      },
      "shipping_address": {
        "address": _addressController.text.trim(),
        "city": _cityController.text.trim(),
        "zip": _zipController.text.trim(),
        "country": _countryController.text.trim(),
      },
      "return_urls": {
        "success": "yourapp://payments/success",
        "cancel": "yourapp://payments/cancel",
      }
    };
  }

  // --- 1) CARD ---
  Future<void> _payWithCard() async {
    // Card => champs carte OBLIGATOIRES
    if (!_validateAllFormsBeforePayment(requireCardFields: true)) return;

    _showLoading(true);
    try {
      final payload = {
        ..._commonPayload(),
        "card": {
          "holder": _cardHolderNameController.text.trim(),
          "number": _cardNumberController.text.replaceAll(' ', ''),
          "expiry": _expiryDateController.text.trim(), // MM/YY
          "cvv": _cvvController.text.trim(),
        }
      };

      final res = await _postJson('/payments/stripe/card-intent', payload);
      final success = (res['status'] == 'succeeded' || res['success'] == true);

      _showLoading(false);
      _showPaymentResultDialog(
        title: "Card",
        success: success,
        message: success ? "Card payment successful." : "Card payment failed.",
      );
    } catch (e) {
      _showLoading(false);
      _showPaymentResultDialog(title: "Card", success: false, message: "Error: $e");
    }
  }

  // --- 2) PAYPAL ---
  Future<void> _payWithPayPal() async {
    // Non-card => pas de champs carte requis
    if (!_validateAllFormsBeforePayment(requireCardFields: false)) return;

    _showLoading(true);
    try {
      final res = await _postJson('/payments/paypal/create-order', _commonPayload());
      _showLoading(false);

      final approveUrl = (res['approveUrl'] ?? res['links']?.firstWhere(
            (l) => l['rel'] == 'approve',
        orElse: () => null,
      )?['href']) as String?;

      if (approveUrl == null) throw Exception('Missing PayPal approve URL');

      // 👉 ouvre la page PayPal
      final launched = await launchUrlString(approveUrl, mode: LaunchMode.externalApplication);
      if (!launched) throw Exception('Could not open PayPal');

    } catch (e) {
      _showLoading(false);
      _showPaymentResultDialog(title: "PayPal", success: false, message: "Error: $e");
    }
  }

  // --- 3) APPLE PAY ---
  Future<void> _payWithApplePay() async {
    if (!_validateAllFormsBeforePayment(requireCardFields: false)) return;

    _showLoading(true);
    try {
      final res = await _postJson('/payments/applepay/session', _commonPayload());
      _showLoading(false);

      final url = res['fallbackUrl'] as String?;
      if (url != null) {
        final ok = await launchUrlString(url, mode: LaunchMode.externalApplication);
        if (!ok) throw Exception('Could not open Apple Pay fallback');
      } else {
        final success = (res['status'] == 'succeeded' || res['success'] == true);
        _showPaymentResultDialog(
          title: "Apple Pay",
          success: success,
          message: success ? "Apple Pay successful." : "Apple Pay failed.",
        );
      }
    } catch (e) {
      _showLoading(false);
      _showPaymentResultDialog(title: "Apple Pay", success: false, message: "Error: $e");
    }
  }

  // --- 4) TABBY ---
  Future<void> _startTabbyCheckout() async {
    if (!_validateAllFormsBeforePayment(requireCardFields: false)) return;

    _showLoading(true);
    try {
      final res = await _postJson('/payments/tabby/session', _commonPayload());
      _showLoading(false);

      final checkoutUrl = res['checkoutUrl'] as String?;
      if (checkoutUrl == null) throw Exception('Missing Tabby checkoutUrl');

      // 👉 ouvre la page Tabby
      final ok = await launchUrlString(checkoutUrl, mode: LaunchMode.externalApplication);
      if (!ok) throw Exception('Could not open Tabby');

    } catch (e) {
      _showLoading(false);
      _showPaymentResultDialog(title: "Tabby", success: false, message: "Error: $e");
    }
  }

  // --- 5) TAMARA ---
  Future<void> _startTamaraCheckout() async {
    if (!_validateAllFormsBeforePayment(requireCardFields: false)) return;

    _showLoading(true);
    try {
      final res = await _postJson('/payments/tamara/session', _commonPayload());
      _showLoading(false);

      final redirectUrl = res['redirectUrl'] as String?;
      if (redirectUrl == null) throw Exception('Missing Tamara redirectUrl');

      // 👉 ouvre la page Tamara
      final ok = await launchUrlString(redirectUrl, mode: LaunchMode.externalApplication);
      if (!ok) throw Exception('Could not open Tamara');

    } catch (e) {
      _showLoading(false);
      _showPaymentResultDialog(title: "Tamara", success: false, message: "Error: $e");
    }
  }

  Widget _buildControlButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: _currentPage > 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
        children: [
          if (_currentPage > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Back", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          SizedBox(width: _currentPage > 0 ? 14 : 0),
          Expanded(
            child: ElevatedButton(
              onPressed: _onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              child: Text(
                _currentPage < 2 ? "Next" : "Save",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Delete Account dialog (english notifications)
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Your deletion logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Account deleted successfully!"),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
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
