import 'package:flutter/material.dart';
import 'package:kolshy_app/presentation/auth/forgot_password/forgot_password.dart';
import 'package:kolshy_app/presentation/shared/profile/change_password_screen.dart';
import 'package:kolshy_app/presentation/shared/settings/settings_screen.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primaryColor = const Color(0xFFE51742);
  final Color secondaryColor = const Color(0xFF273647);

  int _selectedIndex = 0;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController emailController = TextEditingController(); // New Email
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  String selectedState = "N1 2LL,";

  bool hasChanges = false;

  final _formKey = GlobalKey<FormState>();

  void _checkChanges() {
    setState(() {
      hasChanges = firstNameController.text.isNotEmpty ||
          lastNameController.text.isNotEmpty ||
          phoneController.text.isNotEmpty ||
          currentEmailController.text.isNotEmpty ||
          emailController.text.isNotEmpty ||
          passwordController.text.isNotEmpty ||
          pincodeController.text.isNotEmpty ||
          addressController.text.isNotEmpty ||
          cityController.text.isNotEmpty ||
          countryController.text.isNotEmpty ||
          accountNumberController.text.isNotEmpty ||
          accountNameController.text.isNotEmpty ||
          ifscController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    for (var c in [
      firstNameController,
      lastNameController,
      phoneController,
      currentEmailController,
      emailController,
      passwordController,
      pincodeController,
      addressController,
      cityController,
      countryController,
      accountNumberController,
      accountNameController,
      ifscController
    ]) {
      c.addListener(_checkChanges);
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    currentEmailController.dispose();
    emailController.dispose();
    passwordController.dispose();
    pincodeController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    accountNumberController.dispose();
    accountNameController.dispose();
    ifscController.dispose();
    super.dispose();
  }

  void _showNotification(String message, {bool success = false}) {
    final color = success ? Colors.green : Colors.red;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void _handleSave() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        currentEmailController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      _showNotification("Please fill out all required fields.");
      return;
    }

    if (passwordController.text.length < 6) {
      _showNotification("Password must be at least 6 characters long.");
      return;
    }

    if (_formKey.currentState!.validate()) {
      _showNotification("Profile updated successfully!", success: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: secondaryColor,
                    child: const Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              sectionTitle('Personal Details'),
              customField('First Name', firstNameController),
              customField('Last Name', lastNameController),
              validatedPhoneField('Telephone', phoneController),
              customField('Current Email Address', currentEmailController),
              validatedEmailField('New Email Address', emailController),
              customField('Password *', passwordController, obscure: true),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                    );
                  },
                  child: Text("Change Password", style: TextStyle(color: primaryColor)),
                ),
              ),

              const Divider(),
              sectionTitle('Business Address Details'),
              customField('Pincode', pincodeController),
              customField("Address", addressController),
              customField("City", cityController),
              dropdownField("State", ["N1 2LL,", "W1A 1AA", "EC1A 1BB"]),
              customField("Country", countryController),
              const Divider(),
              sectionTitle('Bank Account Details'),
              customField("Bank Account Number", accountNumberController),
              customField("Account Holder’s Name", accountNameController),
              customField("IFSC Code", ifscController),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (hasChanges && passwordController.text.isNotEmpty)
                      ? _handleSave
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryColor,
                    disabledBackgroundColor: Colors.grey.shade200,
                    disabledForegroundColor: Colors.grey,
                    side: BorderSide(color: hasChanges ? primaryColor : Colors.transparent),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Save", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 20),
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget customField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget validatedEmailField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a new email address';
            } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget validatedPhoneField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a phone number';
            } else if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
              return 'Enter a valid phone number (min 10 digits)';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget dropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selectedState,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (val) {
              if (val != null) {
                setState(() => selectedState = val);
                _checkChanges();
              }
            },
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    List<String> iconNames = ['Home', 'Cart', 'Search', 'Chat', 'Setting'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 1, color: Colors.black.withOpacity(0.05)),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(iconNames.length, (index) {
                final name = iconNames[index];
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/Icons/${name}${isSelected ? 'G' : 'F'}.png',
                          width: 26,
                          height: 26,
                          color: Colors.black,
                          errorBuilder: (ctx, err, trace) =>
                          const Icon(Icons.error),
                        ),
                        const SizedBox(height: 4),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                            color: Colors.black,
                          ),
                          child: Text(name),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
