import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final userType = prefs.getString('userType') ?? 'farmer';
  runApp(MyApp(isLoggedIn: isLoggedIn, userType: userType));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String userType;

  const MyApp({super.key, required this.isLoggedIn, required this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriShare Demo',
      theme: ThemeData(
        primaryColor: Colors.green[700],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green[700],
          selectedItemColor: Colors.amber[600],
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: true,
        ),
      ),
      home: isLoggedIn ? MainScreen(userType: userType) : const LoginScreen(),
    );
  }
}