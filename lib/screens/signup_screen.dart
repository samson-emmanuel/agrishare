// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  String _userType = 'farmer';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userType', _userType);
      await prefs.setString('name', _nameController.text);
      await prefs.setInt('age', int.parse(_ageController.text));
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('address', _addressController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(userType: _userType)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green[800]!, Colors.green[400]!],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Logo or Icon
                          Center(
                            child: Image.asset('assets/agrishare_logo2.png', height: 80),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'AgriShare',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Form Fields
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              prefixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              if (int.tryParse(value) == null || int.parse(value) < 18 || int.parse(value) > 100) {
                                return 'Please enter a valid age (18-100)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: const Icon(Icons.phone, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (!RegExp(r'^\+?0[0-9]{10}$').hasMatch(value)) {
                                return 'Please enter a valid phone number (e.g., +2348012345678)';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          // const SizedBox(height: 16),
                          // DropdownButtonFormField<String>(
                          //   value: _userType,
                          //   decoration: InputDecoration(
                          //     labelText: 'User Type',
                          //     prefixIcon: const Icon(Icons.group, color: Colors.green),
                          //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          //     filled: true,
                          //     fillColor: Colors.grey[100],
                          //   ),
                          //   items: ['farmer', 'owner'].map((String type) {
                          //     return DropdownMenuItem<String>(
                          //       value: type,
                          //       child: Text(type[0].toUpperCase() + type.substring(1)),
                          //     );
                          //   }).toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _userType = value!;
                          //     });
                          //   },
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return 'Please select a user type';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          const SizedBox(height: 20),
                          // Action Buttons
                          ElevatedButton(
                            onPressed: () => _signUp(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[600],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Already have an account? Log In',
                              style: TextStyle(color: Colors.green, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
