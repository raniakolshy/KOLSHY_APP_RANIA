import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color primaryColor = const Color(0xFFE51742); // accent pink/red
  final Color secondaryColor = const Color(0xFF273647); // dark gray-blue

  final Map<String, TextEditingController> controllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'address': TextEditingController(),
    'city': TextEditingController(),
    'postcode': TextEditingController(),
    'country': TextEditingController(),
    'accountNumber': TextEditingController(),
    'accountName': TextEditingController(),
    'ifsc': TextEditingController(),
  };

  bool newsletter = false;
  bool remoteAssist = false;
  String sellerChoice = '';
  int _selectedIndex = 0;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    for (var controller in controllers.values) {
      controller.addListener(_checkForChanges);
    }
  }

  void _checkForChanges() {
    final anyText = controllers.values.any((c) => c.text.trim().isNotEmpty);
    if (anyText != hasChanges) {
      setState(() => hasChanges = anyText);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _input(String label, String key, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controllers[key],
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    final selected = sellerChoice == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => sellerChoice = label),
      selectedColor: primaryColor,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Back button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Profile image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 52,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: secondaryColor,
                    child:
                    const Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ],
              ),
            ),

            _sectionTitle("Personal Info"),
            _input("First Name", 'firstName'),
            _input("Last Name", 'lastName'),
            _input("Email", 'email'),
            _input("Phone", 'phone'),
            Row(
              children: [
                const Text("Become a Seller?", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                _buildChoiceChip("Yes"),
                const SizedBox(width: 6),
                _buildChoiceChip("No"),
              ],
            ),
            const SizedBox(height: 8),
            _buildCheckbox("Sign up for newsletter", newsletter,
                    (val) => setState(() => newsletter = val ?? false)),
            _buildCheckbox("Enable remote shopping help", remoteAssist,
                    (val) => setState(() => remoteAssist = val ?? false)),

            _sectionTitle("Address"),
            _input("Street Address", 'address'),
            _input("City", 'city'),
            _input("Postcode", 'postcode'),
            _input("Country", 'country'),

            _sectionTitle("Bank Details"),
            _input("Account Number", 'accountNumber'),
            _input("Account Holder", 'accountName'),
            _input("IFSC Code", 'ifsc'),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: hasChanges ? () => debugPrint("Saved!") : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: primaryColor,
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  disabledForegroundColor: Colors.grey,
                  side: BorderSide(
                      color: hasChanges ? primaryColor : Colors.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 12),
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
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
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