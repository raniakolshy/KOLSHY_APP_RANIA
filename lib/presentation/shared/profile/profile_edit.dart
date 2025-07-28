import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final Color primaryColor = const Color(0xFFE51742);
  final Color secondaryColor = const Color(0xFF273647);

  int _selectedIndex = 0;

  final TextEditingController emailController = TextEditingController();
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

  void _checkChanges() {
    setState(() {
      hasChanges = emailController.text.isNotEmpty ||
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
            customField('Email Address', emailController),
            customField('Password', passwordController, obscure: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
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
                onPressed: hasChanges ? () => debugPrint("Saved!") : null,
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
        TextField(
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

  /// ✅ Your Custom Bottom Navigation Bar
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