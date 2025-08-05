import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';

import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../Search/SearchPage.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';

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
    _phoneNumberController.text = "+11234567890";
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

  void _onNext() {
    bool isValid = false;
    if (_currentPage == 0) {
      isValid = _personalInfoFormKey.currentState!.validate();
    } else if (_currentPage == 1) {
      isValid = _shippingFormKey.currentState!.validate();
    } else if (_currentPage == 2) {
      isValid = _paymentFormKey.currentState!.validate();
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
        title: Text(
          AppLocalizations.of(context)!.editProfile,
          style: const TextStyle(
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

  Widget _buildVerticalStepperColumn() {
    return Container(
      width: 140,
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepperItem(0, AppLocalizations.of(context)!.personalInfo),
          _buildStepperItem(1, AppLocalizations.of(context)!.shippingAddress),
          _buildStepperItem(2, AppLocalizations.of(context)!.paymentMethod),
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

  Widget _buildPersonalInfoForm() {
    return Form(
      key: _personalInfoFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.personalInfo,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 24),
            _buildInput(controller: _firstNameController, label: AppLocalizations.of(context)!.firstName),
            _buildInput(controller: _lastNameController, label: AppLocalizations.of(context)!.lastName),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phone,
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
              label: AppLocalizations.of(context)!.email,
              keyboardType: TextInputType.emailAddress,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePasswordPage())),
                child: Text(AppLocalizations.of(context)!.changePassword,
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 14)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingForm() => Container();
  Widget _buildPaymentMethodForm() => Container();
  Widget _buildControlButtons() => Container();
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
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
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          isDense: true,
        ),
        validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
        style: const TextStyle(fontSize: 15),
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
