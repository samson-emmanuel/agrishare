// lib/screens/multi_equipment_selection_screen.dart
import 'package:flutter/material.dart';
import 'multi_payment_screen.dart';

class MultiEquipmentSelectionScreen extends StatefulWidget {
  const MultiEquipmentSelectionScreen({super.key});

  @override
  _MultiEquipmentSelectionScreenState createState() => _MultiEquipmentSelectionScreenState();
}

class _MultiEquipmentSelectionScreenState extends State<MultiEquipmentSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  List<Map<String, String>> selectedEquipment = [];

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
    super.dispose();
  }

  void _toggleSelection(Map<String, String> equipment, bool isSelected) {
    setState(() {
      if (isSelected && !selectedEquipment.any((item) => item['name'] == equipment['name'])) {
        selectedEquipment.add(equipment);
      } else if (!isSelected) {
        selectedEquipment.removeWhere((item) => item['name'] == equipment['name']);
      }
      print('Selected Equipment: $selectedEquipment'); // Debug print
    });
  }

  void _navigateToMultiPayment() {
    if (selectedEquipment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one equipment')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiPaymentScreen(selectedEquipment: selectedEquipment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allEquipment = [
       {
        'name': 'Power Tiller',
        'price': 'NGN 6000/hour',
        'image': 'assets/tiller.png',
        'location': 'Ebonyi',
        'owner': 'Fatima Usman',
        'rating': '4.0'
      },
      {
        'name': 'Seed Planter',
        'price': 'NGN 7000/hour',
        'image': 'assets/seedplanter.png',
        'location': 'Kano',
        'owner': 'Yusuf Ali',
        'rating': '4.3'
      },
      {
        'name': 'Harvester',
        'price': 'NGN 12000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Hassan Sani',
        'rating': '4.7'
      },
      {
        'name': 'Sprayer',
        'price': 'NGN 4000/hour',
        'image': 'assets/sprayer.png',
        'location': 'Kano',
        'owner': 'Aisha Mohammed',
        'rating': '4.1'
      },
      {
        'name': 'Harrow',
        'price': 'NGN 5500/hour',
        'image': 'assets/harrow.png',
        'location': 'Ebonyi',
        'owner': 'Ibrahim Sani',
        'rating': '4.4'
      },
      {
        'name': 'Combine Harvester',
        'price': 'NGN 15000/hour',
        'image': 'assets/combine_harvester.png',
        'location': 'Kano',
        'owner': 'Fatima Ali',
        'rating': '4.6'
      },
      {
        'name': 'Plows',
        'price': 'NGN 4500/hour',
        'image': 'assets/plows.png',
        'location': 'Kano',
        'owner': 'Yusuf Bello',
        'rating': '4.0'
      },
      {
        'name': 'Cultivator',
        'price': 'NGN 5000/hour',
        'image': 'assets/cultivator.png',
        'location': 'Kaduna',
        'owner': 'Hassan Musa',
        'rating': '4.2'
      },
      {
        'name': 'Loaders',
        'price': 'NGN 9000/hour',
        'image': 'assets/loader.png',
        'location': 'Kano',
        'owner': 'Aminu Sani',
        'rating': '4.5'
      },
      {
        'name': 'Sprinkler',
        'price': 'NGN 3000/hour',
        'image': 'assets/sprinkler.png',
        'location': 'Kano',
        'owner': 'Maryam Ali',
        'rating': '4.1'
      },
      {
        'name': 'Baler',
        'price': 'NGN 7000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Abdullahi Sani',
        'rating': '4.4'
      },
      {
        'name': 'Rake',
        'price': 'NGN 3500/hour',
        'image': 'assets/rake.png',
        'location': 'Kano',
        'owner': 'Fatima Yusuf',
        'rating': '4.2'
      },
      {
        'name': 'Manure Spreader',
        'price': 'NGN 6000/hour',
        'image': 'assets/tractor.png',
        'location': 'Kano',
        'owner': 'Amina Musa',
        'rating': '4.3'
      },
      {
        'name': 'Planter',
        'price': 'NGN 6500/hour',
        'image': 'assets/seedplanter.png',
        'location': 'Kano',
        'owner': 'Hassan Bello',
        'rating': '4.4'
      },
      {
        'name': 'Thresher',
        'price': 'NGN 10000/hour',
        'image': 'assets/thresher.png',
        'location': 'Kano',
        'owner': 'Zainab Sani',
        'rating': '4.8'
      },
      {
        'name': 'Cultipacker',
        'price': 'NGN 4000/hour',
        'image': 'assets/tiller.png',
        'location': 'Kano',
        'owner': 'Maryam Yusuf',
        'rating': '4.1'
      },
      {
        'name': 'Farm Truck',
        'price': 'NGN 8000/hour',
        'image': 'assets/harvester.png',
        'location': 'Kano',
        'owner': 'Abdullahi Musa',
        'rating': '4.5'
      },
      {
        'name': 'Fertilizer Injecter',
        'price': 'NGN 4500/hour',
        'image': 'assets/fertilizer_injecter.png',
        'location': 'Kano',
        'owner': 'Aisha Ali',
        'rating': '4.2'
      },
      {
        'name': 'Mower',
        'price': 'NGN 3500/hour',
        'image': 'assets/mower.png',
        'location': 'Kano',
        'owner': 'Yusuf Sani',
        'rating': '4.0'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Multiple Equipment'),
        backgroundColor: Colors.green[700],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: allEquipment.length,
                itemBuilder: (context, index) {
                  final item = allEquipment[index];
                  final isSelected = selectedEquipment.any((e) => e['name'] == item['name']);
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: isSelected ? Colors.green[100] : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(
                            item['image']!,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item['price']!,
                                style: TextStyle(color: Colors.green[700]),
                              ),
                              Checkbox(
                                value: isSelected,
                                onChanged: (bool? value) {
                                  _toggleSelection(item, value ?? false);
                                },
                                activeColor: Colors.green[700],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _navigateToMultiPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Proceed to Payment', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
