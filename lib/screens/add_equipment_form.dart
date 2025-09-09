// lib/screens/add_equipment_form.dart
import 'package:flutter/material.dart';

class AddEquipmentForm extends StatefulWidget {
  const AddEquipmentForm({super.key});

  @override
  _AddEquipmentFormState createState() => _AddEquipmentFormState();
}

class _AddEquipmentFormState extends State<AddEquipmentForm> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController(text: 'Kano'); // Default for demo
  String _equipmentType = 'Tractor';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Hardcoded submission for demo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${_nameController.text} to equipment list')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green[200]!, Colors.white],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  const Text(
                    'Add New Equipment',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Form Fields
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Equipment Name',
                      prefixIcon: const Icon(Icons.agriculture, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter equipment name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _equipmentType,
                    decoration: InputDecoration(
                      labelText: 'Equipment Type',
                      prefixIcon: const Icon(Icons.category, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    items: ['Tractor', 'Thresher', 'Irrigation Pump'].map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _equipmentType = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select equipment type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price per Hour (NGN)',
                      prefixIcon: const Icon(Icons.monetization_on, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Add Equipment'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}