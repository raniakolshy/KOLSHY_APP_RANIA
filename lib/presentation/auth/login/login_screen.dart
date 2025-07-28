import 'package:flutter/material.dart';
import 'package:kolshy_app/presentation/auth/forgot_password/forgot_password.dart';
import 'package:kolshy_app/presentation/auth/register/register_screen.dart';
import 'package:kolshy_app/presentation/shared/home/home_screen.dart'; // <-- Ajouté ici

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

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validatePassword(String password) {
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    } else if (!hasNumber) {
      return 'Password must contain at least one number.';
    }
    return null;
  }

  void _onLoginPressed() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username or email cannot be empty.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If everything is valid
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful.'),
        backgroundColor: Colors.green,
      ),
    );

    // Redirige vers HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text('Welcome', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
        const Text('Back!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
        const SizedBox(height: 30),
        CustomTextField(
          controller: _usernameController,
          hintText: 'Username or Email',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: _passwordController,
          hintText: 'Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
              );
            },
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
            onPressed: _onLoginPressed,
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
            const Text("Don't have an account? "),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
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
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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
        color: const Color(0xFFFFF5F7),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 1),
      ),
      child: Image.asset(
        icon,
        width: 35,
        height: 35,
      ),
    );
  }
}
