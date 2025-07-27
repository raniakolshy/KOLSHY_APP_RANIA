import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSeller = false;
  String sellerChoice = '';
  bool newsletter = false;
  bool remoteAssist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.pinkAccent,
                  backgroundImage: AssetImage('assets/avatar.png'), // Assure-toi que le chemin est correct
                ),
                const Positioned(
                  bottom: 0,
                  right: 4,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Personal Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            buildTextField('First Name', 'Lorem'),
            buildTextField('Last Name', 'Lorem ipson', bold: true),
            buildTextField('Email Address', 'aashifa@gmail.com', bold: true),
            buildTextField('Password', '**********', obscure: true),
            buildTextField('Confirm Password', '**********', obscure: true),
            buildTextField('Phone number', '+216 21 211 211', bold: true),
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Do you wanna become a Seller / Vendor ?'),
            ),
            Row(
              children: [
                Checkbox(
                  value: sellerChoice == 'Yes',
                  onChanged: (_) {
                    setState(() => sellerChoice = 'Yes');
                  },
                ),
                const Text('Yes'),
                Checkbox(
                  value: sellerChoice == 'No',
                  onChanged: (_) {
                    setState(() => sellerChoice = 'No');
                  },
                ),
                const Text('No'),
              ],
            ),
            CheckboxListTile(
              title: const Text('Sign up for newsletter'),
              value: newsletter,
              onChanged: (val) {
                setState(() => newsletter = val!);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Allow remote Shopping assistance'),
              value: remoteAssist,
              onChanged: (val) {
                setState(() => remoteAssist = val!);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 20,
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Business Address Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            buildTextField('Pincode', '450116'),
            buildTextField("Address", "216 St Paul's Rd,"),
            buildTextField("City", "London"),
            buildTextField("State", "N1 2LL,"),
            buildTextField("Country", "United Kingdom"),
            const SizedBox(height: 30),
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Bank Account Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            buildTextField("Bank Account Number", "204356XXXXXXXX"),
            buildTextField("Account Holder’s Name", "Abhiraj Sisodiya"),
            buildTextField("IFSC Code", "SBIN00428"),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDD1E1E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Action on save
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, {bool obscure = false, bool bold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

      ],
    );
  }
}
