import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'booking_history_screen.dart';
import 'training_screen.dart';
import 'profile_screen.dart';
import 'owner_dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  final String userType;

  const MainScreen({super.key, required this.userType});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> get _farmerScreens => [
        const HomeScreen(),
        const BookingHistoryScreen(),
        const TrainingScreen(),
        const ProfileScreen(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // title: const Text('Select Multiple Equipment'),
        backgroundColor: Colors.green[700],
      ),
      body: widget.userType == 'owner' ? const OwnerDashboardScreen() : _farmerScreens[_selectedIndex],
      bottomNavigationBar: widget.userType == 'owner'
          ? null
          : BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 28,
                    color: _selectedIndex == 0 ? Colors.amber[600] : Colors.white70,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    size: 28,
                    color: _selectedIndex == 1 ? Colors.amber[600] : Colors.white70,
                  ),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.school,
                    size: 28,
                    color: _selectedIndex == 2 ? Colors.amber[600] : Colors.white70,
                  ),
                  label: 'Training',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 28,
                    color: _selectedIndex == 3 ? Colors.amber[600] : Colors.white70,
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[600],
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.green[800],
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelStyle: const TextStyle(fontSize: 12),
              elevation: 10,
              onTap: _onItemTapped,
              selectedIconTheme: IconThemeData(
                color: Colors.amber[600],
                size: 32,
              ),
              unselectedIconTheme: const IconThemeData(
                color: Colors.white70,
                size: 24,
              ),
            ),
    );
  }
}