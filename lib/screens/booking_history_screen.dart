// lib/screens/booking_history_screen.dart
import 'package:flutter/material.dart';
import 'booking_detail_screen.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    print('BookingHistoryScreen initialized at ${DateTime.now()}'); // Debug log
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
    print('BookingHistoryScreen disposed at ${DateTime.now()}'); // Debug log
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookings = [
      {
        'id': '1',
        'equipment': 'Tractor',
        'date': '2025-08-10',
        'status': 'Completed',
        'cost': 'NGN 8000',
        'location': 'Kano',
        'owner': 'John Doe',
        'duration': '2 hours',
        'details': 'Booked for plowing maize field. Equipment performed well.',
      },
      {
        'id': '2',
        'equipment': 'Thresher',
        'date': '2025-08-05',
        'status': 'Upcoming',
        'cost': 'NGN 10000',
        'location': 'Kano',
        'owner': 'Amina Bello',
        'duration': '3 hours',
        'details': 'Scheduled for rice threshing. Confirm with owner.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            print('Back arrow pressed at ${DateTime.now()}'); // Debug log
            Navigator.pop(context);
          },
        ),
        title: const Text('Booking History'),
        backgroundColor: Colors.green[700],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Adjust for AppBar space
              Expanded(
                child: ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetailScreen(booking: booking),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: booking['status'] == 'Completed' ? Colors.green[700] : Colors.amber[600],
                                child: Icon(
                                  booking['status'] == 'Completed' ? Icons.check_circle : Icons.schedule,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['equipment']!,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Date: ${booking['date']}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Status: ${booking['status']}',
                                      style: TextStyle(
                                        color: booking['status'] == 'Completed' ? Colors.green[700] : Colors.amber[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                booking['cost']!,
                                style: TextStyle(fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
