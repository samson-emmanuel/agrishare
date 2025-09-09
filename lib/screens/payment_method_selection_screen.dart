// lib/screens/payment_method_selection_screen.dart
import 'package:flutter/material.dart';
import 'payment_confirmation_screen.dart';

class PaymentMethodSelectionScreen extends StatefulWidget {
  final List<Map<String, String>> selectedEquipment;
  final double totalAmount;
  final String deliveryAddress;
  final String notes;
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<String, TextEditingController> durationControllers;

  const PaymentMethodSelectionScreen({
    super.key,
    required this.selectedEquipment,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.durationControllers,
  });

  @override
  _PaymentMethodSelectionScreenState createState() => _PaymentMethodSelectionScreenState();
}

class _PaymentMethodSelectionScreenState extends State<PaymentMethodSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String _paymentMethod = 'Mobile Money';

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

  void _navigateToConfirmation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationScreen(
          selectedEquipment: widget.selectedEquipment,
          totalAmount: widget.totalAmount,
          deliveryAddress: widget.deliveryAddress,
          notes: widget.notes,
          startDate: widget.startDate,
          endDate: widget.endDate,
          durationControllers: widget.durationControllers,
          paymentMethod: _paymentMethod,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Select Payment Method'),
        backgroundColor: Colors.green[700],
      ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Image.asset('assets/agrishare_logo2.png', height: 80),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Choose Payment Method',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _paymentMethod,
                          decoration: InputDecoration(
                            labelText: 'Payment Method',
                            prefixIcon: const Icon(Icons.payment, color: Colors.green),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          items: ['Mobile Money', 'Bank Card', 'Cash on Delivery'].map((String method) {
                            return DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _paymentMethod = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Total Amount: NGN ${widget.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _navigateToConfirmation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[600],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            ),
                            child: const Text('Confirm Payment Method', style: TextStyle(fontSize: 18)),
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
    );
  }
}
