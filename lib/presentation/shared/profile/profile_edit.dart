import 'package:flutter/material.dart';
import 'package:kolshy_app/l10n/app_localizations.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';

import '../../client/Messages/Chat_screen.dart';
import '../../client/cart/ShoppingCartPage.dart';
import '../../client/notifications/notification_screen.dart';
import '../Search/SearchPage.dart';
import '../home/home_screen.dart';
import '../settings/Settings_screen.dart';
import '../widgets/bottom_nav_bar.dart';

// Your other imports - ensure these paths are correct for your project
// import 'package:kolshy_app/presentation/client/cart/ThankYouPage.dart';
// import '../../client/cart/CheckoutPage.dart';
// import '../../shared/Search/SearchPage.dart';
// import '../../shared/home/home_screen.dart';
// import '../../shared/settings/Settings_screen.dart';
// import '../../shared/widgets/bottom_nav_bar.dart'; // Future Navbar

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primaryColor = const Color(0xFFE51742); // A vibrant red
  final Color inactiveColor = Colors.grey.shade400; // For inactive elements

  // Form keys for validation
  final _personalInfoFormKey = GlobalKey<FormState>();
  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  // Page view controller for smooth transitions
  final _pageController = PageController();
  int _currentPage = 0;

  // Controllers for form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneCountryCodeController = TextEditingController(); // For "Country" in phone
  final _phoneNumberController = TextEditingController(); // Actual phone number
  final _emailController = TextEditingController();

  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _countryController = TextEditingController();

  final _cardHolderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  String _selectedPaymentMethod = "Card"; // Default selected payment method
  int _selectedIndex = 4;
  @override
  void initState() {
    super.initState();
    // Initialize controllers with some dummy data for demonstration, matching images
    _firstNameController.text = "John";
    _lastNameController.text = "Doe";
    _phoneCountryCodeController.text = "Count..."; // As seen in the image
    _phoneNumberController.text = "1234567890";
    _emailController.text = "john.doe@example.com";
    // For Shipping
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
    _phoneCountryCodeController.dispose();
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
    // You might want to navigate pop or to a success page here
    // Navigator.pop(context);
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
        ),title: Text(
        AppLocalizations.of(context)!.editProfile,
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
          // Vertical progress indicator and labels
          _buildVerticalStepperColumn(),
          // Main content area
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
      // Future: Add BottomNavigationBar here
      // bottomNavigationBar: const MyBottomNavBar(),
    );
  }

  // --- Vertical Stepper Column ---
  Widget _buildVerticalStepperColumn() {
    return Container(
      width: 140, // Increased width to fit number and text on one line
      padding: const EdgeInsets.only(left: 20, top: 20), // Padding to align with image
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
            // Allow navigation to previous steps
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
              // Numbered Circle
              Container(
                width: 24, // Size of the circle
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted ? primaryColor : (isActive ? primaryColor : Colors.white),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? primaryColor : inactiveColor,
                    width: 1.5, // Thinner border
                  ),
                ),
                child: Center(
                  child: Text(
                    (stepIndex + 1).toString(),
                    style: TextStyle(
                      color: isCompleted || isActive ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 13, // Smaller font size for number
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8), // Space between circle and text
              // Step Title
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? primaryColor : (isCompleted ? primaryColor : Colors.black54), // Active/completed text color
                  ),
                  maxLines: 2, // Allow wrapping for longer titles
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (stepIndex < 2) // Vertical Line
          Container(
            height: 60, // Height of the line to connect steps, adjust as needed
            width: 1.5, // Thin line
            color: isCompleted ? primaryColor : inactiveColor,
            margin: const EdgeInsets.only(left: 11, top: 4, bottom: 4), // Aligns with center of circle
          ),
      ],
    );
  }

  // --- Form Sections ---
  Widget _buildPersonalInfoForm() {
    return Form(
      key: _personalInfoFormKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24), // Keep horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              AppLocalizations.of(context)!.personalInfo,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            _buildInput(controller: _firstNameController, label: AppLocalizations.of(context)!.firstName),
            _buildInput(controller: _lastNameController, label: AppLocalizations.of(context)!.lastName),
            Row(
              children: [
                // Country Code field
                Container(
                  width: 80, // Fixed width for country code
                  margin: const EdgeInsets.only(right: 10, bottom: 12),
                  child: _buildInput(
                    controller: _phoneCountryCodeController,
                    label: "Count...", // As in image
                    keyboardType: TextInputType.text, // Could be phone, but text for "Count..."
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ''; // Don't show full error for this, just hint
                      }
                      return null;
                    },
                  ),
                ),
                // Phone Number field
                Expanded(
                  child: _buildInput(
                    controller: _phoneNumberController,
                    label: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required'; // Concise error message
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Invalid number';
                      }
                      if (value.length < 7) { // Example: min 7 digits for phone
                        return 'Too short';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            _buildInput(
              controller: _emailController,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Invalid email';
                }
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
                  padding: const EdgeInsets.all(0), // No extra padding
                  alignment: Alignment.centerRight,
                  minimumSize: Size.zero, // Remove default min size
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
            const SizedBox(height: 16), // Space before bottom button
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
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Invalid code';
                }
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
            const SizedBox(height: 24),
            if (_selectedPaymentMethod == "Card") ...[
              _buildInput(controller: _cardHolderNameController, label: "Cardholder Name"),
              _buildInput(
                controller: _cardNumberController,
                label: "Card Number",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  if (value.replaceAll(' ', '').length != 16) {
                    return '16 digits needed';
                  }
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
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
                          return 'MM/YY';
                        }
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
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 3 || value.length > 4) {
                          return 'Invalid CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
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
      padding: const EdgeInsets.only(bottom: 16), // Consistent spacing
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14), // Smaller label font
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: Colors.grey[100], // Light grey background
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Small rounded corners as in image
            borderSide: BorderSide.none, // No default border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 2), // Red border on focus
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12), // Compact padding
          isDense: true, // Makes the input more compact
        ),
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Required'; // Default concise error
          }
          return null;
        },
        style: const TextStyle(fontSize: 15), // Text size inside input
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
          borderRadius: BorderRadius.circular(10), // Consistent rounding
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : Colors.grey[700],
              size: 24,
            ),
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
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: primaryColor, size: 22),
          ],
        ),
      ),
    );
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
          if (_currentPage > 0) // Show Back button only if not on the first page
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
          SizedBox(width: _currentPage > 0 ? 14 : 0), // Space only if Back button is present
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