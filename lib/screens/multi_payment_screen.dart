// lib/screens/multi_payment_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_method_selection_screen.dart';

class MultiPaymentScreen extends StatefulWidget {
  final List<Map<String, String>> selectedEquipment;

  const MultiPaymentScreen({super.key, required this.selectedEquipment});

  @override
  _MultiPaymentScreenState createState() => _MultiPaymentScreenState();
}

class _MultiPaymentScreenState extends State<MultiPaymentScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _deliveryAddressController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  Map<String, TextEditingController> _durationControllers = {};
  double _totalAmount = 0.0;

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
    widget.selectedEquipment.forEach((item) {
      _durationControllers[item['name']!] = TextEditingController(text: '1');
    });
    _calculateTotal();
  }

  @override
  void dispose() {
    _controller.dispose();
    _deliveryAddressController.dispose();
    _notesController.dispose();
    _durationControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) _endDate = _startDate;
        } else {
          _endDate = picked;
        }
        _calculateHoursFromDates();
      });
    }
  }

  void _calculateHoursFromDates() {
    if (_startDate != null && _endDate != null) {
      final difference = _endDate!.difference(_startDate!).inHours;
      final minHours = _startDate!.day == _endDate!.day ? 1.0 : 12.0;
      final calculatedHours = difference > 0 ? difference.toDouble() : minHours;
      _durationControllers.values.forEach((controller) {
        controller.text = calculatedHours.toString();
      });
      _calculateTotal();
    }
  }

  void _calculateTotal() {
    double total = 0.0;
    widget.selectedEquipment.forEach((item) {
      final pricePerHour = double.tryParse(item['price']!.replaceAll('NGN ', '').replaceAll('/hour', '')) ?? 0.0;
      final duration = double.tryParse(_durationControllers[item['name']!]!.text) ?? 1.0;
      total += pricePerHour * duration;
    });
    setState(() {
      _totalAmount = total;
    });
  }

  void _navigateToPaymentMethod() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodSelectionScreen(
          selectedEquipment: widget.selectedEquipment,
          totalAmount: _totalAmount,
          deliveryAddress: _deliveryAddressController.text,
          notes: _notesController.text,
          startDate: _startDate,
          endDate: _endDate,
          durationControllers: _durationControllers,
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
        title: const Text('Review Order'),
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
                          'Review Your Order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Rental Start Date',
                              prefixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            child: Text(
                              _startDate == null ? 'Select Date' : DateFormat('yyyy-MM-dd').format(_startDate!),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Rental End Date',
                              prefixIcon: const Icon(Icons.calendar_today, color: Colors.green),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            child: Text(
                              _endDate == null ? 'Select Date' : DateFormat('yyyy-MM-dd').format(_endDate!),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Selected Equipment',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ...widget.selectedEquipment.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name']!,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Price: ${item['price']}',
                                        style: const TextStyle(fontSize: 16, color: Colors.green),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _durationControllers[item['name']!],
                                        decoration: InputDecoration(
                                          labelText: 'Duration (hours)',
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => _calculateTotal(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _deliveryAddressController,
                          decoration: InputDecoration(
                            labelText: 'Delivery Address',
                            prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          decoration: InputDecoration(
                            labelText: 'Additional Notes (optional)',
                            prefixIcon: const Icon(Icons.note, color: Colors.green),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Total Amount: NGN ${_totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _navigateToPaymentMethod,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[600],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            ),
                            child: const Text('Proceed to Payment', style: TextStyle(fontSize: 18)),
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
