// lib/screens/payment_confirmation_screen_single.dart
import 'package:flutter/material.dart';
import 'payment_success_screen.dart';
import 'package:intl/intl.dart';

class PaymentConfirmationScreenSingle extends StatelessWidget {
  final String equipmentName;
  final String equipmentPrice;
  final double totalAmount;
  final String deliveryAddress;
  final String notes;
  final DateTime? startDate;
  final DateTime? endDate;
  final String duration;
  final String paymentMethod;

  const PaymentConfirmationScreenSingle({
    super.key,
    required this.equipmentName,
    required this.equipmentPrice,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.notes,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.paymentMethod,
  });

  void _navigateToSuccess(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentSuccessScreen(),
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
        title: const Text('Confirm Payment'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
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
                        'Confirm Your Payment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Order Details',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                equipmentName,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Price: $equipmentPrice x $duration hrs',
                                style: const TextStyle(fontSize: 16, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Delivery Address: $deliveryAddress',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rental Period: ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : 'Not set'} to ${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : 'Not set'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Notes: $notes',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Payment Method: $paymentMethod',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Amount: NGN ${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => _navigateToSuccess(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[600],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          ),
                          child: const Text('Confirm Payment', style: TextStyle(fontSize: 18)),
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
    );
  }
}
