import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Create an\naccount',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,

                ),
              ),
              const SizedBox(height: 40),

              // Username or Email Field
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username or Email',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Terms and Conditions
              Row(
                children: [
                  Checkbox(value: false, onChanged: (_) {}),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'By clicking the ',
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(text: ' button, you agree to the public offer'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53950),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onPressed: () {},

                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20,color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(height: 110),

              // OR Divider
              const Center(
                child: Text(
                  '- OR Continue with -',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 18),

              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon('assets/google.png'),
                  const SizedBox(width: 16),
                  _socialIcon('assets/apple.png'),
                  const SizedBox(width: 16),
                  _socialIcon('assets/facebook.png'),
                ],
              ),
              const SizedBox(height: 10),

              // Already Have Account
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to login
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'I Already Have an Account ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: Color(0xFFE53950)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        assetPath,
        height: 32,
        width: 32,
      ),
    );
  }
}
