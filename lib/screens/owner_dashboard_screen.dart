// lib/screens/owner_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'owner_profile_screen.dart';
import 'add_equipment_form.dart';

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final equipmentList = [
      {'name': 'My Tractor', 'status': 'Available', 'bookings': '2', 'image': 'assets/tractor.jpg'},
      {'name': 'My Thresher', 'status': 'Booked', 'bookings': '1', 'image': 'assets/thresher.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OwnerProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Equipment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final item = equipmentList[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(item['image']!, width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(item['name']!),
                      subtitle: Text('Status: ${item['status']} | Bookings: ${item['bookings']}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Toggled ${item['name']} status')),
                          );
                        },
                        child: Text(item['status'] == 'Available' ? 'Mark Booked' : 'Mark Available'),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddEquipmentForm(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Add Equipment', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}