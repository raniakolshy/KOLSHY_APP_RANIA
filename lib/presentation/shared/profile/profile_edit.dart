import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: EditProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: MediaQuery.of(context).size.width / 2 - 100,
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.pink,
                    child: Icon(Icons.edit, color: Colors.white, size: 18),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),

            // Personal Details
            sectionTitle('Personal Details'),
            customField('Email Address', 'aashifa@gmail.com'),
            customField('Password', '**********'),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Change Password",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ),
            const Divider(),

            // Business Address Details
            sectionTitle('Business Address Details'),
            customField('Pincode', '450116'),
            customField("Address", "216 St Paul's Rd,"),
            customField("City", "London"),
            dropdownField("State", ["N1 2LL,", "W1A 1AA", "EC1A 1BB"]),
            customField("Country", "United Kingdom"),
            const Divider(),

            // Bank Account Details
            sectionTitle('Bank Account Details'),
            customField("Bank Account Number", "204356XXXXXXXX"),
            customField("Account Holder’s Name", "Abhiraj Sisodiya"),
            customField("IFSC Code", "SBIN00428"),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Save", style: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 20),
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget customField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextField(
          enabled: true,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget dropdownField(String label, List<String> items) {
    String selected = items.first;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(label),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: selected,
                isExpanded: true,
                underline: const SizedBox(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selected = val);
                  }
                },
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
