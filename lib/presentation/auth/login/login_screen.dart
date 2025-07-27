import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text('Welcome', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
        const Text('Back!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
        const SizedBox(height: 30),
        const CustomTextField(
          hintText: 'Username or Email',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          hintText: 'Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?', style: TextStyle(color: Colors.redAccent)),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),

          ),
        ),
        const SizedBox(height: 190),
        const Center(child: Text('  - OR Continue with -')),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SocialButton(icon: 'assets/google.png'),
            SizedBox(width: 12),
            SocialButton(icon: 'assets/apple.png'),
            SizedBox(width: 12),
            SocialButton(icon: 'assets/facebook.png'),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Create An Account "),
            GestureDetector(
              onTap: () {},
              child: const Text("Sign Up", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        )
      ],
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(widget.icon, color: Colors.grey[700]),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[700],
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F7), // Light pink background
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 1), // Pink border
      ),
      child: Image.asset(
        icon,
        width: 35,
        height: 35,
      ),
    );
  }
}
