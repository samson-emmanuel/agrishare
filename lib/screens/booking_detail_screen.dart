import 'package:flutter/material.dart';

class BookingDetailScreen extends StatelessWidget {
  final Map<String, String> booking;

  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('${booking['equipment']} Booking Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[200]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green[700],
                        child: Icon(
                          Icons.agriculture,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDetailItem('Equipment', booking['equipment']!),
                    const Divider(),
                    _buildDetailItem('Date', booking['date']!),
                    const Divider(),
                    _buildDetailItem('Status', booking['status']!),
                    const Divider(),
                    _buildDetailItem('Cost', booking['cost']!),
                    const Divider(),
                    _buildDetailItem('Location', booking['location']!),
                    const Divider(),
                    _buildDetailItem('Owner', booking['owner']!),
                    const Divider(),
                    _buildDetailItem('Duration', booking['duration']!),
                    const Divider(),
                    _buildDetailItem('Details', booking['details']!),
                    const SizedBox(height: 20), // Replaced Spacer with padding
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(100, 36),
                        ),
                        child: const Text('Close', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}